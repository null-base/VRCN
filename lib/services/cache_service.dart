import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:vrchat/utils/app_logger.dart';

/// アプリのキャッシュを管理するサービスクラス
class CacheService {
  /// キャッシュのサイズを計算する
  Future<String> getCacheSize() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final appCacheDir = await getApplicationCacheDirectory();

      final cacheDirSize = await _calculateDirSize(cacheDir);
      final appCacheDirSize = await _calculateDirSize(appCacheDir);

      final totalSize = cacheDirSize + appCacheDirSize;

      // サイズを読みやすいフォーマットに変換
      return _formatSize(totalSize);
    } catch (e) {
      appLogger.d('キャッシュサイズ計算エラー: $e');
      return '計算できませんでした';
    }
  }

  /// キャッシュを削除する
  Future<bool> clearCache() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final appCacheDir = await getApplicationCacheDirectory();

      // 一時ディレクトリのファイルを削除
      if (await cacheDir.exists()) {
        await _deleteDirectoryContents(cacheDir);
      }

      // アプリキャッシュディレクトリのファイルを削除
      if (await appCacheDir.exists()) {
        await _deleteDirectoryContents(appCacheDir);
      }

      return true;
    } catch (e) {
      appLogger.d('キャッシュ削除エラー: $e');
      return false;
    }
  }

  /// ディレクトリ内のファイルサイズを計算する
  Future<int> _calculateDirSize(Directory dir) async {
    try {
      var totalSize = 0;
      final entities = await dir.list().toList();

      for (final entity in entities) {
        if (entity is File) {
          totalSize += await entity.length();
        } else if (entity is Directory) {
          totalSize += await _calculateDirSize(entity);
        }
      }

      return totalSize;
    } catch (e) {
      appLogger.d('ディレクトリサイズ計算エラー: $e');
      return 0;
    }
  }

  /// ディレクトリ内のファイルを削除する（ディレクトリ自体は維持）
  Future<void> _deleteDirectoryContents(Directory dir) async {
    try {
      final entities = await dir.list().toList();

      for (final entity in entities) {
        if (entity is File) {
          await entity.delete();
        } else if (entity is Directory) {
          await entity.delete(recursive: true);
        }
      }
    } catch (e) {
      appLogger.d('ディレクトリ内容削除エラー: $e');
    }
  }

  /// バイト数を読みやすい形式に変換する
  String _formatSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    var size = bytes.toDouble();

    while (size > 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }
}
