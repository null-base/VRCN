import 'package:vrchat/utils/url_launcher_utils.dart';

class ExternalLinkController {
  const ExternalLinkController();

  Future<void> launch(String url) {
    return UrlLauncherUtils.launchURL(url);
  }

  Future<void> launchExternal(String url) {
    return UrlLauncherUtils.launchExternalURL(url);
  }
}

const externalLinkController = ExternalLinkController();
