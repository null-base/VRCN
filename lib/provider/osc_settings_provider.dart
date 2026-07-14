import 'dart:convert';

import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/models/osc_models.dart';
import 'package:vrchat/provider/settings_provider.dart';

final oscSettingsProvider =
    StateNotifierProvider<OscSettingsNotifier, OscSettings>((ref) {
      final prefs = ref.watch(sharedPreferencesProvider);
      return OscSettingsNotifier(prefs);
    });

class OscSettingsNotifier extends StateNotifier<OscSettings> {
  OscSettingsNotifier(this.prefs) : super(const OscSettings()) {
    _loadSettings();
  }

  final SharedPreferences prefs;

  Future<void> _loadSettings() async {
    final settingsJson = prefs.getString('osc_settings');
    if (settingsJson != null) {
      try {
        final decoded = jsonDecode(settingsJson);
        state = decoded is Map<String, Object?>
            ? OscSettings.fromJson(decoded)
            : const OscSettings();
      } catch (_) {
        state = const OscSettings();
      }
    } else {
      state = const OscSettings(savedParams: _defaultParams);
    }
  }

  Future<void> saveSettings() async {
    await prefs.setString('osc_settings', jsonEncode(state.toJson()));
  }

  void updateIpAddress(String ipAddress) {
    state = state.copyWith(ipAddress: ipAddress);
    saveSettings();
  }

  void updatePort(int port) {
    state = state.copyWith(port: port);
    saveSettings();
  }

  void addParam(OscParam param) {
    state = state.copyWith(savedParams: [...state.savedParams, param]);
    saveSettings();
  }

  void updateParam(int index, OscParam param) {
    final newParams = [...state.savedParams];
    newParams[index] = param;
    state = state.copyWith(savedParams: newParams);
    saveSettings();
  }

  void removeParam(int index) {
    final newParams = [...state.savedParams]..removeAt(index);
    state = state.copyWith(savedParams: newParams);
    saveSettings();
  }
}

const _defaultParams = [
  OscParam(
    name: '表情 - 喜び',
    address: '/avatar/parameters/VRCFaceBlendH/Joy',
    type: OscParamType.float,
    defaultValue: 0.0,
  ),
  OscParam(
    name: '表情 - 悲しみ',
    address: '/avatar/parameters/VRCFaceBlendH/Sorrow',
    type: OscParamType.float,
    defaultValue: 0.0,
  ),
  OscParam(
    name: '表情 - 驚き',
    address: '/avatar/parameters/VRCFaceBlendH/Surprise',
    type: OscParamType.float,
    defaultValue: 0.0,
  ),
  OscParam(
    name: '表情 - 怒り',
    address: '/avatar/parameters/VRCFaceBlendH/Anger',
    type: OscParamType.float,
    defaultValue: 0.0,
  ),
  OscParam(
    name: 'ジェスチャー左',
    address: '/avatar/parameters/GestureLeft',
    type: OscParamType.int,
    defaultValue: 0,
  ),
  OscParam(
    name: 'ジェスチャー右',
    address: '/avatar/parameters/GestureRight',
    type: OscParamType.int,
    defaultValue: 0,
  ),
];
