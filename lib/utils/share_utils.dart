import 'package:share_plus/share_plus.dart';
import 'package:vrchat/utils/app_logger.dart';

class ShareUtils {
  ShareUtils._();

  static Future<void> shareUrl(
    String url, {
    String? subject,
    String? title,
  }) async {
    try {
      await SharePlus.instance.share(
        ShareParams(uri: Uri.parse(url), subject: subject, title: title),
      );
    } catch (e) {
      appLogger.d('共有に失敗しました: $e');
    }
  }
}
