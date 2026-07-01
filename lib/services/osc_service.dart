import 'dart:io';

import 'package:osc/osc.dart';
import 'package:vrchat/models/osc_models.dart';

class OscService {
  const OscService();

  Future<void> sendTestMessage(OscSettings settings) {
    return _sendMessage(
      address: '/avatar/parameters/Test',
      arguments: const [1],
      settings: settings,
    );
  }

  Future<void> sendParameter({
    required OscSettings settings,
    required OscParam param,
    required Object value,
  }) {
    return _sendMessage(
      address: param.address,
      arguments: [value],
      settings: settings,
    );
  }

  Future<void> _sendMessage({
    required String address,
    required List<Object> arguments,
    required OscSettings settings,
  }) async {
    final destination = InternetAddress.tryParse(settings.ipAddress);
    if (destination == null) {
      throw const FormatException('無効なIPアドレスです');
    }

    final message = OSCMessage(address, arguments: arguments);
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    try {
      socket.send(message.toBytes(), destination, settings.port);
    } finally {
      socket.close();
    }
  }
}
