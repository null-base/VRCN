import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/models/app_feature_models.dart';
import 'package:vrchat/provider/avatar_provider.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/group_provider.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/vrchat_extended_api_provider.dart';
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final activityHistoryProvider =
    StateNotifierProvider<ActivityHistoryNotifier, List<ActivityRecord>>((ref) {
      return ActivityHistoryNotifier(ref.watch(sharedPreferencesProvider));
    });

class ActivityHistoryNotifier extends StateNotifier<List<ActivityRecord>> {
  ActivityHistoryNotifier(this._prefs) : super(const []) {
    _load();
  }

  static const _storageKey = 'activity_history_v1';
  static const _maxRecords = 2000;
  final SharedPreferences _prefs;

  Future<void> record({
    required String kind,
    required String userId,
    required String userName,
    String? location,
    String? worldName,
    String? detail,
  }) async {
    final record = ActivityRecord(
      kind: kind,
      userId: userId,
      userName: userName,
      timestamp: DateTime.now(),
      location: location,
      worldName: worldName,
      detail: detail,
    );
    state = [record, ...state].take(_maxRecords).toList(growable: false);
    await _persist();
  }

  Future<void> replaceAll(Iterable<ActivityRecord> records) async {
    state = records.take(_maxRecords).toList(growable: false);
    await _persist();
  }

  Future<void> clear() async {
    state = const [];
    await _prefs.remove(_storageKey);
  }

  void reload() => _load();

  void _load() {
    final raw = _prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return;
      state = decoded
          .whereType<Map>()
          .map(
            (item) => ActivityRecord.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(growable: false);
    } on Object {
      state = const [];
    }
  }

  Future<void> _persist() {
    return _prefs.setString(
      _storageKey,
      jsonEncode(state.map((item) => item.toJson()).toList(growable: false)),
    );
  }
}

final activityHeatmapProvider = Provider<Map<DateTime, int>>((ref) {
  final records = ref.watch(activityHistoryProvider);
  final counts = <DateTime, int>{};
  for (final record in records) {
    final day = DateTime(
      record.timestamp.year,
      record.timestamp.month,
      record.timestamp.day,
    );
    counts[day] = (counts[day] ?? 0) + 1;
  }
  return counts;
});

final activitySessionDurationsProvider = Provider<Map<String, Duration>>((ref) {
  final records = ref.watch(activityHistoryProvider).toList(growable: false)
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  final startedAt = <String, DateTime>{};
  final durations = <String, Duration>{};
  for (final record in records) {
    if (record.userId.isEmpty) continue;
    if (record.kind == 'friendOnline' || record.kind == 'friendActive') {
      startedAt.putIfAbsent(record.userId, () => record.timestamp);
    } else if (record.kind == 'friendOffline' &&
        startedAt.containsKey(record.userId)) {
      final start = startedAt.remove(record.userId)!;
      durations[record.userId] =
          (durations[record.userId] ?? Duration.zero) +
          record.timestamp.difference(start);
    }
  }
  final now = DateTime.now();
  for (final entry in startedAt.entries) {
    durations[entry.key] =
        (durations[entry.key] ?? Duration.zero) + now.difference(entry.value);
  }
  return durations;
});

final FutureProviderFamily<List<MutualFriend>, String> mutualFriendsProvider =
    FutureProvider.family<List<MutualFriend>, String>(
      (ref, userId) async {
        final api = await ref.watch(vrchatRawApiProvider);
        final response = await api.getUsersApi().getMutualFriends(
          userId: userId,
          n: 100,
        );
        return response.data ?? const [];
      },
    );

