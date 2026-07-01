import 'package:flutter/foundation.dart';

@immutable
class OscSettings {
  const OscSettings({
    this.ipAddress = '127.0.0.1',
    this.port = 9000,
    this.savedParams = const [],
  });

  factory OscSettings.fromJson(Map<String, Object?> json) {
    final savedParamsJson = json['savedParams'];

    return OscSettings(
      ipAddress: json['ipAddress'] as String? ?? '127.0.0.1',
      port: json['port'] as int? ?? 9000,
      savedParams: savedParamsJson is List<Object?>
          ? [
              for (final paramJson in savedParamsJson)
                if (paramJson is Map<String, Object?>)
                  OscParam.fromJson(paramJson),
            ]
          : const [],
    );
  }

  final String ipAddress;
  final int port;
  final List<OscParam> savedParams;

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

  Map<String, Object?> toJson() {
    return {
      'ipAddress': ipAddress,
      'port': port,
      'savedParams': savedParams.map((param) => param.toJson()).toList(),
    };
  }
}

@immutable
class OscParam {
  const OscParam({
    required this.name,
    required this.address,
    required this.type,
    this.defaultValue,
  });

  factory OscParam.fromJson(Map<String, Object?> json) {
    return OscParam(
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      type: _parseParamType(json['type'] as String? ?? 'OscParamType.float'),
      defaultValue: json['defaultValue'],
    );
  }

  final String name;
  final String address;
  final OscParamType type;
  final Object? defaultValue;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'address': address,
      'type': type.toString(),
      'defaultValue': defaultValue,
    };
  }

  static OscParamType _parseParamType(String typeString) {
    if (typeString.contains('bool')) return OscParamType.bool;
    if (typeString.contains('int')) return OscParamType.int;
    return OscParamType.float;
  }
}

enum OscParamType { bool, int, float }
