import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/models/notification_view_models.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class NotificationController {
  const NotificationController(this.ref);

  final Ref ref;

  Future<void> refresh() async {
    ref.invalidate(vrchatNotificationsProvider);
    await ref.read(vrchatNotificationsProvider.future);
  }

  List<NotificationEntry> mergeNotifications({
    required List<NotificationV2> apiNotifications,
    required List<NotificationItem> activityNotifications,
  }) {
    final entries = <NotificationEntry>[
      for (final notification in apiNotifications)
        NotificationEntry.api(notification),
      for (var index = 0; index < activityNotifications.length; index++)
        NotificationEntry.activity(activityNotifications[index], index),
    ];

    return entries..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<NotificationEntry> filterNotifications(
    List<NotificationEntry> entries,
    NotificationFilter filter,
  ) {
    return switch (filter) {
      NotificationFilter.unread =>
        entries.where((notification) => !notification.isRead).toList(),
      NotificationFilter.read =>
        entries.where((notification) => notification.isRead).toList(),
      NotificationFilter.all => entries,
    };
  }

  Future<void> markApiAsRead(String notificationId) {
    return ref.read(notificationActionsProvider).markAsRead(notificationId);
  }

  Future<void> markAllApiAsRead() {
    return ref.read(notificationActionsProvider).markAllAsRead();
  }

  void markActivityAsRead(int index) {
    ref.read(localActivityNotificationsProvider.notifier).markAsRead(index);
  }

  Future<void> deleteApi(String notificationId) {
    return ref.read(notificationActionsProvider).delete(notificationId);
  }

  void deleteActivity(int index) {
    ref.read(localActivityNotificationsProvider.notifier).removeAt(index);
  }

  void toggleFriendAlert(String userId) {
    ref.read(watchedFriendIdsProvider.notifier).toggle(userId);
  }

  void refreshFriends() {
    ref.invalidate(friendsProvider);
  }
}

final notificationControllerProvider = Provider<NotificationController>((ref) {
  return NotificationController(ref);
});
