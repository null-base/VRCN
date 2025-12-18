import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/utils/cache_manager.dart';

class DownloadUtils {
  static Future<void> downloadFile({
    required BuildContext context,
    required String url,
    required String fileName,
    required Map<String, String> headers,
  }) async {
    // 早期にcontextのmountedをチェック
    if (!context.mounted) return;

    try {
      // プラットフォーム別権限チェック
      final hasPermission = await _checkAndRequestPermissions(context);
      if (!hasPermission || !context.mounted) {
        return;
      }

      // ダウンロード進行状況を表示
      _showDownloadDialog(context, fileName);

      // キャッシュから取得を試行
      final cachedFile = await JsonCacheManager().getFileFromCache(url);
      Uint8List? fileBytes;

      if (cachedFile != null) {
        fileBytes = await cachedFile.file.readAsBytes();
      } else {
        // キャッシュにない場合はダウンロード
        final dio = Dio();
        final response = await dio.get(
          url,
          options: Options(headers: headers, responseType: ResponseType.bytes),
        );
        fileBytes = Uint8List.fromList(response.data);
      }

      // ファイルを保存
      await _saveFile(fileBytes, fileName);

      if (context.mounted) {
        Navigator.of(context).pop(); // ダウンロードダイアログを閉じる
        _showSuccessSnackBar(context, t.download.success);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // ダウンロードダイアログを閉じる
        _showErrorSnackBar(context, t.download.failure(error: e.toString()));
      }
    }
  }

  static Future<void> shareFile({
    required BuildContext context,
    required String url,
    required String fileName,
    required Map<String, String> headers,
  }) async {
    if (!context.mounted) return;

    try {
      _showDownloadDialog(context, fileName, isShare: true);

      // キャッシュから取得を試行
      final cachedFile = await JsonCacheManager().getFileFromCache(url);
      File? fileToShare;

      if (cachedFile != null) {
        fileToShare = cachedFile.file;
      } else {
        // キャッシュにない場合は一時ファイルとしてダウンロード
        final dio = Dio();
        final tempDir = await getTemporaryDirectory();
        final tempFile = File(path.join(tempDir.path, fileName));

        await dio.download(
          url,
          tempFile.path,
          options: Options(headers: headers),
        );
        fileToShare = tempFile;
      }

      if (context.mounted) {
        Navigator.of(context).pop(); // ダウンロードダイアログを閉じる

        final params = ShareParams(files: [XFile(fileToShare.path)]);

        await SharePlus.instance.share(params);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // ダウンロードダイアログを閉じる
        _showErrorSnackBar(
          context,
          t.download.shareFailure(error: e.toString()),
        );
      }
    }
  }

  // プラットフォーム別権限チェック
  static Future<bool> _checkAndRequestPermissions(BuildContext context) async {
    if (!context.mounted) return false;

    if (Platform.isAndroid) {
      return await _checkAndroidPermissions(context);
    } else if (Platform.isIOS) {
      return await _checkIOSPermissions(context);
    }
    return true; // 他のプラットフォームでは権限チェックをスキップ
  }

  // Android権限チェック
  static Future<bool> _checkAndroidPermissions(BuildContext context) async {
    if (!context.mounted) return false;

    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;

      // Android 13 (API 33) 以上では写真への保存権限が必要
      if (androidInfo.version.sdkInt >= 33) {
        var permission = await Permission.photos.status;

        if (permission.isDenied) {
          permission = await Permission.photos.request();
        }

        if (permission.isPermanentlyDenied) {
          if (context.mounted) {
            _showPermissionDeniedDialog(context, t.download.permissionPhoto);
          }
          return false;
        }

        if (!permission.isGranted) {
          if (context.mounted) {
            _showErrorSnackBar(context, t.download.permissionPhotoRequired);
          }
          return false;
        }
      } else {
        // Android 12以下ではストレージ権限をチェック
        var permission = await Permission.storage.status;

        if (permission.isDenied) {
          permission = await Permission.storage.request();
        }

        if (permission.isPermanentlyDenied) {
          if (context.mounted) {
            _showPermissionDeniedDialog(context, t.download.permissionStorage);
          }
          return false;
        }

        if (!permission.isGranted) {
          if (context.mounted) {
            _showErrorSnackBar(context, t.download.permissionStorageRequired);
          }
          return false;
        }
      }

      return true;
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(
          context,
          t.download.permissionError(error: e.toString()),
        );
      }
      return false;
    }
  }

  // iOS権限チェック
  static Future<bool> _checkIOSPermissions(BuildContext context) async {
    if (!context.mounted) return false;

    try {
      // iOSでは写真ライブラリへの追加権限をチェック
      var permission = await Permission.photosAddOnly.status;

      if (permission.isDenied) {
        permission = await Permission.photosAddOnly.request();
      }

      // 権限が永続的に拒否されている場合
      if (permission.isPermanentlyDenied) {
        if (context.mounted) {
          _showPermissionDeniedDialog(
            context,
            t.download.permissionPhotoLibrary,
          );
        }
        return false;
      }

      // 権限が付与されていない場合
      if (!permission.isGranted) {
        if (context.mounted) {
          _showErrorSnackBar(
            context,
            t.download.permissionPhotoLibraryRequired,
          );
        }
        return false;
      }

      return true;
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(
          context,
          t.download.permissionError(error: e.toString()),
        );
      }
      return false;
    }
  }

  // 権限が永続的に拒否された場合のダイアログ
  static void _showPermissionDeniedDialog(
    BuildContext context,
    String permissionType,
  ) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              t.download.permissionTitle,
              style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
            ),
            content: Text(
              t.download.permissionDenied(permissionType: permissionType),
              style: GoogleFonts.notoSans(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  t.download.permissionCancel,
                  style: GoogleFonts.notoSans(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings(); // 設定アプリを開く
                },
                child: Text(
                  t.download.permissionOpenSettings,
                  style: GoogleFonts.notoSans(),
                ),
              ),
            ],
          ),
    );
  }

  static Future<void> _saveFile(Uint8List fileBytes, String fileName) async {
    if (Platform.isAndroid) {
      // Android: Downloads フォルダに保存（pathパッケージを使用）
      const storageRoot = '/storage/emulated/0';
      final downloadsPath = path.join(storageRoot, 'Download');
      final downloadsDir = Directory(downloadsPath);

      if (await downloadsDir.exists()) {
        final file = File(path.join(downloadsDir.path, fileName));
        await file.writeAsBytes(fileBytes);
      } else {
        // フォールバック: アプリのディレクトリに保存
        final appDir = await getExternalStorageDirectory();
        if (appDir != null) {
          final file = File(path.join(appDir.path, fileName));
          await file.writeAsBytes(fileBytes);
        }
      }
    } else if (Platform.isIOS) {
      // iOS: Documents フォルダに保存
      final documentsDir = await getApplicationDocumentsDirectory();
      final file = File(path.join(documentsDir.path, fileName));
      await file.writeAsBytes(fileBytes);
    }
  }

  static void _showDownloadDialog(
    BuildContext context,
    String fileName, {
    bool isShare = false,
  }) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  isShare
                      ? t.download.sharing(fileName: fileName)
                      : t.download.downloading(fileName: fileName),
                  style: GoogleFonts.notoSans(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
    );
  }

  static void _showSuccessSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message, style: GoogleFonts.notoSans()),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: GoogleFonts.notoSans())),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