final Provider<List<HotWorld>> hotWorldsProvider = Provider<List<HotWorld>>((
  ref,
) {
  final friends =
      ref.watch(friendsProvider).asData?.value ?? const <LimitedUser>[];
  final names = ref.watch(worldNamesProvider);
  final counts = <String, int>{};
  for (final friend in friends) {
    final location = friend.location;
    if (location == null || !location.startsWith('wrld_')) continue;
    final worldId = location.split(':').first;
    counts[worldId] = (counts[worldId] ?? 0) + 1;
  }
  final worlds = counts.entries
      .map(
        (entry) => HotWorld(
          worldId: entry.key,
          name: names[entry.key] ?? entry.key,
          count: entry.value,
        ),
      )
      .toList();
  worlds.sort((a, b) => b.count.compareTo(a.count));
  return worlds;
});

final FutureProviderFamily<List<LimitedUserInstance>, String>
instancePlayersProvider =
    FutureProvider.family<List<LimitedUserInstance>, String>((
      ref,
      location,
    ) async {
      if (!isInstanceLocation(location)) return const [];
      final instance = await ref.watch(instanceDetailProvider(location).future);
      return instance.users ?? const [];
    });

final FutureProvider<List<PlayerModeration>> playerModerationsProvider =
    FutureProvider<List<PlayerModeration>>((ref) async {
      final api = await ref.watch(vrchatRawApiProvider);
      final response = await api
          .getPlayermoderationApi()
          .getPlayerModerations();
      return response.data ?? const [];
    });

final moderationActionsProvider = Provider<ModerationActions>(
  ModerationActions.new,
);

class ModerationActions {
  const ModerationActions(this._ref);
  final Ref _ref;

  Future<void> unmoderate(PlayerModeration moderation) async {
    final api = await _ref.read(vrchatRawApiProvider);
    await api.getPlayermoderationApi().unmoderateUser(
      moderateUserRequest: ModerateUserRequest(
        moderated: moderation.targetUserId,
        type: moderation.type,
      ),
    );
    _ref.invalidate(playerModerationsProvider);
  }

  Future<void> clearAll() async {
    final api = await _ref.read(vrchatRawApiProvider);
    await api.getPlayermoderationApi().clearAllPlayerModerations();
    _ref.invalidate(playerModerationsProvider);
  }
}

final FutureProviderFamily<List<GroupMember>, String> groupMembersProvider =
    FutureProvider.family<List<GroupMember>, String>((
      ref,
      groupId,
    ) async {
      final api = await ref.watch(vrchatRawApiProvider);
      final response = await api.getGroupsApi().getGroupMembers(
        groupId: groupId,
        n: 100,
      );
      return response.data ?? const [];
    });

final FutureProviderFamily<List<GroupMember>, String> groupBansProvider =
    FutureProvider.family<List<GroupMember>, String>((
      ref,
      groupId,
    ) async {
      final api = await ref.watch(vrchatRawApiProvider);
      final response = await api.getGroupsApi().getGroupBans(
        groupId: groupId,
        n: 100,
      );
      return response.data ?? const [];
    });

final FutureProviderFamily<List<CalendarEvent>, String>
groupCalendarEventsProvider =
    FutureProvider.family<List<CalendarEvent>, String>((ref, groupId) async {
      final api = await ref.watch(vrchatCalendarApiProvider.future);
      final response = await api.getGroupCalendarEvents(
        groupId: groupId,
        n: 100,
      );
      return response.data?.results ?? const [];
    });

final groupActionsProvider = Provider<GroupFeatureActions>(
  GroupFeatureActions.new,
);

class GroupFeatureActions {
  const GroupFeatureActions(this._ref);
  final Ref _ref;

  Future<void> join(String groupId) async {
    final api = await _ref.read(vrchatRawApiProvider);
    await api.getGroupsApi().joinGroup(groupId: groupId);
    _invalidateGroup(groupId);
  }

  Future<void> leave(String groupId) async {
    final api = await _ref.read(vrchatRawApiProvider);
    await api.getGroupsApi().leaveGroup(groupId: groupId);
    _invalidateGroup(groupId);
  }

  Future<void> ban(String groupId, String userId) async {
    final api = await _ref.read(vrchatRawApiProvider);
    await api.getGroupsApi().banGroupMember(
      groupId: groupId,
      banGroupMemberRequest: BanGroupMemberRequest(userId: userId),
    );
    _invalidateGroup(groupId);
  }

