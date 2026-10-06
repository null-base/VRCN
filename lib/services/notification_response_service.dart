import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/event_reminder_provider.dart';
import 'package:vrchat/utils/app_logger.dart';

Future<void> handleNotificationResponse(
  ProviderContainer container,
  NotificationResponse response,
) async {
  final notificationId = response.id;
  if (notificationId != null) {
    await container
        .read(eventReminderProvider.notifier)
        .removeReminderByNotificationId(notificationId);
  }

  appLogger.d('🔔 通知がタップされました: ${response.payload}');
}
