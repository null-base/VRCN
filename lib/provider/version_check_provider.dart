import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

// バージョンチェック結果を管理するプロバイダー
final versionCheckProvider = FutureProvider<VersionStatus?>((ref) async {
  try {
    final newVersionPlus = NewVersionPlus(
      iOSId: 'com.null-base.vrchat',
      androidId: 'com.nullbase.vrchat',
    );

    // 現在のバージョン情報を取得
    final packageInfo = await PackageInfo.fromPlatform();
    debugPrint('現在のバージョン: ${packageInfo.version}');

    // ストアから最新バージョン情報を取得
    final status = await newVersionPlus.getVersionStatus();

    if (status != null) {
      debugPrint('ストアの最新バージョン: ${status.storeVersion}');
      debugPrint('アップデート可能: ${status.canUpdate}');

      return status;
    }

    return null;
  } catch (e) {
    debugPrint('バージョンチェックエラー: $e');
    return null;
  }
});

final updateDialogShownProvider = StateProvider<bool>((ref) => false);
