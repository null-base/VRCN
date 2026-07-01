import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // 追加
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrchat/analytics_repository.dart';
import 'package:vrchat/config/app_config.dart';
import 'package:vrchat/firebase_options.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/event_reminder_provider.dart';
import 'package:vrchat/provider/package_info_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/provider/streaming_provider.dart';
import 'package:vrchat/provider/version_check_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/router/app_router.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/update_dialog.dart';
import 'package:vrchat/utils/app_logger.dart';

// FCMバックグラウンドメッセージハンドラー
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase の初期化が必要
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  appLogger.d('🔔 バックグラウンドメッセージを受信:');
  appLogger.d('📱 Message ID: ${message.messageId}');
  appLogger.d('📰 Title: ${message.notification?.title}');
  appLogger.d('📝 Body: ${message.notification?.body}');
  appLogger.d('📊 Data: ${message.data}');

  // バックグラウンドでローカル通知を表示
  await _showLocalNotification(message);
}

// ローカル通知を表示するヘルパー関数
Future<void> _showLocalNotification(RemoteMessage message) async {
  const androidDetails = AndroidNotificationDetails(
    'fcm_default_channel',
    'FCM通知',
    channelDescription: 'Firebase Cloud Messagingからの通知',
    importance: Importance.high,
    priority: Priority.high,
  );

  const notificationDetails = NotificationDetails(
    android: androidDetails,
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  final notifications = FlutterLocalNotificationsPlugin();

  await notifications.show(
    id: message.hashCode,
    title: message.notification?.title ?? 'VRCNからの通知',
    body: message.notification?.body ?? 'メッセージを受信しました',
    notificationDetails: notificationDetails,
    payload: message.data.toString(),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // スプラッシュ画面
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Google Fontsの設定
  GoogleFonts.config.allowRuntimeFetching = kDebugMode;

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FCMバックグラウンドメッセージハンドラーを設定
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // クラッシュハンドラ
  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // FCMの初期化とデバッグ情報表示
  await _initializeFCM();

  // AppConfig初期化（Firebase初期化後）
  await AppConfig.initialize();

  // システムUIの設定
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // システムの向き指定 - 縦向きに固定
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // SharedPreferencesの初期化
  final prefs = await SharedPreferences.getInstance();

  // 言語設定
  final savedLocale = prefs.getString('locale');
  final hasLocaleOverride = prefs.getBool('localeOverride') ?? false;

  if (hasLocaleOverride && savedLocale != null) {
    // ユーザーが明示的に選択した言語設定がある場合
    await LocaleSettings.setLocaleRaw(savedLocale);
  } else {
    // 端末の言語を優先する。未対応言語の場合は slang の baseLocale(en) に戻る。
    await LocaleSettings.useDeviceLocale();
    await prefs.remove('locale');
  }

  // 通知の初期化
  final notifications = await initializeNotifications();

  // 前回表示された通知の履歴を確認
  final launchDetails = await notifications.getNotificationAppLaunchDetails();
  if (launchDetails != null && launchDetails.didNotificationLaunchApp) {
    // 通知によってアプリが起動された場合
    appLogger.d('通知からアプリが起動されました');
    if (launchDetails.notificationResponse != null) {
      _handleNotificationResponse(launchDetails.notificationResponse!);
    }
  }

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      localNotificationsProvider.overrideWithValue(notifications),
    ],
  );

  try {
    await container.read(eventReminderProvider.notifier).cleanupOldReminders();
  } catch (e) {
    appLogger.d('リマインダーのクリーンアップ中にエラーが発生しました: $e');
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(child: const VRChatApp()),
    ),
  );
}

