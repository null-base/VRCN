import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // 追加
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badge_control/flutter_app_badge_control.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrchat/analytics_repository.dart';
import 'package:vrchat/config/app_config.dart';
import 'package:vrchat/firebase_options.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/event_reminder_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/provider/streaming_provider.dart';
import 'package:vrchat/provider/version_check_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/router/app_router.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/update_dialog.dart';

// FCMバックグラウンドメッセージハンドラー
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase の初期化が必要
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  debugPrint('🔔 バックグラウンドメッセージを受信:');
  debugPrint('📱 Message ID: ${message.messageId}');
  debugPrint('📰 Title: ${message.notification?.title}');
  debugPrint('📝 Body: ${message.notification?.body}');
  debugPrint('📊 Data: ${message.data}');

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
    showWhen: true,
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
    message.hashCode,
    message.notification?.title ?? 'VRCNからの通知',
    message.notification?.body ?? 'メッセージを受信しました',
    notificationDetails,
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

  // App Check初期化
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
    appleProvider:
        kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
  );

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

  if (savedLocale != null) {
    // 保存された言語設定がある場合
    await LocaleSettings.setLocaleRaw(savedLocale);
  } else {
    // 初回起動時は端末の言語を使用し、設定として保存
    await LocaleSettings.useDeviceLocale();
    final currentLocale = LocaleSettings.currentLocale;
    await prefs.setString('locale', currentLocale.languageCode);
  }

  // 通知の初期化
  final notifications = await initializeNotifications();

  // デバッグ用.envファイルの読み込み
  if (kDebugMode) {
    await dotenv.load(fileName: '.env');
  }

  // 前回表示された通知の履歴を確認
  final launchDetails = await notifications.getNotificationAppLaunchDetails();
  if (launchDetails != null && launchDetails.didNotificationLaunchApp) {
    // 通知によってアプリが起動された場合
    debugPrint('通知からアプリが起動されました');
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
    debugPrint('リマインダーのクリーンアップ中にエラーが発生しました: $e');
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
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('🔔 ========== FCM設定情報 ==========');
    debugPrint('📱 通知権限ステータス: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('✅ 通知権限が許可されています');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('⚠️ 通知権限が仮許可されています');
    } else {
      debugPrint('❌ 通知権限が拒否されています');
    }

    // FCMトークンを取得してデバッグ出力

    final token = await messaging.getToken();
    debugPrint('🔑 FCMトークン: $token');

    // トークンの更新を監視
    messaging.onTokenRefresh.listen((newToken) {
      debugPrint('🔄 FCMトークンが更新されました: $newToken');
    });

    // フォアグラウンドメッセージを処理
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('📬 フォアグラウンドメッセージを受信:');
      debugPrint('📱 Message ID: ${message.messageId}');
      debugPrint('📰 Title: ${message.notification?.title}');
      debugPrint('📝 Body: ${message.notification?.body}');
      debugPrint('📊 Data: ${message.data}');

      // フォアグラウンドでもローカル通知を表示
      _showLocalNotification(message);
      _handleFcmMessageUrl(message.data);
    });

    // アプリが終了状態から通知タップで起動された場合
    messaging.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint('🚀 アプリが通知から起動されました:');
        debugPrint('📱 Message ID: ${message.messageId}');
        debugPrint('📊 Data: ${message.data}');

        _handleFcmMessageUrl(message.data);
      }
    });

    // アプリがバックグラウンドから通知タップで復帰した場合
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('📱 バックグラウンドから通知タップで復帰:');
      debugPrint('📱 Message ID: ${message.messageId}');
      debugPrint('📊 Data: ${message.data}');

      _handleFcmMessageUrl(message.data);
    });

    debugPrint('🔔 ========== FCM初期化完了 ==========');
  } catch (e) {
    debugPrint('❌ FCM初期化エラー: $e');
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
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  // 初期化設定
  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  // 通知が届いたときやタップされたときの処理を設定
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
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

  debugPrint('🔔 通知がタップされました: ${details.payload}');

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
      debugPrint('🔗 通知からURLを開きます: $url');

      // URLを開く（外部ブラウザで開く）
      Future.microtask(() async {
        final success = await UrlLauncherUtils.launchURL(
          url,
          mode: LaunchMode.externalApplication,
        );
        if (!success) {
          debugPrint('❌ URLを開けませんでした: $url');
        }
      });
    }
  } catch (e) {
    debugPrint('❌ 通知データの解析エラー: $e');
  }
}

void _handleFcmMessageUrl(Map<String, dynamic> data) {
  final url = data['url'] as String?;
  if (url != null && url.isNotEmpty) {
    debugPrint('🔗 FCMメッセージからURLを開きます: $url');

    // URLを開く
    Future.microtask(() async {
      final success = await UrlLauncherUtils.launchURL(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!success) {
        debugPrint('❌ URLを開けませんでした: $url');
      }
    });
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

  @override
  void initState() {
    super.initState();
    // ライフサイクルオブザーバーとして登録
    WidgetsBinding.instance.addObserver(this);

    _initAppLinks();
  }

  void _initAppLinks() async {
    _appLinks = AppLinks();

    // アプリ起動時のリンク処理
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleIncomingLink(initialLink);
    }

    // アプリ実行中のリンク処理
    _appLinks.uriLinkStream.listen(_handleIncomingLink);
  }

  void _handleIncomingLink(Uri uri) {
    if (uri.scheme == 'vrcn' && uri.host == 'avatar-api') {
      final apiUrl = uri.queryParameters['url'];
      if (apiUrl != null && apiUrl.isNotEmpty) {
        ref.read(settingsProvider.notifier).setAvatarSearchApiUrl(apiUrl);
      }
    }
  }

  @override
  void dispose() {
    // ライフサイクルオブザーバーの登録解除
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // アプリのライフサイクル状態変化を監視
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // アプリがフォアグラウンドに戻ったらバッジをクリア
      FlutterAppBadgeControl.removeBadge();
      debugPrint('アプリがフォアグラウンドに戻りました: 通知バッジをクリア');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isInitializing = ref.watch(apiInitializingProvider);
    final themeMode = ref.watch(themeModeProvider);

    final analytics = ref.watch(analyticsRepository);

    // アプリ起動時の分析記録
    if (!kDebugMode) {
      // アプリ開いたとき
      analytics.logAppOpen();

      Future.microtask(() async {
        final packageInfo = await PackageInfo.fromPlatform();
        await FirebaseAnalytics.instance.setUserProperty(
          name: 'app_version',
          value: packageInfo.version,
        );
      });
    }

    // バージョンチェックと更新ダイアログの表示
    ref.listen<AsyncValue<VersionStatus?>>(versionCheckProvider, (
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
                builder:
                    (context) => UpdateDialog(versionStatus: versionStatus),
              );
            }
          });
        }
      });
    });

    // APIの初期化を開始
    ref.watch(vrchatProvider);

    // 認証状態を監視してストリーミング接続を開始
    final authState = ref.watch(authStateProvider);
    authState.whenData((isLoggedIn) {
      if (isLoggedIn) {
        // ログイン済みならストリーミングコントローラーを使用して接続を開始
        Future.microtask(
          () => ref.read(streamingControllerProvider).startConnection(),
        );

        // ログイン後にバージョンチェックを実行
        Future.microtask(() {
          ref.read(versionCheckProvider);
        });
      }
    });

    // 初期化中はローディング画面、完了後は通常のルーターを使用
    if (isInitializing) {
      return _buildApp(themeMode: themeMode, home: const LoadingIndicator());
    }

    // 自動ログイン試行
    ref.watch(autoLoginProvider);

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
