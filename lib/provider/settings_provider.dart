import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

AppLocale _parseLocalePreference(String? value) {
  if (value == null) {
    return AppLocale.en;
  }

  try {
    return AppLocaleUtils.parse(value);
  } catch (_) {
    return AppLocale.en;
  }
}

String _localePreferenceValue(AppLocale locale) {
  return locale.flutterLocale.toLanguageTag();
}

// 設定データモデル
@immutable
class AppSettings {
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
    this.locale = AppLocale.en,
  });

  // SharedPreferencesからの読み込み用
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final localeString = json['locale'] as String?;
    final themeModeIndex = json['themeMode'] as int? ?? 2;
    final appIconIndex = json['appIcon'] as int?;

    return AppSettings(
      themeMode: AppThemeMode.values[themeModeIndex],
      loadImageOnWifi: json['loadImageOnWifi'] as bool? ?? true,
      notifyNewFriendRequests: json['notifyNewFriendRequests'] as bool? ?? true,
      notifyFriendOnline: json['notifyFriendOnline'] as bool? ?? true,
      maxFriendCache: json['maxFriendCache'] as int? ?? 500,
      appIcon: appIconIndex != null
          ? AppIconType.values[appIconIndex]
          : AppIconType.nullbase,
      avatarSearchApiUrl: json['avatarSearchApiUrl'] as String? ?? '',
      allowNsfw: json['allowNsfw'] as bool? ?? false,
      enableEventReminders: json['enableEventReminders'] as bool? ?? true,
      locale: _parseLocalePreference(localeString),
    );
  }
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
      'locale': _localePreferenceValue(locale),
    };
  }
}

// 設定管理クラス
class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier(this.prefs) : super(const AppSettings()) {
    _loadSettings();
  }
  final SharedPreferences prefs;

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
      final appIcon = appIconIndex < AppIconType.values.length
          ? AppIconType.values[appIconIndex]
          : AppIconType.nullbase;
      final allowNsfw = prefs.getBool('allowNsfw') ?? false;
      final enableEventReminders =
          prefs.getBool('enableEventReminders') ?? true;

      // 言語設定を読み込み
      final localeString = prefs.getString('locale');
      final hasLocaleOverride = prefs.getBool('localeOverride') ?? false;
      AppLocale locale;

      if (hasLocaleOverride && localeString != null) {
        locale = _parseLocalePreference(localeString);
        await LocaleSettings.setLocale(locale);
      } else {
        locale = await LocaleSettings.useDeviceLocale();
        await prefs.remove('locale');
        await prefs.remove('localeOverride');
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
      state = const AppSettings();
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
    return false;
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
    await prefs.setBool('localeOverride', true);
    await prefs.setString('locale', _localePreferenceValue(locale));
    state = state.copyWith(locale: locale);
    await LocaleSettings.setLocale(locale);
  }

  // アイコン変更がサポートされているか確認
  Future<bool> isAppIconChangeSupported() async {
    return false;
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
