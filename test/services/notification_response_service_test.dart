import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/provider/event_reminder_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/services/notification_response_service.dart';

void main() {
  test(
    'notification tap removes a persisted reminder from the app container',
    () async {
      final reminder = EventReminder(
        eventId: 'event-1',
        eventTitle: 'Event',
        eventTime: DateTime.now().add(const Duration(days: 1)),
        reminderTime: ReminderTime.fiveMinitues,
        notificationId: 42,
      );
      SharedPreferences.setMockInitialValues({
        'event_reminders': [jsonEncode(reminder.toJson())],
      });
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          localNotificationsProvider.overrideWithValue(
            FlutterLocalNotificationsPlugin(),
          ),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(eventReminderProvider), hasLength(1));

      await handleNotificationResponse(
        container,
        const NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          id: 42,
        ),
      );

      expect(container.read(eventReminderProvider), isEmpty);
      expect(prefs.getStringList('event_reminders'), isEmpty);
    },
  );

  test('a malformed saved reminder does not block valid reminders', () async {
    final reminder = EventReminder(
      eventId: 'event-2',
      eventTitle: 'Another event',
      eventTime: DateTime.now().add(const Duration(days: 1)),
      reminderTime: ReminderTime.atStart,
      notificationId: 43,
    );
    SharedPreferences.setMockInitialValues({
      'event_reminders': [
        '{invalid json',
        jsonEncode({'reminderTime': 999}),
        jsonEncode(reminder.toJson()),
      ],
    });
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        localNotificationsProvider.overrideWithValue(
          FlutterLocalNotificationsPlugin(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(eventReminderProvider).single.eventId, 'event-2');
  });
}
