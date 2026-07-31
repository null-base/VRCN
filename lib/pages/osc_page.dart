import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/controllers/osc_controller.dart';
import 'package:vrchat/models/osc_models.dart';
import 'package:vrchat/provider/osc_settings_provider.dart';
import 'package:vrchat/theme/app_theme.dart';

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
  final Map<int, Object?> _currentValues = {};

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
    final result = await ref.read(oscControllerProvider).connect();
    setState(() {
      _isConnected = result.isConnected;
      _statusMessage = result.message;
    });
  }

  // 切断処理を修正
  void _disconnect() {
    setState(() {
      _isConnected = false;
      _statusMessage = 'OSC未接続';
    });
  }

  // テストメッセージ送信
  Future<void> _sendTestMessage() async {
    final isConnected = await ref.read(oscControllerProvider).checkConnection();
    if (!isConnected) {
      setState(() {
        _isConnected = false;
        _statusMessage = '接続が切れました';
      });
    }
  }

  // パラメータを送信
  Future<void> _sendParameter(OscParam param, Object value) async {
    if (!_isConnected) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OSCが接続されていません')));
      return;
    }

    try {
      await ref
          .read(oscControllerProvider)
          .sendParameter(
            param: param,
            value: value,
          );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${param.name}: $value を送信しました')),
      );
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
                      ref.read(oscControllerProvider).updateIpAddress(value);
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // ポート入力
                Expanded(
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
                        ref.read(oscControllerProvider).updatePort(port);
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
                    backgroundColor: _isConnected
                        ? Colors.red
                        : AppTheme.primaryColor,
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
                    onPressed: () => _showEditParamDialog(
                      context,
                      index,
                      param,
                      isDarkMode,
                    ),
                    tooltip: '編集',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteParamDialog(
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
        final currentValue = _boolValue(index);
        return SwitchListTile(
          title: Text('${currentValue ? 'ON' : 'OFF'} に設定'),
          value: currentValue,
          activeThumbColor: AppTheme.primaryColor,
          onChanged: (value) {
            setState(() {
              _currentValues[index] = value;
            });
            _sendParameter(param, value ? 1 : 0);
          },
        );

      case OscParamType.int:
        final currentValue = _intValue(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '現在の値: $currentValue',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider(
              value: currentValue.toDouble(),
              max: 7, // ジェスチャーの場合は0-7の範囲
              divisions: 7,
              label: currentValue.toString(),
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
                    backgroundColor: _currentValues[index] == i
                        ? AppTheme.primaryColor
                        : isDarkMode
                        ? Colors.grey[800]
                        : Colors.grey[200],
                    foregroundColor: _currentValues[index] == i
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
        final currentValue = _doubleValue(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '現在の値: ${currentValue.toStringAsFixed(2)}',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Slider(
              value: currentValue,
              divisions: 100,
              label: currentValue.toStringAsFixed(2),
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
        backgroundColor: isSelected
            ? AppTheme.primaryColor
            : isDarkMode
            ? Colors.grey[800]
            : Colors.grey[200],
        foregroundColor: isSelected
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

  bool _boolValue(int index) {
    return _currentValues[index] as bool? ?? false;
  }

  int _intValue(int index) {
    return _currentValues[index] as int? ?? 0;
  }

  double _doubleValue(int index) {
    return _currentValues[index] as double? ?? 0;
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
      builder: (context) => AlertDialog(
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
                builder: (context, setState) => Column(
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

              final oscController = ref.read(oscControllerProvider);
              final newParam = oscController.createParam(
                name: nameController.text,
                address: addressController.text,
                type: selectedType,
              );

              oscController.addParam(newParam);
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
      builder: (context) => AlertDialog(
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
                builder: (context, setState) => Column(
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

              final oscController = ref.read(oscControllerProvider);
              final updatedParam = oscController.editParam(
                current: param,
                name: nameController.text,
                address: addressController.text,
                type: selectedType,
              );

              oscController.updateParam(index, updatedParam);

              // 現在値も更新
              setState(() {
                _currentValues[index] = updatedParam.defaultValue;
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
      builder: (context) => AlertDialog(
        title: const Text('パラメータを削除'),
        content: Text('「${param.name}」を削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              ref.read(oscControllerProvider).removeParam(index);
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
