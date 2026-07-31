import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

enum NotificationFilter { all, unread, read }

enum NotificationEntrySource { api, activity }

class NotificationEntry {
  const NotificationEntry.api(this.apiNotification)
    : activityNotification = null,
      activityIndex = null,
      source = NotificationEntrySource.api;

  const NotificationEntry.activity(
    this.activityNotification,
    this.activityIndex,
  ) : apiNotification = null,
      source = NotificationEntrySource.activity;

  final NotificationV2? apiNotification;
  final NotificationItem? activityNotification;
  final int? activityIndex;
  final NotificationEntrySource source;

  bool get isActivity => source == NotificationEntrySource.activity;
  bool get isRead => apiNotification?.seen ?? activityNotification!.isRead;
  bool get canDelete => apiNotification?.canDelete ?? true;
  DateTime get createdAt =>
      apiNotification?.createdAt ?? activityNotification!.timestamp;
  String get keyValue => apiNotification?.id ?? 'activity-$activityIndex';
}
