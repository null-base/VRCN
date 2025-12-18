import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osc/osc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/theme/app_theme.dart';

// OSCの設定を保存するためのプロバイダー
final oscSettingsProvider =
    StateNotifierProvider<OscSettingsNotifier, OscSettings>((ref) {
      final prefs = ref.watch(sharedPreferencesProvider);
      return OscSettingsNotifier(prefs);
    });

// OSC設定モデル
@immutable
class OscSettings {
  final String ipAddress;
  final int port;
  final List<OscParam> savedParams;

  const OscSettings({
    this.ipAddress = '127.0.0.1',
    this.port = 9000,
    this.savedParams = const [],
  });

  OscSettings copyWith({
    String? ipAddress,
    int? port,
    List<OscParam>? savedParams,
  }) {
    return OscSettings(
      ipAddress: ipAddress ?? this.ipAddress,
      port: port ?? this.port,
      savedParams: savedParams ?? this.savedParams,
    );
  }

  // JSON変換用メソッド
  Map<String, dynamic> toJson() {
    return {
      'ipAddress': ipAddress,
      'port': port,
      'savedParams': savedParams.map((param) => param.toJson()).toList(),
    };
  }

  factory OscSettings.fromJson(Map<String, dynamic> json) {
    return OscSettings(
      ipAddress: json['ipAddress'] ?? '127.0.0.1',
      port: json['port'] ?? 9000,
      savedParams:
          (json['savedParams'] as List?)
              ?.map((paramJson) => OscParam.fromJson(paramJson))
              .toList() ??
          [],
    );
  }
}

// OSCパラメータモデル
@immutable
class OscParam {
  final String name;
  final String address;
  final OscParamType type;
  final dynamic defaultValue;

  const OscParam({
    required this.name,
    required this.address,
    required this.type,
    this.defaultValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'type': type.toString(),
      'defaultValue': defaultValue,
    };
  }

  factory OscParam.fromJson(Map<String, dynamic> json) {
    return OscParam(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      type: _parseParamType(json['type'] ?? 'OscParamType.float'),
      defaultValue: json['defaultValue'],
    );
  }

  static OscParamType _parseParamType(String typeStr) {
    if (typeStr.contains('bool')) return OscParamType.bool;
    if (typeStr.contains('int')) return OscParamType.int;
    return OscParamType.float;
  }
}

enum OscParamType { bool, int, float }

// OSC設定の状態管理
class OscSettingsNotifier extends StateNotifier<OscSettings> {
  final SharedPreferences prefs;

  OscSettingsNotifier(this.prefs) : super(const OscSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settingsJson = prefs.getString('osc_settings');
    if (settingsJson != null) {
      try {
        state = OscSettings.fromJson(jsonDecode(settingsJson));
      } catch (e) {
        // エラー時はデフォルト設定を使用
        state = const OscSettings();
      }
    } else {
      // デフォルトパラメータを設定
      state = const OscSettings(
        savedParams: [
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
        ],
      );
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
    final newParams = [...state.savedParams, param];
    state = state.copyWith(savedParams: newParams);
    saveSettings();
  }

  void updateParam(int index, OscParam param) {
    final newParams = [...state.savedParams];
    newParams[index] = param;
    state = state.copyWith(savedParams: newParams);
    saveSettings();
  }

  void removeParam(int index) {
    final newParams = [...state.savedParams];
    newParams.removeAt(index);
    state = state.copyWith(savedParams: newParams);
    saveSettings();
  }
}

// OSCページ
class OscPage extends ConsumerStatefulWidget {
  const OscPage({super.key});

  @override
  ConsumerState<OscPage> createState() => _OscPageState();
}

class _OscPageState extends ConsumerState<OscPage> {
  var _isConnected = false;
  var _statusMessage = 'OSC未接続';
  Timer? _connectionCheckTimer;

  // 現在編集中のパラメータ値
  final Map<int, dynamic> _currentValues = {};

  @override
  void initState() {
    super.initState();
    _startConnectionCheck();
  }

  @override
  void dispose() {
    _connectionCheckTimer?.cancel();
    super.dispose();
  }

