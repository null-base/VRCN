import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/analytics_repository.dart';
import 'package:vrchat/gen/strings.g.dart';

enum AppThemeMode {
  light, // ライトテーマ
  dark, // ダークテーマ
  system, // システム設定に従う
}

// アプリアイコンタイプ
enum AppIconType {
  nullbase, // あのめあ
  vrcn_icon,
  vrcn_logo,
  nullkalne, // カルネ
  annobu, // ラスク
  kazkiller,
  miyamoto, // しなの
  le0yuki, // 水瀬
  ray, //
  hare, // しなの
  aihuru, // ベルセリナ
  rea, // るるね
  masukawa, // 真央
  abuki, // 銀杏
  enadori, // マヌカ
  roize, // しなの
  r4in, // しなの
  etoeto, // イルネル
  pampy, // sio
  yume, // キプフェル
  kabi_lun, // Shuan
  sasami_st, // くうた
}

// アイコンマッピング
Map<AppIconType, String> appIconNameMap = {
  AppIconType.nullbase: 'default',
  AppIconType.vrcn_icon: 'vrcn_icon',
  AppIconType.vrcn_logo: 'vrcn_logo',
  AppIconType.nullkalne: 'nullkalne',
  AppIconType.annobu: 'annobu',
  AppIconType.kazkiller: 'kazkiller',
  AppIconType.miyamoto: 'miyamoto',
  AppIconType.le0yuki: 'le0yuki',
  AppIconType.ray: 'ray',
  AppIconType.hare: 'hare',
  AppIconType.aihuru: 'aihuru',
  AppIconType.rea: 'rea',
  AppIconType.masukawa: 'masukawa',
  AppIconType.abuki: 'abuki',
  AppIconType.enadori: 'enadori',
  AppIconType.roize: 'roize',
  AppIconType.r4in: 'r4in',
  AppIconType.etoeto: 'etoeto',
  AppIconType.pampy: 'pampy',
  AppIconType.yume: 'yume',
  AppIconType.kabi_lun: 'kabi_lun',
  AppIconType.sasami_st: 'sasami_st',
};

// 設定データモデル
@immutable
class AppSettings {
  final AppThemeMode themeMode;
  final bool loadImageOnWifi;
  final bool notifyNewFriendRequests;
  final bool notifyFriendOnline;
  final int maxFriendCache;
  final AppIconType appIcon;
  final String avatarSearchApiUrl;
  final bool allowNsfw;
  final bool enableEventReminders;
  final AppLocale locale;

  const AppSettings({
    this.themeMode = AppThemeMode.system,
    this.loadImageOnWifi = true,
    this.notifyNewFriendRequests = true,
    this.notifyFriendOnline = true,
    this.maxFriendCache = 500,
    this.appIcon = AppIconType.nullbase,
    this.avatarSearchApiUrl = '',
    this.allowNsfw = false,
    this.enableEventReminders = true,
    this.locale = AppLocale.ja,
  });

  // コピーと一部更新のためのメソッド
  AppSettings copyWith({
    AppThemeMode? themeMode,
    bool? loadImageOnWifi,
    bool? notifyNewFriendRequests,
    bool? notifyFriendOnline,
    int? maxFriendCache,
    AppIconType? appIcon,
    String? avatarSearchApiUrl,
    bool? allowNsfw,
    bool? enableEventReminders,
    AppLocale? locale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      loadImageOnWifi: loadImageOnWifi ?? this.loadImageOnWifi,
      notifyNewFriendRequests:
          notifyNewFriendRequests ?? this.notifyNewFriendRequests,
      notifyFriendOnline: notifyFriendOnline ?? this.notifyFriendOnline,
      maxFriendCache: maxFriendCache ?? this.maxFriendCache,
      appIcon: appIcon ?? this.appIcon,
      avatarSearchApiUrl: avatarSearchApiUrl ?? this.avatarSearchApiUrl,
      allowNsfw: allowNsfw ?? this.allowNsfw,
      enableEventReminders: enableEventReminders ?? this.enableEventReminders,
      locale: locale ?? this.locale,
    );
  }

