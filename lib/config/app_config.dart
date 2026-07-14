// lib/config/app_config.dart
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:vrchat/utils/app_logger.dart';

class AppConfig {
  AppConfig._();
  static FirebaseRemoteConfig? _remoteConfig;
  static var _initialized = false;

  /// Remote Configを初期化
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      _remoteConfig = FirebaseRemoteConfig.instance;

      // 設定を構成
      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: kDebugMode
              ? const Duration(minutes: 1) // デバッグ
              : const Duration(hours: 24), // リリース
        ),
      );

      await _remoteConfig!.fetchAndActivate();

      _initialized = true;
      appLogger.d('AppConfig初期化完了');
    } catch (e) {
      appLogger.d('AppConfig初期化エラー: $e');
      _initialized = false;
    }
  }

  static String get discordWebhookUrl {
    if (!_initialized || _remoteConfig == null) {
      return '';
    }

    try {
      return _remoteConfig!.getString('feedbackDiscordWebhookUrl');
    } catch (e) {
      appLogger.d('Discord Webhook URL取得エラー: $e');
      return '';
    }
  }

  static String get eventCalender {
    if (!_initialized || _remoteConfig == null) {
      return '';
    }

    try {
      return _remoteConfig!.getString('vrchatEventCalenderUrl');
    } catch (e) {
      appLogger.d('Event Calendar URL取得エラー: $e');
      return '';
    }
  }
}
