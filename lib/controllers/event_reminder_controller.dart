import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/event_reminder_provider.dart';

class EventReminderController {
  const EventReminderController(this.ref);

  final Ref ref;

  Future<void> addReminder(EventReminder reminder) {
    return ref.read(eventReminderProvider.notifier).addReminder(reminder);
  }

  Future<void> removeReminder(
    String eventId,
    ReminderTime? reminderTime,
  ) {
    return ref
        .read(eventReminderProvider.notifier)
        .removeReminder(eventId, reminderTime);
  }

  Future<void> cancelAllNotifications() {
    return ref.read(eventReminderProvider.notifier).cancelAllNotifications();
  }

  Future<void> rescheduleAllNotifications() {
    return ref
        .read(eventReminderProvider.notifier)
        .rescheduleAllNotifications();
  }
}

final eventReminderControllerProvider = Provider<EventReminderController>((
  ref,
) {
  return EventReminderController(ref);
});
