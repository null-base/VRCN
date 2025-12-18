import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/pages/notifications_page.dart';

// 通知リストを管理するプロバイダー
final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<NotificationItem>>((ref) {
      return NotificationsNotifier();
    });

// 通知を管理するNotifierクラス
class NotificationsNotifier extends StateNotifier<List<NotificationItem>> {
  NotificationsNotifier() : super([]);

  // 新しい通知を追加
  void addNotification(NotificationItem notification) {
    state = [notification, ...state];
  }

  // 通知を既読にマーク
  void markAsRead(int index) {
    if (index >= 0 && index < state.length) {
      final updatedNotifications = [...state];
      final current = updatedNotifications[index];
      updatedNotifications[index] = NotificationItem(
        type: current.type,
        userName: current.userName,
        worldName: current.worldName,
        timestamp: current.timestamp,
        isRead: true,
      );
      state = updatedNotifications;
    }
  }

  // すべての通知を既読にマーク
  void markAllAsRead() {
    state =
        state
            .map(
              (notification) => NotificationItem(
                type: notification.type,
                userName: notification.userName,
                worldName: notification.worldName,
                timestamp: notification.timestamp,
                isRead: true,
              ),
            )
            .toList();
  }

  // すべての通知を削除
  void clearAll() {
    state = [];
  }
}
