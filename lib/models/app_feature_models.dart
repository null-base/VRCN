import 'dart:convert';

class ActivityRecord {
  const ActivityRecord({
    required this.kind,
    required this.userId,
    required this.userName,
    required this.timestamp,
    this.location,
    this.worldName,
    this.detail,
  });

  factory ActivityRecord.fromJson(Map<String, dynamic> json) {
    return ActivityRecord(
      kind: json['kind'] as String? ?? 'activity',
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      timestamp:
          DateTime.tryParse(json['timestamp'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      location: json['location'] as String?,
      worldName: json['worldName'] as String?,
      detail: json['detail'] as String?,
    );
  }

  final String kind;
  final String userId;
  final String userName;
  final DateTime timestamp;
  final String? location;
  final String? worldName;
  final String? detail;

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'userId': userId,
    'userName': userName,
    'timestamp': timestamp.toIso8601String(),
    if (location != null) 'location': location,
    if (worldName != null) 'worldName': worldName,
    if (detail != null) 'detail': detail,
  };
}

class HotWorld {
  const HotWorld({
    required this.worldId,
    required this.name,
    required this.count,
  });

  final String worldId;
  final String name;
  final int count;
}

class StatusPreset {
  const StatusPreset({
    required this.name,
    required this.status,
    required this.description,
  });

  factory StatusPreset.fromJson(Map<String, dynamic> json) {
    return StatusPreset(
      name: json['name'] as String? ?? 'Preset',
      status: json['status'] as String? ?? 'active',
      description: json['description'] as String? ?? '',
    );
  }

  final String name;
  final String status;
  final String description;

  Map<String, dynamic> toJson() => {
    'name': name,
    'status': status,
    'description': description,
  };
}

String encodeJsonList(Iterable<Map<String, dynamic>> values) {
  return jsonEncode(values.toList(growable: false));
}
