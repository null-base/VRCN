import 'package:favicon/favicon.dart';
import 'package:flutter/foundation.dart';

@immutable
class BioLinkData {
  const BioLinkData({
    required this.url,
    required this.domain,
    this.faviconUrl,
  });

  final String url;
  final String domain;
  final String? faviconUrl;
}

class BioLinkUtils {
  const BioLinkUtils._();

  static Future<List<BioLinkData>> loadAll(List<String> links) {
    return Future.wait(links.map(load));
  }

  static Future<BioLinkData> load(String link) async {
    try {
      final uri = Uri.parse(ensureHttpPrefix(link));
      final faviconUrl = await _bestFaviconUrl(link, uri);

      return BioLinkData(
        url: link,
        faviconUrl: faviconUrl,
        domain: uri.host,
      );
    } catch (_) {
      return BioLinkData(url: link, domain: extractDomain(link));
    }
  }

  static String ensureHttpPrefix(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    return 'https://$url';
  }

  static String extractDomain(String url) {
    var processedUrl = url.replaceAll(RegExp('https?://'), '');
    processedUrl = processedUrl.split('/')[0];
    processedUrl = processedUrl.split('?')[0].split('#')[0];
    return processedUrl;
  }

  static String truncateUrl(String url) {
    const maxLength = 40;
    return url.length > maxLength ? '${url.substring(0, maxLength)}...' : url;
  }

  static Future<String> _bestFaviconUrl(String link, Uri uri) async {
    try {
      final favicon = await FaviconFinder.getBest(link);
      if (favicon != null && favicon.url.isNotEmpty) {
        return favicon.url;
      }
    } catch (_) {}

    return '${uri.scheme}://${uri.host}/favicon.ico';
  }
}