  Future<void> unban(String groupId, String userId) async {
    final api = await _ref.read(vrchatRawApiProvider);
    await api.getGroupsApi().unbanGroupMember(groupId: groupId, userId: userId);
    _invalidateGroup(groupId);
  }

  Future<void> followCalendarEvent(
    String groupId,
    String calendarId,
    bool isFollowing,
  ) async {
    final api = await _ref.read(vrchatCalendarApiProvider.future);
    await api.followGroupCalendarEvent(
      groupId: groupId,
      calendarId: calendarId,
      followCalendarEventRequest: FollowCalendarEventRequest(
        isFollowing: isFollowing,
      ),
    );
    _ref.invalidate(groupCalendarEventsProvider(groupId));
  }

  void _invalidateGroup(String groupId) {
    _ref.invalidate(groupMembersProvider(groupId));
    _ref.invalidate(groupBansProvider(groupId));
    _ref.invalidate(groupDetailProvider(GroupDetailParams(groupId: groupId)));
  }
}

final ownAvatarsManagementProvider = FutureProvider<List<Avatar>>((ref) async {
  final api = await ref.watch(vrchatAvatarProvider.future);
  final response = await api.searchAvatars(
    user: 'me',
    n: 100,
    sort: SortOption.updated,
    order: OrderOption.descending,
  );
  return response.data ?? const [];
});

final assetManagementActionsProvider = Provider<AssetManagementActions>(
  AssetManagementActions.new,
);

class AssetManagementActions {
  const AssetManagementActions(this._ref);
  final Ref _ref;

  Future<void> updateAvatar({
    required String avatarId,
    String? name,
    String? description,
    List<String>? tags,
  }) async {
    final api = await _ref.read(vrchatRawApiProvider);
    await api.getAvatarsApi().updateAvatar(
      avatarId: avatarId,
      updateAvatarRequest: UpdateAvatarRequest(
        name: name,
        description: description,
        tags: tags,
      ),
    );
    _ref.invalidate(ownAvatarsManagementProvider);
    _ref.invalidate(avatarDetailProvider(avatarId));
  }

  Future<void> updateWorld({
    required String worldId,
    String? name,
    String? description,
    int? capacity,
    List<String>? tags,
  }) async {
    final api = await _ref.read(vrchatRawApiProvider);
    await api.getWorldsApi().updateWorld(
      worldId: worldId,
      updateWorldRequest: UpdateWorldRequest(
        name: name,
        description: description,
        capacity: capacity,
        tags: tags,
      ),
    );
    _ref.invalidate(worldDetailProvider(worldId));
  }
}

final statusPresetsProvider =
    StateNotifierProvider<StatusPresetNotifier, List<StatusPreset>>((ref) {
      return StatusPresetNotifier(ref.watch(sharedPreferencesProvider));
    });

class StatusPresetNotifier extends StateNotifier<List<StatusPreset>> {
  StatusPresetNotifier(this._prefs) : super(_defaultPresets) {
    _load();
  }

  static const _storageKey = 'status_presets_v1';
  static const _defaultPresets = <StatusPreset>[
    StatusPreset(name: 'Available', status: 'active', description: ''),
    StatusPreset(name: 'Ask me', status: 'ask me', description: ''),
    StatusPreset(name: 'Busy', status: 'busy', description: ''),
    StatusPreset(name: 'Join me', status: 'join me', description: ''),
  ];

  final SharedPreferences _prefs;

  Future<void> save(StatusPreset preset) async {
    state = [
      ...state.where((item) => item.name != preset.name),
      preset,
    ];
    await _persist();
  }

  Future<void> remove(StatusPreset preset) async {
    state = state.where((item) => item.name != preset.name).toList();
    await _persist();
  }

