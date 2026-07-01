import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/snack_bar_utils.dart';

class DownloadUtils {
  static Future<void> shareFile({
    required BuildContext context,
    required String url,
    required String fileName,
    required Map<String, String> headers,
  }) async {
    if (!context.mounted) return;

    try {
      _showDownloadDialog(context, fileName);

      final fileToShare = await _getShareableFile(
        url: url,
        fileName: fileName,
        headers: headers,
      );

      if (context.mounted) {
        Navigator.of(context).pop(); // ダウンロードダイアログを閉じる

        final params = ShareParams(files: [XFile(fileToShare.path)]);

        await SharePlus.instance.share(params);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // ダウンロードダイアログを閉じる
        SnackBarUtils.showError(
          context,
          t.download.shareFailure(error: e.toString()),
        );
      }
    }
  }

  static Future<File> _getShareableFile({
    required String url,
    required String fileName,
    required Map<String, String> headers,
  }) async {
    final cachedFile = await JsonCacheManager().getFileFromCache(url);
    if (cachedFile != null) return cachedFile.file;

    final dio = Dio();
    final tempDir = await getTemporaryDirectory();
    final tempFile = File(path.join(tempDir.path, fileName));

    await dio.download(
      url,
      tempFile.path,
      options: Options(headers: headers),
    );

    return tempFile;
  }

  static void _showDownloadDialog(BuildContext context, String fileName) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              t.download.sharing(fileName: fileName),
              style: GoogleFonts.notoSans(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static String getFileExtension(String url) {
    if (url.contains('.png')) return '.png';
    if (url.contains('.jpg') || url.contains('.jpeg')) return '.jpg';
    if (url.contains('.gif')) return '.gif';
    if (url.contains('.webp')) return '.webp';
    return '.png'; // デフォルト
  }
}