/// FCMの初期化とデバッグ情報表示
Future<void> _initializeFCM() async {
  final messaging = FirebaseMessaging.instance;

  try {
    // 通知権限をリクエスト
    final settings = await messaging.requestPermission(
      announcement: false,
    );

    appLogger.d('🔔 ========== FCM設定情報 ==========');
    appLogger.d('📱 通知権限ステータス: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      appLogger.d('✅ 通知権限が許可されています');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      appLogger.d('⚠️ 通知権限が仮許可されています');
    } else {
      appLogger.d('❌ 通知権限が拒否されています');
    }

    // FCMトークンを取得してデバッグ出力

    final token = await messaging.getToken();
    appLogger.d('🔑 FCMトークン: $token');

    // トークンの更新を監視
    messaging.onTokenRefresh.listen((newToken) {
      appLogger.d('🔄 FCMトークンが更新されました: $newToken');
    });

    // フォアグラウンドメッセージを処理
    FirebaseMessaging.onMessage.listen((message) {
      appLogger.d('📬 フォアグラウンドメッセージを受信:');
      appLogger.d('📱 Message ID: ${message.messageId}');
      appLogger.d('📰 Title: ${message.notification?.title}');
      appLogger.d('📝 Body: ${message.notification?.body}');
      appLogger.d('📊 Data: ${message.data}');

      // フォアグラウンドでもローカル通知を表示
      _showLocalNotification(message);
      _handleFcmMessageUrl(message.data);
    });

    // アプリが終了状態から通知タップで起動された場合
    messaging.getInitialMessage().then((message) {
      if (message != null) {
        appLogger.d('🚀 アプリが通知から起動されました:');
        appLogger.d('📱 Message ID: ${message.messageId}');
        appLogger.d('📊 Data: ${message.data}');

        _handleFcmMessageUrl(message.data);
      }
    });

    // アプリがバックグラウンドから通知タップで復帰した場合
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      appLogger.d('📱 バックグラウンドから通知タップで復帰:');
      appLogger.d('📱 Message ID: ${message.messageId}');
      appLogger.d('📊 Data: ${message.data}');

      _handleFcmMessageUrl(message.data);
    });

    appLogger.d('🔔 ========== FCM初期化完了 ==========');
  } catch (e) {
    appLogger.d('❌ FCM初期化エラー: $e');
  }
}

/// 通知の初期化
Future<FlutterLocalNotificationsPlugin> initializeNotifications() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Android設定
  const initializationSettingsAndroid = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  // iOS設定
  const initializationSettingsIOS = DarwinInitializationSettings(
    requestBadgePermission: true,
  );

  // 初期化設定
  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  // 通知が届いたときやタップされたときの処理を設定
  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
    onDidReceiveNotificationResponse: _handleNotificationResponse,
  );

  // FCM用のAndroid通知チャンネルを作成
  const channel = AndroidNotificationChannel(
    'fcm_default_channel',
    'FCM通知',
    description: 'Firebase Cloud Messagingからの通知',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  return flutterLocalNotificationsPlugin;
}

/// 通知応答ハンドラ
void _handleNotificationResponse(NotificationResponse details) {
  final notificationId = details.id ?? -1;
  if (notificationId != -1) {
    // プロバイダーコンテナを取得し、リマインダーを削除
    final container = ProviderContainer();
    container
        .read(eventReminderProvider.notifier)
        .removeReminderByNotificationId(notificationId);
  }

  appLogger.d('🔔 通知がタップされました: ${details.payload}');

  _handleNotificationUrl(details.payload);
}

void _handleNotificationUrl(String? payload) {
  if (payload == null || payload.isEmpty) return;

  try {
    // payloadをMapとして解析
    final data = <String, dynamic>{};

    // payload文字列からデータを抽出（FCMのdataは文字列として渡される）
    if (payload.startsWith('{') && payload.endsWith('}')) {
      // JSON形式の場合
      final jsonData = jsonDecode(payload) as Map<String, dynamic>;
      data.addAll(jsonData);
    } else {
      // key=value形式の場合（FCMのデフォルト形式）
      final pairs = payload.split(', ');
      for (final pair in pairs) {
        if (pair.contains('=')) {
          final parts = pair.split('=');
          if (parts.length == 2) {
            data[parts[0].trim()] = parts[1].trim();
          }
        }
      }
    }

    // urlキーが存在する場合、URLを開く
    final url = data['url'] as String?;
    if (url != null && url.isNotEmpty) {
      unawaited(_launchExternalUrl(url, source: '通知'));
    }
  } catch (e) {
    appLogger.d('❌ 通知データの解析エラー: $e');
  }
}

void _handleFcmMessageUrl(Map<String, dynamic> data) {
  final url = data['url'] as String?;
  if (url != null && url.isNotEmpty) {
    unawaited(_launchExternalUrl(url, source: 'FCMメッセージ'));
  }
}

Future<void> _launchExternalUrl(
  String url, {
  required String source,
}) async {
  appLogger.d('$sourceからURLを開きます: $url');

  final success = await UrlLauncherUtils.launchURL(
    url,
    mode: LaunchMode.externalApplication,
  );
  if (!success) {
    appLogger.d('URLを開けませんでした: $url');
  }
}

class VRChatApp extends ConsumerStatefulWidget {
  const VRChatApp({super.key});

