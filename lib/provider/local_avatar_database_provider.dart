import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class LocalAvatarRecord {
  const LocalAvatarRecord({
    required this.id,
    required this.name,
    required this.authorName,
    required this.thumbnailImageUrl,
    required this.releaseStatus,
    required this.updatedAt,
    required this.cachedAt,
  });

  factory LocalAvatarRecord.fromAvatar(Avatar avatar) {
    return LocalAvatarRecord(
      id: avatar.id,
      name: avatar.name,
      authorName: avatar.authorName,
      thumbnailImageUrl: avatar.thumbnailImageUrl,
      releaseStatus: avatar.releaseStatus,
      updatedAt: avatar.updatedAt,
      cachedAt: DateTime.now(),
    );
  }

  factory LocalAvatarRecord.fromJson(Map<String, dynamic> json) {
    return LocalAvatarRecord(
      id: json['id'] as String,
      name: json['name'] as String,
      authorName: json['authorName'] as String,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String,
      releaseStatus: ReleaseStatus.values.firstWhere(
        (status) => status.value == json['releaseStatus'],
        orElse: () => ReleaseStatus.private,
      ),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      cachedAt: DateTime.parse(json['cachedAt'] as String),
    );
  }

  final String id;
  final String name;
  final String authorName;
  final String thumbnailImageUrl;
  final ReleaseStatus releaseStatus;
  final DateTime updatedAt;
  final DateTime cachedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'authorName': authorName,
      'thumbnailImageUrl': thumbnailImageUrl,
      'releaseStatus': releaseStatus.value,
      'updatedAt': updatedAt.toIso8601String(),
      'cachedAt': cachedAt.toIso8601String(),
    };
  }
}

final localAvatarDatabaseProvider =
    StateNotifierProvider<LocalAvatarDatabaseNotifier, List<LocalAvatarRecord>>(
      LocalAvatarDatabaseNotifier.new,
    );

class LocalAvatarDatabaseNotifier
    extends StateNotifier<List<LocalAvatarRecord>> {
  LocalAvatarDatabaseNotifier(this.ref) : super(const []) {
    _load();
  }

  static const _storageKey = 'local_avatar_database_v1';
  static const _maxRecords = 500;

  final Ref ref;

  Future<void> saveAvatar(Avatar avatar) {
    return saveAll([avatar]);
  }

  Future<void> saveAll(Iterable<Avatar> avatars) async {
    final next = [...state];

    for (final avatar in avatars) {
      next.removeWhere((record) => record.id == avatar.id);
      next.insert(0, LocalAvatarRecord.fromAvatar(avatar));
    }

    state = next.take(_maxRecords).toList();
    await _persist();
  }

  Future<void> clear() async {
    state = const [];
    await ref.read(sharedPreferencesProvider).remove(_storageKey);
  }

  void _load() {
    final raw = ref.read(sharedPreferencesProvider).getString(_storageKey);
    if (raw == null || raw.isEmpty) return;

    final decoded = jsonDecode(raw);
    if (decoded is! List<dynamic>) return;

    state = decoded
        .whereType<Map<String, dynamic>>()
        .map(LocalAvatarRecord.fromJson)
        .toList();
  }

  Future<void> _persist() {
    final raw = jsonEncode(state.map((record) => record.toJson()).toList());
    return ref.read(sharedPreferencesProvider).setString(_storageKey, raw);
  }
}
