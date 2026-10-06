import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/utils/app_logger.dart';
import 'package:vrchat/utils/status_helpers.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final friendStatusWidgetServiceProvider = Provider<FriendStatusWidgetService>((
  ref,
) {
  return const FriendStatusWidgetService();
});

final friendStatusWidgetSyncProvider = Provider<void>((ref) {
  final service = ref.watch(friendStatusWidgetServiceProvider);

  Future<void> sync() async {
    final watchedIds = ref.read(watchedFriendIdsProvider);
    final friends = ref.read(friendsProvider).asData?.value;
    if (friends == null) return;
    await service.update(friends: friends, watchedIds: watchedIds);
  }

  ref
    ..listen(watchedFriendIdsProvider, (_, _) => unawaited(sync()))
    ..listen(friendsProvider, (_, _) => unawaited(sync()));

  unawaited(sync());
});

class FriendStatusWidgetService {
  const FriendStatusWidgetService();

  static const _channel = MethodChannel('vrcn/friend_status_widget');

  Future<void> update({
    required List<LimitedUser> friends,
    required Set<String> watchedIds,
  }) async {
    final entries = friends.map(_FriendStatusWidgetEntry.fromFriend).toList()
      ..sort((a, b) {
        if (a.isOnline != b.isOnline) return a.isOnline ? -1 : 1;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

    await _invoke('update', {
      'friends': entries
          .where((entry) => watchedIds.contains(entry.id))
          .map((entry) => entry.toJson())
          .toList(),
      'allFriends': entries.map((entry) => entry.toJson()).toList(),
    });
  }

  Future<void> clear() => _invoke('clear');

  Future<void> _invoke(String method, [Object? arguments]) async {
    try {
      await _channel.invokeMethod<void>(method, arguments);
    } on MissingPluginException {
      // Desktop/tests do not have native widget handlers.
    } on PlatformException catch (error) {
      appLogger.d('フレンド状態ウィジェット更新に失敗: ${error.message}');
    }
  }
}

class _FriendStatusWidgetEntry {
  const _FriendStatusWidgetEntry({
    required this.id,
    required this.name,
    required this.status,
    required this.statusLabel,
    required this.location,
    required this.isOnline,
    required this.updatedAt,
  });

  factory _FriendStatusWidgetEntry.fromFriend(LimitedUser friend) {
    final location = friend.location ?? 'unknown';
    final isOnline = location != 'offline';
    final status = !isOnline
        ? UserStatus.offline
        : friend.status == UserStatus.offline
        ? UserStatus.active
        : friend.status;
    return _FriendStatusWidgetEntry(
      id: friend.id,
      name: friend.displayName,
      status: status.name,
      statusLabel: status.text,
      location: location,
      isOnline: isOnline,
      updatedAt: DateTime.timestamp().toIso8601String(),
    );
  }

  final String id;
  final String name;
  final String status;
  final String statusLabel;
  final String location;
  final bool isOnline;
  final String updatedAt;

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'statusLabel': statusLabel,
      'location': location,
      'isOnline': isOnline,
      'updatedAt': updatedAt,
    };
  }
}
