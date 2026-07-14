import 'package:url_launcher/url_launcher.dart';
import 'package:vrchat/utils/app_logger.dart';

class UrlLauncherUtils {
  UrlLauncherUtils._();

  static Future<bool> launchURL(
    String urlString, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      final url = Uri.parse(urlString);
      final launched = await launchUrl(url, mode: mode);
      if (!launched) {
        appLogger.d('URLを開けませんでした: $urlString');
      }

      return launched;
    } catch (e) {
      appLogger.d('URL起動エラー: $e');
      return false;
    }
  }

  static Future<bool> launchExternalURL(String urlString) {
    return launchURL(urlString, mode: LaunchMode.externalApplication);
  }
}
