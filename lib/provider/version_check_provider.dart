import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/provider/package_info_provider.dart';
import 'package:vrchat/utils/app_logger.dart';

@immutable
class AppVersionStatus {
  const AppVersionStatus({
    required this.localVersion,
    required this.storeVersion,
    required this.appStoreLink,
    this.releaseNotes,
  });
  final String localVersion;
  final String storeVersion;
  final String? releaseNotes;
  final String appStoreLink;

  bool get canUpdate => _compareVersions(storeVersion, localVersion) > 0;
}

final versionCheckProvider = FutureProvider<AppVersionStatus?>((ref) async {
  try {
    final packageInfo = await ref.watch(packageInfoProvider.future);
    appLogger.d('現在のバージョン: ${packageInfo.version}');
    return null;
  } catch (e) {
    appLogger.d('バージョンチェックエラー: $e');
    return null;
  }
});

final updateDialogShownProvider = StateProvider<bool>((ref) => false);

int _compareVersions(String left, String right) {
  final leftParts = left.split('.').map((value) => int.tryParse(value) ?? 0);
  final rightParts = right.split('.').map((value) => int.tryParse(value) ?? 0);
  final maxLength = leftParts.length > rightParts.length
      ? leftParts.length
      : rightParts.length;

  for (var index = 0; index < maxLength; index++) {
    final leftValue = index < leftParts.length ? leftParts.elementAt(index) : 0;
    final rightValue = index < rightParts.length
        ? rightParts.elementAt(index)
        : 0;
    if (leftValue != rightValue) {
      return leftValue.compareTo(rightValue);
    }
  }

  return 0;
}
