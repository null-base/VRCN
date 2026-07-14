import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vrchat/config/app_config.dart';
import 'package:vrchat/provider/package_info_provider.dart';
import 'package:vrchat/utils/app_logger.dart';

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  return FeedbackService(ref);
});

@immutable
class FeedbackService {
  const FeedbackService(this.ref);
  final Ref ref;

  Future<bool> sendFeedback({
    required String type,
    required String title,
    required String description,
    String? additionalInfo,
  }) async {
    try {
      // アプリ情報を取得
      final packageInfo = await ref.read(packageInfoProvider.future);
      // デバイス情報を取得
      final deviceInfo = await _getPlatformInfo();

      // Discord Embedを作成
      final embed = {
        'title': '🎯 新しいフィードバック: $title',
        'description': description,
        'color': _getColorForType(type),
        'timestamp': DateTime.timestamp().toIso8601String(),
        'fields': [
          {'name': '📋 フィードバックタイプ', 'value': type, 'inline': true},
          {
            'name': '📱 アプリバージョン',
            'value': '${packageInfo.version} (${packageInfo.buildNumber})',
            'inline': false,
          },
          {'name': '🖥️ プラットフォーム', 'value': deviceInfo, 'inline': true},
          if (additionalInfo != null && additionalInfo.isNotEmpty)
            {'name': '📝 追加情報', 'value': additionalInfo, 'inline': false},
        ],
      };

      final payload = {
        'embeds': [embed],
      };

      final response = await http.post(
        Uri.parse(AppConfig.discordWebhookUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 204) {
        appLogger.d('フィードバック送信成功');
        return true;
      } else {
        appLogger.d('フィードバック送信失敗: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      appLogger.d('フィードバック送信エラー: $e');
      return false;
    }
  }

  Future<String> _getPlatformInfo() async {
    try {
      return 'OS: ${Platform.operatingSystem}\n'
          'バージョン: ${Platform.operatingSystemVersion}\n'
          'ターゲット: ${defaultTargetPlatform.name}';
    } catch (e) {
      return '${defaultTargetPlatform.name}\n'
          'プラットフォーム情報取得エラー: ${e}';
    }
  }

  int _getColorForType(String type) {
    switch (type) {
      case 'バグ報告':
        return 0xFF0000; // 赤
      case '機能要望':
        return 0x00FF00; // 緑
      case '改善提案':
        return 0x0099FF; // 青
      case 'その他':
        return 0xFFFF00; // 黄
      default:
        return 0x808080; // グレー
    }
  }
}
