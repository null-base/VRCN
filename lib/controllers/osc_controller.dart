import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/models/osc_models.dart';
import 'package:vrchat/provider/osc_settings_provider.dart';
import 'package:vrchat/services/osc_service.dart';
import 'package:vrchat/utils/app_logger.dart';

@immutable
class OscConnectionResult {
  const OscConnectionResult({
    required this.isConnected,
    required this.message,
  });

  final bool isConnected;
  final String message;
}

class OscController {
  const OscController(this.ref, this._oscService);

  final Ref ref;
  final OscService _oscService;

  Future<OscConnectionResult> connect() async {
    final settings = ref.read(oscSettingsProvider);
    try {
      await _oscService.sendTestMessage(settings);
      return OscConnectionResult(
        isConnected: true,
        message: '${settings.ipAddress}:${settings.port} に接続しました',
      );
    } catch (error) {
      return OscConnectionResult(
        isConnected: false,
        message: '接続エラー: $error',
      );
    }
  }

  Future<bool> checkConnection() async {
    try {
      await _oscService.sendTestMessage(ref.read(oscSettingsProvider));
      return true;
    } catch (error) {
      appLogger.d('テストメッセージエラー: $error');
      return false;
    }
  }

  Future<void> sendParameter({
    required OscParam param,
    required Object value,
  }) {
    return _oscService.sendParameter(
      settings: ref.read(oscSettingsProvider),
      param: param,
      value: value,
    );
  }

  Object defaultValueForType(OscParamType type) {
    return switch (type) {
      OscParamType.float => 0.0,
      OscParamType.int => 0,
      OscParamType.bool => false,
    };
  }

  OscParam createParam({
    required String name,
    required String address,
    required OscParamType type,
  }) {
    return OscParam(
      name: name,
      address: address,
      type: type,
      defaultValue: defaultValueForType(type),
    );
  }

  OscParam editParam({
    required OscParam current,
    required String name,
    required String address,
    required OscParamType type,
  }) {
    return OscParam(
      name: name,
      address: address,
      type: type,
      defaultValue: type == current.type
          ? current.defaultValue
          : defaultValueForType(type),
    );
  }

  void updateIpAddress(String ipAddress) {
    ref.read(oscSettingsProvider.notifier).updateIpAddress(ipAddress);
  }

  void updatePort(int port) {
    ref.read(oscSettingsProvider.notifier).updatePort(port);
  }

  void addParam(OscParam param) {
    ref.read(oscSettingsProvider.notifier).addParam(param);
  }

  void updateParam(int index, OscParam param) {
    ref.read(oscSettingsProvider.notifier).updateParam(index, param);
  }

  void removeParam(int index) {
    ref.read(oscSettingsProvider.notifier).removeParam(index);
  }
}

final oscControllerProvider = Provider<OscController>((ref) {
  return OscController(ref, const OscService());
});