  Future<void> apply(StatusPreset preset, WidgetRef ref) async {
    final user = await ref.read(currentUserProvider.future);
    final api = await ref.read(vrchatRawApiProvider);
    final status = UserStatus.values.firstWhere(
      (item) => item.value == preset.status,
      orElse: () => UserStatus.active,
    );
    await api.getUsersApi().updateUser(
      userId: user.id,
      updateUserRequest: UpdateUserRequest(
        status: status,
        statusDescription: preset.description,
      ),
    );
    ref.invalidate(currentUserProvider);
  }

  void reload() => _load();

  void _load() {
    final raw = _prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return;
      state = decoded
          .whereType<Map>()
          .map((item) => StatusPreset.fromJson(Map<String, dynamic>.from(item)))
          .toList(growable: false);
    } on Object {
      state = _defaultPresets;
    }
  }

  Future<void> _persist() {
    return _prefs.setString(
      _storageKey,
      jsonEncode(state.map((item) => item.toJson()).toList(growable: false)),
    );
  }
}

@immutable
class StatusAutomationState {
  const StatusAutomationState({this.enabled = false, this.presetIndex = 0});
  final bool enabled;
  final int presetIndex;
}

final statusAutomationProvider =
    StateNotifierProvider<StatusAutomationNotifier, StatusAutomationState>(
      (ref) => StatusAutomationNotifier(ref.watch(sharedPreferencesProvider)),
    );

class StatusAutomationNotifier extends StateNotifier<StatusAutomationState> {
  StatusAutomationNotifier(this._prefs) : super(const StatusAutomationState()) {
    state = StatusAutomationState(
      enabled: _prefs.getBool('status_auto_change_enabled') ?? false,
      presetIndex: _prefs.getInt('status_auto_change_preset') ?? 0,
    );
  }

  final SharedPreferences _prefs;

  Future<void> setEnabled(bool enabled) async {
    state = StatusAutomationState(
      enabled: enabled,
      presetIndex: state.presetIndex,
    );
    await _prefs.setBool('status_auto_change_enabled', enabled);
  }

  Future<void> setPresetIndex(int index) async {
    state = StatusAutomationState(enabled: state.enabled, presetIndex: index);
    await _prefs.setInt('status_auto_change_preset', index);
  }

  Future<void> applyIfEnabled(WidgetRef ref) async {
    if (!state.enabled) return;
    final presets = ref.read(statusPresetsProvider);
    if (presets.isEmpty) return;
    final index = state.presetIndex < 0
        ? 0
        : state.presetIndex >= presets.length
        ? presets.length - 1
        : state.presetIndex;
    final preset = presets[index];
    await ref.read(statusPresetsProvider.notifier).apply(preset, ref);
  }
}

class ServerStatus {
  const ServerStatus({
    required this.ok,
    required this.serverName,
    required this.version,
  });
  final bool ok;
  final String serverName;
  final String version;
}

final apiServerStatusProvider = FutureProvider<ServerStatus>((ref) async {
  final api = await ref.watch(vrchatRawApiProvider);
  late final dio.Response<Object?> response;
  try {
    response = await api.dio.get<Object>('/health');
  } on dio.DioException catch (error) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null) {
      return ServerStatus(
        ok: statusCode < 500,
        serverName: 'VRChat API',
        version: 'Health endpoint HTTP $statusCode',
      );
    }
    rethrow;
  }
  final data = response.data;
  if (data is Map) {
    final json = Map<String, dynamic>.from(data);
    return ServerStatus(
      ok: json['ok'] == true,
      serverName: json['serverName'] as String? ?? 'VRChat API',
      version: json['buildVersionTag'] as String? ?? 'unknown',
    );
  }
  return const ServerStatus(
    ok: false,
    serverName: 'VRChat API',
    version: 'Empty health response',
  );
});

final discordNamesProvider =
    StateNotifierProvider<DiscordNamesNotifier, Map<String, String>>((ref) {
      return DiscordNamesNotifier(ref.watch(sharedPreferencesProvider));
    });

