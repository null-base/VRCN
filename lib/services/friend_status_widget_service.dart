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
    final friends = ref
        .read(friendsProvider)
        .maybeWhen(
          data: (friends) => friends,
          orElse: () => const <LimitedUser>[],
        );
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
    final entries =
        friends
            .where((friend) => watchedIds.contains(friend.id))
            .map(_FriendStatusWidgetEntry.fromFriend)
            .toList()
          ..sort((a, b) {
            final onlineCompare = b.isOnline.toString().compareTo(
              a.isOnline.toString(),
            );
            if (onlineCompare != 0) return onlineCompare;
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });

    await _invoke('update', {
      'friends': entries.map((entry) => entry.toJson()).toList(),
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
    required this.updatedAt,
  });

  factory _FriendStatusWidgetEntry.fromFriend(LimitedUser friend) {
    final location = friend.location ?? 'unknown';
    return _FriendStatusWidgetEntry(
      id: friend.id,
      name: friend.displayName,
      status: friend.status.name,
      statusLabel: friend.status.text,
      location: location,
      updatedAt: DateTime.timestamp().toIso8601String(),
    );
  }

  final String id;
  final String name;
  final String status;
  final String statusLabel;
  final String location;
  final String updatedAt;

  bool get isOnline => status != UserStatus.offline.name;

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'statusLabel': statusLabel,
      'location': location,
      'updatedAt': updatedAt,
    };
  }
}
