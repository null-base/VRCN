import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/api/notification_response_sanitizer.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/event_reminder_provider.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/vrchat_extended_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrchat/utils/app_logger.dart';

final localActivityNotificationsProvider =
    StateNotifierProvider<
      LocalActivityNotificationsNotifier,
      List<NotificationItem>
    >((
      ref,
    ) {
      return LocalActivityNotificationsNotifier();
    });

final StateNotifierProvider<
  LocalActivityNotificationsNotifier,
  List<NotificationItem>
>
notificationsProvider = localActivityNotificationsProvider;

class LocalActivityNotificationsNotifier
    extends StateNotifier<List<NotificationItem>> {
  LocalActivityNotificationsNotifier() : super(const []);

  void addNotification(NotificationItem notification) {
    state = [notification, ...state];
  }

  void markAsRead(int index) {
    if (index < 0 || index >= state.length) return;
    final updatedNotifications = [...state];
    final current = updatedNotifications[index];
    updatedNotifications[index] = current.copyWith(isRead: true);
    state = updatedNotifications;
  }

  void markAllAsRead() {
    state = [
      for (final notification in state) notification.copyWith(isRead: true),
    ];
  }

  void removeAt(int index) {
    if (index < 0 || index >= state.length) return;
    state = [
      for (var i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void clearAll() {
    state = const [];
  }
}

enum NotificationType {
  friendRequest,
  invite,
  friendOnline,
  friendOffline,
  friendActive,
  friendAdd,
  friendRemove,
  statusUpdate,
  locationChange,
  userUpdate,
  myLocationChange,
  requestInvite,
  votekick,
  responseReceived,
  error,
  system,
}

@immutable
class NotificationItem {
  const NotificationItem({
    required this.type,
    required this.userName,
    this.worldName,
    required this.timestamp,
    required this.isRead,
    this.extraData,
  });

  final NotificationType type;
  final String userName;
  final String? worldName;
  final DateTime timestamp;
  final bool isRead;
  final String? extraData;

  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      type: type,
      userName: userName,
      worldName: worldName,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
      extraData: extraData,
    );
  }
}

final vrchatNotificationsProvider = FutureProvider<List<NotificationV2>>((
  ref,
) async {
  final rawApi = await ref.watch(vrchatRawApiProvider);
  final response = await rawApi.dio.get<Object>(
    '/notifications',
    queryParameters: {'limit': 100},
  );
  final rawData = response.data;
  NotificationResponseSanitizer.sanitize(
    response.requestOptions.path,
    rawData,
  );

  final notifications = _parseNotificationV2List(rawData);
  return [...notifications]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
});

List<NotificationV2> _parseNotificationV2List(Object? rawData) {
  if (rawData is! List) return const <NotificationV2>[];

  final notifications = <NotificationV2>[];
  for (final item in rawData) {
    if (item is! Map) continue;

    try {
      notifications.add(
        NotificationV2.fromJson(Map<String, dynamic>.from(item)),
      );
    } catch (error) {
      // Keep one malformed notification from breaking the whole page.
      appLogger.d('通知の解析をスキップしました: $error');
    }
  }
  return notifications;
}

final notificationActionsProvider = Provider<NotificationActions>(
  NotificationActions.new,
);

class NotificationActions {
  const NotificationActions(this._ref);
  final Ref _ref;

  Future<void> markAsRead(String notificationId) async {
    final api = await _ref.read(vrchatNotificationsApiProvider.future);
    await api.acknowledgeNotificationV2(notificationId: notificationId);
    _ref.invalidate(vrchatNotificationsProvider);
  }

  Future<void> markAllAsRead() async {
    final api = await _ref.read(vrchatNotificationsApiProvider.future);
    final notifications = await _ref.read(vrchatNotificationsProvider.future);
    final unread = notifications.where((item) => !item.seen);
    await Future.wait(
      unread.map(
        (item) => api.acknowledgeNotificationV2(notificationId: item.id),
      ),
    );
    _ref.read(localActivityNotificationsProvider.notifier).markAllAsRead();
    _ref.invalidate(vrchatNotificationsProvider);
  }

  Future<void> delete(String notificationId) async {
    final api = await _ref.read(vrchatNotificationsApiProvider.future);
    await api.deleteNotificationV2(notificationId: notificationId);
    _ref.invalidate(vrchatNotificationsProvider);
  }

  Future<void> respond(String notificationId, String responseType) async {
    final api = await _ref.read(vrchatNotificationsApiProvider.future);
    await api.respondNotificationV2(
      notificationId: notificationId,
      respondNotificationV2Request: RespondNotificationV2Request(
        responseType: responseType,
      ),
    );
    _ref.invalidate(vrchatNotificationsProvider);
  }

  Future<void> reply(String notificationId, String responseData) async {
    final api = await _ref.read(vrchatNotificationsApiProvider.future);
    await api.replyNotificationV2(
      notificationId: notificationId,
      body: {'responseData': responseData},
    );
    _ref.invalidate(vrchatNotificationsProvider);
  }

  Future<void> deleteAll() async {
    final api = await _ref.read(vrchatNotificationsApiProvider.future);
    await api.deleteAllNotificationV2s();
    _ref.read(localActivityNotificationsProvider.notifier).clearAll();
    _ref.invalidate(vrchatNotificationsProvider);
  }
}

final watchedFriendIdsProvider =
    StateNotifierProvider<WatchedFriendIdsNotifier, Set<String>>((ref) {
      final prefs = ref.watch(sharedPreferencesProvider);
      return WatchedFriendIdsNotifier(prefs);
    });

class WatchedFriendIdsNotifier extends StateNotifier<Set<String>> {
  WatchedFriendIdsNotifier(this._prefs)
    : super(_prefs.getStringList(_storageKey)?.toSet() ?? const <String>{});

  static const _storageKey = 'watched_friend_online_ids';
  final SharedPreferences _prefs;

  Future<void> toggle(String userId) async {
    final next = {...state};
    if (!next.add(userId)) {
      next.remove(userId);
    }
    state = next;
    await _prefs.setStringList(_storageKey, next.toList()..sort());
  }

  Future<void> replace(Set<String> userIds) async {
    state = userIds;
    await _prefs.setStringList(_storageKey, userIds.toList()..sort());
  }
}

final friendOnlineWatcherProvider = Provider<FriendOnlineWatcher>((ref) {
  final watcher = FriendOnlineWatcher(ref);
  watcher.start();
  ref.onDispose(watcher.dispose);
  return watcher;
});

class FriendOnlineWatcher {
  FriendOnlineWatcher(this._ref);

  final Ref _ref;
  Timer? _timer;
  Set<String> _knownOnlineIds = const {};
  var _hasBaseline = false;
  var _isChecking = false;

  void start() {
    _timer ??= Timer.periodic(const Duration(minutes: 2), (_) => _check());
    unawaited(_check());
  }

  void dispose() {
    _timer?.cancel();
  }

  Future<void> _check() async {
    if (_isChecking) return;
    _isChecking = true;
    try {
      final watchedIds = _ref.read(watchedFriendIdsProvider);
      if (watchedIds.isEmpty) {
        _knownOnlineIds = const {};
        _hasBaseline = false;
        return;
      }

      final rawApi = await _ref.read(vrchatRawApiProvider);
      final onlineFriends = <LimitedUserFriend>[];
      var offset = 0;

      while (true) {
        final (success, failure) = await rawApi
            .getFriendsApi()
            .getFriends(offline: false, n: 100, offset: offset)
            .validateVrc();

        if (success == null) {
          appLogger.d('オンライン通知用フレンド取得に失敗: $failure');
          return;
        }

        final batch = success.data;
        onlineFriends.addAll(batch);
        if (batch.length < 100) break;
        offset += 100;
      }

      _ref
          .read(friendsProvider.notifier)
          .updateWatchedFriendPresence(watchedIds, onlineFriends);

      final onlineIds = onlineFriends.map((friend) => friend.id).toSet();
      if (!_hasBaseline) {
        _knownOnlineIds = onlineIds;
        _hasBaseline = true;
        return;
      }

      final newlyOnline = onlineFriends.where(
        (friend) =>
            watchedIds.contains(friend.id) &&
            !_knownOnlineIds.contains(friend.id),
      );

      for (final friend in newlyOnline) {
        await _showFriendOnlineNotification(friend);
      }

      _knownOnlineIds = onlineIds;
    } catch (error) {
      appLogger.d('オンライン通知チェック中にエラー: $error');
    } finally {
      _isChecking = false;
    }
  }

  Future<void> _showFriendOnlineNotification(LimitedUserFriend friend) async {
    final notifications = _ref.read(localNotificationsProvider);

    final androidDetails = AndroidNotificationDetails(
      'friend_online',
      t.notifications.friendOnlineChannel,
      channelDescription: t.notifications.friendOnlineChannelDescription,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    final details = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await notifications.show(
      id: Object.hash('friend_online', friend.id),
      title: 'VRCN',
      body: t.notifications.friendOnline(userName: friend.displayName),
      notificationDetails: details,
      payload: 'friend:${friend.id}',
    );
  }
}