  // SharedPreferencesへの保存用
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'loadImageOnWifi': loadImageOnWifi,
      'notifyNewFriendRequests': notifyNewFriendRequests,
      'notifyFriendOnline': notifyFriendOnline,
      'maxFriendCache': maxFriendCache,
      'appIcon': appIcon.index,
      'avatarSearchApiUrl': avatarSearchApiUrl,
      'allowNsfw': allowNsfw,
      'enableEventReminders': enableEventReminders,
      'locale': locale.languageCode,
    };
  }

  // SharedPreferencesからの読み込み用
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    var locale = AppLocale.ja;
    final localeString = json['locale'] as String?;

    if (localeString != null) {
      try {
        for (final supportedLocale in AppLocale.values) {
          if (supportedLocale.languageCode == localeString) {
            locale = supportedLocale;
            break;
          }
        }
      } catch (_) {
        locale = AppSettings._getDeviceLocale();
      }
    } else {
      locale = AppSettings._getDeviceLocale();
    }

    return AppSettings(
      themeMode: AppThemeMode.values[json['themeMode'] ?? 2],
      loadImageOnWifi: json['loadImageOnWifi'] ?? true,
      notifyNewFriendRequests: json['notifyNewFriendRequests'] ?? true,
      notifyFriendOnline: json['notifyFriendOnline'] ?? true,
      maxFriendCache: json['maxFriendCache'] ?? 500,
      appIcon:
          json['appIcon'] != null
              ? AppIconType.values[json['appIcon']]
              : AppIconType.nullbase,
      avatarSearchApiUrl: json['avatarSearchApiUrl'] ?? '',
      allowNsfw: json['allowNsfw'] ?? false,
      enableEventReminders: json['enableEventReminders'] ?? true,
      locale: locale,
    );
  }

  // 端末の言語を取得するヘルパーメソッド
  static AppLocale _getDeviceLocale() {
    try {
      final deviceLocale = AppLocaleUtils.findDeviceLocale();
      return deviceLocale;
    } catch (_) {
      return AppLocale.ja;
    }
  }
}

// 設定管理クラス
class SettingsNotifier extends StateNotifier<AppSettings> {
  final SharedPreferences prefs;

  SettingsNotifier(this.prefs) : super(const AppSettings()) {
    _loadSettings();
  }

  // 設定の読み込み
  Future<void> _loadSettings() async {
    try {
      final themeMode = prefs.getInt('themeMode') ?? 2;
      final loadImageOnWifi = prefs.getBool('loadImageOnWifi') ?? true;
      final notifyNewFriendRequests =
          prefs.getBool('notifyNewFriendRequests') ?? true;
      final notifyFriendOnline = prefs.getBool('notifyFriendOnline') ?? true;
      final maxFriendCache = prefs.getInt('maxFriendCache') ?? 500;
      final avatarSearchApiUrl = prefs.getString('avatarSearchApiUrl') ?? '';
      final appIconIndex = prefs.getInt('appIcon') ?? 0;
      final appIcon =
          appIconIndex < AppIconType.values.length
              ? AppIconType.values[appIconIndex]
              : AppIconType.nullbase;
      final allowNsfw = prefs.getBool('allowNsfw') ?? false;
      final enableEventReminders =
          prefs.getBool('enableEventReminders') ?? true;

      // 言語設定を読み込み
      final localeString = prefs.getString('locale');
      AppLocale locale;

      if (localeString != null) {
        try {
          locale = AppLocale.values.firstWhere(
            (l) => l.languageCode == localeString,
            orElse: _getDeviceLocale,
          );
        } catch (_) {
          locale = _getDeviceLocale();
        }
      } else {
        // 初回起動時は端末の言語を使用し、設定として保存
        locale = _getDeviceLocale();
        await prefs.setString('locale', locale.languageCode);
        await LocaleSettings.setLocale(locale);
      }

      state = AppSettings(
        themeMode: AppThemeMode.values[themeMode],
        loadImageOnWifi: loadImageOnWifi,
        notifyNewFriendRequests: notifyNewFriendRequests,
        notifyFriendOnline: notifyFriendOnline,
        maxFriendCache: maxFriendCache,
        appIcon: appIcon,
        avatarSearchApiUrl: avatarSearchApiUrl,
        allowNsfw: allowNsfw,
        enableEventReminders: enableEventReminders,
        locale: locale,
      );
    } catch (e) {
      final deviceLocale = _getDeviceLocale();
      state = AppSettings(locale: deviceLocale);
    }
  }