class DiscordNamesNotifier extends StateNotifier<Map<String, String>> {
  DiscordNamesNotifier(this._prefs) : super(const {}) {
    state = _read();
  }

  static const _storageKey = 'discord_names_v1';
  final SharedPreferences _prefs;
  final _pattern = RegExp(
    r'(?:discord|discord名|dc)\s*[:：：]?\s*([A-Za-z0-9_.-]{2,})',
    caseSensitive: false,
  );

  Future<void> scan(Iterable<LimitedUser> friends) async {
    final next = {...state};
    for (final friend in friends) {
      final match = _pattern.firstMatch(friend.bio ?? '');
      if (match != null) next[friend.id] = match.group(1)!;
    }
    state = next;
    await _prefs.setString(_storageKey, jsonEncode(next));
  }

  Future<void> set(String userId, String name) async {
    final next = {...state, userId: name.trim()};
    if (next[userId]!.isEmpty) next.remove(userId);
    state = next;
    await _prefs.setString(_storageKey, jsonEncode(next));
  }

  Map<String, String> _read() {
    final raw = _prefs.getString(_storageKey);
    if (raw == null) return const {};
    try {
      return Map<String, String>.from(jsonDecode(raw) as Map);
    } on Object {
      return const {};
    }
  }
}

class DataTransferService {
  const DataTransferService(this._prefs);
  final SharedPreferences _prefs;

  Map<String, dynamic> exportLocalData({
    required Iterable<ActivityRecord> activity,
    required Iterable<StatusPreset> presets,
    required Set<String> watchedFriends,
    required Map<String, String> discordNames,
  }) {
    final notes = <String, String>{};
    for (final key in _prefs.getKeys().where(
      (key) => key.startsWith('user_note_'),
    )) {
      final value = _prefs.getString(key);
      if (value != null) notes[key.substring('user_note_'.length)] = value;
    }
    return {
      'format': 'vrcn-export-v1',
      'exportedAt': DateTime.now().toIso8601String(),
      'activity': activity.map((item) => item.toJson()).toList(growable: false),
      'statusPresets': presets
          .map((item) => item.toJson())
          .toList(growable: false),
      'watchedFriends': watchedFriends.toList(growable: false),
      'discordNames': discordNames,
      'notes': notes,
    };
  }

  Future<void> importLocalData(
    String source, {
    required ActivityHistoryNotifier activityNotifier,
    required StatusPresetNotifier statusNotifier,
    required WatchedFriendIdsNotifier watchedNotifier,
    required DiscordNamesNotifier discordNotifier,
  }) async {
    final decoded = jsonDecode(source);
    if (decoded is! Map || decoded['format'] != 'vrcn-export-v1') {
      throw const FormatException('Unsupported VRCN export format');
    }
    final activity = (decoded['activity'] as List? ?? const [])
        .whereType<Map>()
        .map(
          (item) => ActivityRecord.fromJson(Map<String, dynamic>.from(item)),
        );
    await activityNotifier.replaceAll(activity);

    final presets = (decoded['statusPresets'] as List? ?? const [])
        .whereType<Map>()
        .map((item) => StatusPreset.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
    if (presets.isNotEmpty) {
      for (final preset in presets) {
        await statusNotifier.save(preset);
      }
    }

    final watched = (decoded['watchedFriends'] as List? ?? const [])
        .whereType<String>()
        .toSet();
    await watchedNotifier.replace(watched);

    final discord = Map<String, String>.from(
      decoded['discordNames'] as Map? ?? const {},
    );
    for (final entry in discord.entries) {
      await discordNotifier.set(entry.key, entry.value);
    }

    final notes = Map<String, String>.from(
      decoded['notes'] as Map? ?? const {},
    );
    for (final entry in notes.entries) {
      await _prefs.setString('user_note_${entry.key}', entry.value);
    }
  }
}

final dataTransferServiceProvider = Provider<DataTransferService>((ref) {
  return DataTransferService(ref.watch(sharedPreferencesProvider));
});