  @override
  ConsumerState<VRChatApp> createState() => _VRChatAppState();
}

class _VRChatAppState extends ConsumerState<VRChatApp>
    with WidgetsBindingObserver {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _appLinkSubscription;
  ProviderSubscription<AsyncValue<bool>>? _authStateSubscription;
  var _didStartLoggedInTasks = false;

  @override
  void initState() {
    super.initState();
    // ライフサイクルオブザーバーとして登録
    WidgetsBinding.instance.addObserver(this);

    _initAppLinks();
    _recordAppOpenAnalytics();
    _authStateSubscription = ref.listenManual<AsyncValue<bool>>(
      appAuthStateProvider,
      (previous, next) => _handleAuthState(next),
      fireImmediately: true,
    );
  }

  Future<void> _initAppLinks() async {
    _appLinks = AppLinks();

    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handleIncomingLink(initialLink);
      }
    } catch (error) {
      appLogger.d('初期リンクの取得に失敗しました: $error');
    }

    _appLinkSubscription = _appLinks.uriLinkStream.listen(
      _handleIncomingLink,
      onError: (Object error) {
        appLogger.d('リンクストリームの処理に失敗しました: $error');
      },
    );
  }

  Future<void> _recordAppOpenAnalytics() async {
    if (kDebugMode) return;

    final analytics = ref.read(analyticsRepository);
    analytics.logAppOpen();

    final packageInfo = await ref.read(packageInfoProvider.future);
    await FirebaseAnalytics.instance.setUserProperty(
      name: 'app_version',
      value: packageInfo.version,
    );
  }

  void _handleIncomingLink(Uri uri) {
    if (uri.scheme == 'vrcn' && uri.host == 'avatar-api') {
      final apiUrl = uri.queryParameters['url'];
      if (apiUrl != null && apiUrl.isNotEmpty) {
        ref.read(settingsProvider.notifier).setAvatarSearchApiUrl(apiUrl);
      }
    }
  }

  void _handleAuthState(AsyncValue<bool> authState) {
    authState.whenData((isLoggedIn) {
      if (isLoggedIn && !_didStartLoggedInTasks) {
        _didStartLoggedInTasks = true;
        ref.read(streamingControllerProvider).startConnection();
        ref.read(versionCheckProvider);
      } else if (!isLoggedIn) {
        _didStartLoggedInTasks = false;
      }
    });
  }

  @override
  void dispose() {
    // ライフサイクルオブザーバーの登録解除
    _authStateSubscription?.close();
    _appLinkSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // アプリのライフサイクル状態変化を監視
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      appLogger.d('アプリがフォアグラウンドに戻りました');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isInitializing = ref.watch(apiInitializingProvider);
    final themeMode = ref.watch(themeModeProvider);

    // バージョンチェックと更新ダイアログの表示
    ref.listen<AsyncValue<AppVersionStatus?>>(versionCheckProvider, (
      previous,
      next,
    ) {
      next.whenData((versionStatus) {
        if (versionStatus != null &&
            versionStatus.canUpdate &&
            !ref.read(updateDialogShownProvider)) {
          // ダイアログ表示済みフラグを設定
          ref.read(updateDialogShownProvider.notifier).state = true;

          // 少し遅延を入れてダイアログを表示
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (context.mounted) {
              showDialog(
                context: context,
                builder: (context) =>
                    UpdateDialog(versionStatus: versionStatus),
              );
            }
          });
        }
      });
    });

    // APIの初期化を開始
    ref.watch(vrchatProvider);

    // 初期化中はローディング画面、完了後は通常のルーターを使用
    if (isInitializing) {
      return _buildApp(themeMode: themeMode, home: const LoadingIndicator());
    }

    // ルーターベースのアプリを構築
    final router = ref.watch(routerProvider);
    return _buildApp(themeMode: themeMode, useRouter: true, router: router);
  }

  /// アプリの共通設定を構築
  MaterialApp _buildApp({
    required ThemeMode themeMode,
    Widget? home,
    bool useRouter = false,
    GoRouter? router,
  }) {
    // 共通の設定
    MediaQuery appBuilder(BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: const TextScaler.linear(1)),
        child: child!,
      );
    }

    // ルーター使用かホーム画面使用かで分岐
    if (useRouter && router != null) {
      return MaterialApp.router(
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        routerConfig: router,
        builder: appBuilder,
      );
    }

    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: SafeArea(child: home ?? const SizedBox.shrink()),
      builder: appBuilder,
    );
  }
}