  // 接続状態を定期的にチェック
  void _startConnectionCheck() {
    _connectionCheckTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_isConnected) {
        _sendTestMessage();
      }
    });
  }

  // 接続処理を修正
  Future<void> _connect() async {
    final settings = ref.read(oscSettingsProvider);

    try {
      // IPアドレスの形式をチェック
      final destination = InternetAddress.tryParse(settings.ipAddress);
      if (destination == null) {
        throw Exception('無効なIPアドレスです');
      }

      // テスト送信してみる
      final testMessage = OSCMessage('/avatar/parameters/Test', arguments: [1]);
      await _sendOscMessage(testMessage, destination, settings.port);

      setState(() {
        _isConnected = true;
        _statusMessage = '${settings.ipAddress}:${settings.port} に接続しました';
      });
    } catch (e) {
      setState(() {
        _isConnected = false;
        _statusMessage = '接続エラー: $e';
      });
    }
  }

  // 切断処理を修正
  void _disconnect() {
    setState(() {
      _isConnected = false;
      _statusMessage = 'OSC未接続';
    });
  }

  // テストメッセージ送信
  void _sendTestMessage() {
    try {
      final settings = ref.read(oscSettingsProvider);
      final destination = InternetAddress.tryParse(settings.ipAddress);
      if (destination != null) {
        final message = OSCMessage('/avatar/parameters/Test', arguments: [1]);
        _sendOscMessage(message, destination, settings.port);
      }
    } catch (e) {
      debugPrint('テストメッセージエラー: $e');
      setState(() {
        _isConnected = false;
        _statusMessage = '接続が切れました';
      });
    }
  }

  // OSCメッセージ送信（RawDatagramSocketを使用）
  Future<void> _sendOscMessage(
    OSCMessage message,
    InternetAddress destination,
    int port,
  ) async {
    try {
      final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
      final bytes = message.toBytes();
      socket.send(bytes, destination, port);
      socket.close();
    } catch (e) {
      debugPrint('OSC送信エラー: $e');
      rethrow;
    }
  }

  // パラメータを送信
  void _sendParameter(OscParam param, dynamic value) {
    if (!_isConnected) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OSCが接続されていません')));
      return;
    }

    try {
      final settings = ref.read(oscSettingsProvider);
      final destination = InternetAddress.tryParse(settings.ipAddress);
      if (destination != null) {
        final message = OSCMessage(param.address, arguments: [value]);
        _sendOscMessage(message, destination, settings.port);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${param.name}: $value を送信しました')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('送信エラー: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final oscSettings = ref.watch(oscSettingsProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OSCコントローラー',
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 接続ステータスと設定
          _buildConnectionSection(oscSettings, isDarkMode),

          // パラメータ一覧
          Expanded(child: _buildParameterList(oscSettings, isDarkMode)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddParamDialog(context, isDarkMode),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  // 接続セクション
  Widget _buildConnectionSection(OscSettings settings, bool isDarkMode) {
    final ipController = TextEditingController(text: settings.ipAddress);
    final portController = TextEditingController(
      text: settings.port.toString(),
    );

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 接続ステータス
            Row(
              children: [
                Icon(
                  _isConnected ? Icons.check_circle : Icons.error_outline,
                  color: _isConnected ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _statusMessage,
                    style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 接続設定
            Row(
              children: [
                // IPアドレス入力
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: ipController,
                    decoration: InputDecoration(
                      labelText: 'IPアドレス',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (value) {
                      ref
                          .read(oscSettingsProvider.notifier)
                          .updateIpAddress(value);
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // ポート入力
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: portController,
                    decoration: InputDecoration(
                      labelText: 'ポート',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final port = int.tryParse(value);
                      if (port != null) {
                        ref.read(oscSettingsProvider.notifier).updatePort(port);
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 接続ボタン
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(_isConnected ? Icons.link_off : Icons.link),
                  label: Text(_isConnected ? '切断' : '接続'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isConnected ? Colors.red : AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _isConnected ? _disconnect : _connect,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // パラメータリスト
  Widget _buildParameterList(OscSettings settings, bool isDarkMode) {
    if (settings.savedParams.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.control_camera_outlined,
              size: 80,
              color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'パラメータが登録されていません',
              style: GoogleFonts.notoSans(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '+ ボタンを押してパラメータを追加してください',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: settings.savedParams.length,
      itemBuilder: (context, index) {
        final param = settings.savedParams[index];

        // 初期値が設定されていなければパラメータのデフォルト値を使用
        _currentValues[index] ??= param.defaultValue;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            title: Text(
              param.name,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              param.address,
              style: GoogleFonts.robotoMono(
                fontSize: 12,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            children: [
              // パラメータの種類に応じたコントロールを表示
              _buildParamControl(param, index, isDarkMode),

              const SizedBox(height: 16),

              // 操作ボタン
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed:
                        () => _showEditParamDialog(
                          context,
                          index,
                          param,
                          isDarkMode,
                        ),
                    tooltip: '編集',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed:
                        () => _showDeleteParamDialog(
                          context,
                          index,
                          param,
                          isDarkMode,
                        ),
                    tooltip: '削除',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // パラメータの種類に応じたコントロールを生成
  Widget _buildParamControl(OscParam param, int index, bool isDarkMode) {
    switch (param.type) {
      case OscParamType.bool:
        return SwitchListTile(
          title: Text('${_currentValues[index] == true ? 'ON' : 'OFF'} に設定'),
          value: _currentValues[index] ?? false,
          activeThumbColor: AppTheme.primaryColor,
          onChanged: (value) {
            setState(() {
              _currentValues[index] = value;
            });
            _sendParameter(param, value ? 1 : 0);
          },
        );

      case OscParamType.int:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '現在の値: ${_currentValues[index]}',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider(
              value: (_currentValues[index] ?? 0).toDouble(),
              min: 0,
              max: 7, // ジェスチャーの場合は0-7の範囲
              divisions: 7,
              label: _currentValues[index]?.toString(),
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  _currentValues[index] = value.round();
                });
              },
              onChangeEnd: (value) {
                _sendParameter(param, value.round());
              },
            ),
            // クイックボタン
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                8,
                (i) => ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentValues[index] = i;
                    });
                    _sendParameter(param, i);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _currentValues[index] == i
                            ? AppTheme.primaryColor
                            : isDarkMode
                            ? Colors.grey[800]
                            : Colors.grey[200],
                    foregroundColor:
                        _currentValues[index] == i
                            ? Colors.white
                            : isDarkMode
                            ? Colors.white
                            : Colors.black,
                    minimumSize: const Size(40, 40),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text('$i'),
                ),
              ),
            ),
          ],
        );

      case OscParamType.float:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '現在の値: ${(_currentValues[index] ?? 0.0).toStringAsFixed(2)}',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider(
              value: _currentValues[index] ?? 0.0,
              min: 0,
              max: 1,
              divisions: 100,
              label: (_currentValues[index] ?? 0.0).toStringAsFixed(2),
              activeColor: AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  _currentValues[index] = value;
                });
              },
              onChangeEnd: (value) {
                _sendParameter(param, value);
              },
            ),
            // プリセットボタン
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPresetButton('0', 0, index, param),
                _buildPresetButton('0.25', 0.25, index, param),
                _buildPresetButton('0.5', 0.5, index, param),
                _buildPresetButton('0.75', 0.75, index, param),
                _buildPresetButton('1.0', 1, index, param),
              ],
            ),
          ],
        );
    }
  }

  // プリセットボタン
  Widget _buildPresetButton(
    String label,
    double value,
    int index,
    OscParam param,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isSelected = (_currentValues[index] ?? 0.0) == value;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          _currentValues[index] = value;
        });
        _sendParameter(param, value);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected
                ? AppTheme.primaryColor
                : isDarkMode
                ? Colors.grey[800]
                : Colors.grey[200],
        foregroundColor:
            isSelected
                ? Colors.white
                : isDarkMode
                ? Colors.white
                : Colors.black,
        minimumSize: const Size(50, 36),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Text(label),
    );
  }

  // パラメータ追加ダイアログ
  void _showAddParamDialog(BuildContext context, bool isDarkMode) {
    final nameController = TextEditingController();
    final addressController = TextEditingController(
      text: '/avatar/parameters/',
    );
    var selectedType = OscParamType.float;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'パラメータを追加',
              style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: '名前（表示用）',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'OSCアドレス',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      helperText: '例: /avatar/parameters/VRCFaceBlendH/Joy',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'パラメータの種類',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                  StatefulBuilder(
                    builder:
                        (context, setState) => Column(
                          children: [
                            RadioListTile<OscParamType>(
                              title: const Text('Float (0.0～1.0)'),
                              value: OscParamType.float,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() => selectedType = value!);
                              },
                            ),
                            RadioListTile<OscParamType>(
                              title: const Text('Int (整数値)'),
                              value: OscParamType.int,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() => selectedType = value!);
                              },
                            ),
                            RadioListTile<OscParamType>(
                              title: const Text('Bool (On/Off)'),
                              value: OscParamType.bool,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() => selectedType = value!);
                              },
                            ),
                          ],
                        ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('名前とアドレスを入力してください')),
                    );
                    return;
                  }

                  final defaultValue =
                      selectedType == OscParamType.float
                          ? 0.0
                          : selectedType == OscParamType.int
                          ? 0
                          : false;

                  final newParam = OscParam(
                    name: nameController.text,
                    address: addressController.text,
                    type: selectedType,
                    defaultValue: defaultValue,
                  );

                  ref.read(oscSettingsProvider.notifier).addParam(newParam);
                  Navigator.pop(context);
                },
                child: const Text('追加'),
              ),
            ],
          ),
    );
  }

  // パラメータ編集ダイアログ
  void _showEditParamDialog(
    BuildContext context,
    int index,
    OscParam param,
    bool isDarkMode,
  ) {
    final nameController = TextEditingController(text: param.name);
    final addressController = TextEditingController(text: param.address);
    var selectedType = param.type;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'パラメータを編集',
              style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: '名前（表示用）',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'OSCアドレス',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'パラメータの種類',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                  StatefulBuilder(
                    builder:
                        (context, setState) => Column(
                          children: [
                            RadioListTile<OscParamType>(
                              title: const Text('Float (0.0～1.0)'),
                              value: OscParamType.float,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() => selectedType = value!);
                              },
                            ),
                            RadioListTile<OscParamType>(
                              title: const Text('Int (整数値)'),
                              value: OscParamType.int,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() => selectedType = value!);
                              },
                            ),
                            RadioListTile<OscParamType>(
                              title: const Text('Bool (On/Off)'),
                              value: OscParamType.bool,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() => selectedType = value!);
                              },
                            ),
                          ],
                        ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('名前とアドレスを入力してください')),
                    );
                    return;
                  }

                  // 種類が変わった場合はデフォルト値も更新
                  final defaultValue =
                      selectedType == param.type
                          ? param.defaultValue
                          : selectedType == OscParamType.float
                          ? 0.0
                          : selectedType == OscParamType.int
                          ? 0
                          : false;

                  final updatedParam = OscParam(
                    name: nameController.text,
                    address: addressController.text,
                    type: selectedType,
                    defaultValue: defaultValue,
                  );

                  ref
                      .read(oscSettingsProvider.notifier)
                      .updateParam(index, updatedParam);

                  // 現在値も更新
                  setState(() {
                    _currentValues[index] = defaultValue;
                  });

                  Navigator.pop(context);
                },
                child: const Text('保存'),
              ),
            ],
          ),
    );
  }

  // パラメータ削除確認ダイアログ
  void _showDeleteParamDialog(
    BuildContext context,
    int index,
    OscParam param,
    bool isDarkMode,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('パラメータを削除'),
            content: Text('「${param.name}」を削除しますか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(oscSettingsProvider.notifier).removeParam(index);
                  Navigator.pop(context);

                  // 現在値も削除
                  setState(() {
                    _currentValues.remove(index);
                  });
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('削除'),
              ),
            ],
          ),
    );
  }
}