  // 端末の言語を取得するヘルパーメソッド
  static AppLocale _getDeviceLocale() {
    try {
      final deviceLocale = AppLocaleUtils.findDeviceLocale();
      return deviceLocale;
    } catch (_) {
      return AppLocale.ja;
    }
  }

  // テーマモード変更
  Future<void> setThemeMode(AppThemeMode mode) async {
    await prefs.setInt('themeMode', mode.index);
    state = state.copyWith(themeMode: mode);
  }

  // Wi-Fi接続時のみ画像読み込み設定変更
  Future<void> setLoadImageOnWifi(bool value) async {
    await prefs.setBool('loadImageOnWifi', value);
    state = state.copyWith(loadImageOnWifi: value);
  }

  // フレンドリクエスト通知設定変更
  Future<void> setNotifyNewFriendRequests(bool value) async {
    await prefs.setBool('notifyNewFriendRequests', value);
    state = state.copyWith(notifyNewFriendRequests: value);
  }

  // フレンドオンライン通知設定変更
  Future<void> setNotifyFriendOnline(bool value) async {
    await prefs.setBool('notifyFriendOnline', value);
    state = state.copyWith(notifyFriendOnline: value);
  }

  // キャッシュ最大数変更
  Future<void> setMaxFriendCache(int value) async {
    await prefs.setInt('maxFriendCache', value);
    state = state.copyWith(maxFriendCache: value);
  }

  // アプリアイコン変更
  Future<bool> setAppIcon(AppIconType iconType) async {
    try {
      final isSupported = await FlutterDynamicIconPlus.supportsAlternateIcons;
      if (!isSupported) {
        return false;
      }

      if (iconType == AppIconType.nullbase) {
        await FlutterDynamicIconPlus.setAlternateIconName(
          iconName: null,
          blacklistBrands: ['Redmi'],
          blacklistManufactures: ['Xiaomi'],
          blacklistModels: ['Redmi 200A'],
        );
      } else {
        final iconName = appIconNameMap[iconType];
        if (iconName != null) {
          await FlutterDynamicIconPlus.setAlternateIconName(
            iconName: iconName,
            blacklistBrands: ['Redmi'],
            blacklistManufactures: ['Xiaomi'],
            blacklistModels: ['Redmi 200A'],
          );
        }
      }

      await prefs.setInt('appIcon', iconType.index);
      state = state.copyWith(appIcon: iconType);

      final iconName = appIconNameMap[iconType] ?? 'default';
      final analytics = AnalyticsService();
      await analytics.logEvent(
        name: 'app_icon_changed',
        parameters: {'icon_type': iconName},
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  // アバター検索APIのURL変更
  Future<void> setAvatarSearchApiUrl(String url) async {
    await prefs.setString('avatarSearchApiUrl', url);
    state = state.copyWith(avatarSearchApiUrl: url);
  }

  // 不快なコンテンツ表示の同意設定変更
  Future<void> setAllowNsfw(bool allow) async {
    await prefs.setBool('allowNsfw', allow);
    state = state.copyWith(allowNsfw: allow);
  }

  // イベント通知設定変更
  Future<void> setEnableEventReminders(bool value) async {
    await prefs.setBool('enableEventReminders', value);
    state = state.copyWith(enableEventReminders: value);
  }

  // 言語変更メソッド
  Future<void> setLocale(AppLocale locale) async {
    await prefs.setString('locale', locale.languageCode);
    state = state.copyWith(locale: locale);
    await LocaleSettings.setLocale(locale);
  }

  // アイコン変更がサポートされているか確認
  Future<bool> isAppIconChangeSupported() async {
    try {
      final isSupported = await FlutterDynamicIconPlus.supportsAlternateIcons;
      debugPrint('アイコン変更サポート状態: $isSupported');
      return isSupported;
    } catch (e) {
      debugPrint('アイコン変更サポート確認中にエラー: $e');
      return false;
    }
  }
}

// SharedPreferencesプロバイダー
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Providerが初期化されていません');
});

// 設定プロバイダー
final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((
  ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsNotifier(prefs);
});

// ThemeModeプロバイダー
final themeModeProvider = Provider<ThemeMode>((ref) {
  final settings = ref.watch(settingsProvider);
  switch (settings.themeMode) {
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
      return ThemeMode.dark;
    case AppThemeMode.system:
      return ThemeMode.system;
  }
});
