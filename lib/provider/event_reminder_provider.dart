import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/utils/app_logger.dart';

// リマインダーの時間オプション
enum ReminderTime {
  atStart(0, '開始時間'),
  fiveMinitues(5, '5分前'),
  tenMinitues(10, '10分前'),
  fifteenMinutes(15, '15分前'),
  thirtyMinutes(30, '30分前'),
  oneHour(60, '1時間前');

  final int minutes;
  final String label;
  const ReminderTime(this.minutes, this.label);
}

// イベントリマインダーモデル
@immutable
class EventReminder {
  const EventReminder({
    required this.eventId,
    required this.eventTitle,
    required this.eventTime,
    required this.reminderTime,
    required this.notificationId,
  });

  factory EventReminder.fromJson(Map<String, dynamic> json) {
    final eventTime = json['eventTime'] as int? ?? 0;
    final reminderTime = json['reminderTime'] as int? ?? 0;

    return EventReminder(
      eventId: json['eventId'] as String? ?? '',
      eventTitle: json['eventTitle'] as String? ?? '',
      eventTime: DateTime.fromMillisecondsSinceEpoch(eventTime),
      reminderTime: ReminderTime.values[reminderTime],
      notificationId: json['notificationId'] as int? ?? 0,
    );
  }
  final String eventId;
  final String eventTitle;
  final DateTime eventTime;
  final ReminderTime reminderTime;
  final int notificationId;

  DateTime get notificationTime {
    return eventTime.subtract(Duration(minutes: reminderTime.minutes));
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventTitle': eventTitle,
      'eventTime': eventTime.millisecondsSinceEpoch,
      'reminderTime': reminderTime.index,
      'notificationId': notificationId,
    };
  }
}

// イベントリマインダー管理クラス
class EventReminderNotifier extends StateNotifier<List<EventReminder>> {
  EventReminderNotifier(this.prefs, this.notifications) : super([]) {
    _loadReminders();
  }
  final SharedPreferences prefs;
  final FlutterLocalNotificationsPlugin notifications;

  // リマインダーをロード
  Future<void> _loadReminders() async {
    final reminderJson = prefs.getStringList('event_reminders') ?? [];
    final reminders = reminderJson
        .map((json) {
          final decoded = jsonDecode(json);
          return decoded is Map<String, dynamic>
              ? EventReminder.fromJson(decoded)
              : null;
        })
        .whereType<EventReminder>()
        .toList();

    // 過去の通知をフィルタリング
    final now = DateTime.timestamp();
    final validReminders = reminders
        .where((reminder) => reminder.eventTime.isAfter(now))
        .toList();

    // 過去の通知（すでに表示された通知）は削除
    for (final reminder in reminders) {
      if (reminder.notificationTime.isBefore(now)) {
        appLogger.d(
          '過去の通知を削除: 「${reminder.eventTitle}」${reminder.reminderTime.label}',
        );
        await notifications.cancel(id: reminder.notificationId);
      }
    }

    // 無効になった通知を削除
    if (validReminders.length != reminders.length) {
      appLogger.d(
        '${reminders.length - validReminders.length}件の過去のリマインダーを削除しました',
      );
      await _saveReminders(validReminders);
    }

    state = validReminders;
  }

  // リマインダーを保存
  Future<void> _saveReminders(List<EventReminder> reminders) async {
    final reminderJson = reminders
        .map((reminder) => jsonEncode(reminder.toJson()))
        .toList();
    await prefs.setStringList('event_reminders', reminderJson);
  }

  // 新しいリマインダーを追加
  Future<void> addReminder(EventReminder reminder) async {
    // 重複チェック
    if (state.any(
      (r) =>
          r.eventId == reminder.eventId &&
          r.reminderTime == reminder.reminderTime,
    )) {
      return;
    }

    // 通知をスケジュール
    await _scheduleNotification(reminder);

    // 状態を更新
    final newState = [...state, reminder];
    state = newState;
    await _saveReminders(newState);
  }

  // リマインダーを削除
  Future<void> removeReminder(
    String eventId,
    ReminderTime? reminderTime,
  ) async {
    final remindersToRemove = state
        .where(
          (r) =>
              r.eventId == eventId &&
              (reminderTime == null || r.reminderTime == reminderTime),
        )
        .toList();

    // 通知をキャンセル
    for (final reminder in remindersToRemove) {
      await notifications.cancel(id: reminder.notificationId);
    }

    // 状態を更新
    final newState = state
        .where(
          (r) =>
              !(r.eventId == eventId &&
                  (reminderTime == null || r.reminderTime == reminderTime)),
        )
        .toList();

    state = newState;
    await _saveReminders(newState);
  }

  // 通知IDからリマインダーを削除するメソッド
  Future<void> removeReminderByNotificationId(int notificationId) async {
    final reminderToRemove = state
        .where((reminder) => reminder.notificationId == notificationId)
        .toList();

    if (reminderToRemove.isEmpty) {
      appLogger.d('通知ID $notificationId に対応するリマインダーが見つかりませんでした');
      return;
    }

    for (final reminder in reminderToRemove) {
      appLogger.d('通知表示: 「${reminder.eventTitle}」のリマインダーを削除します');
      // 通知のキャンセルは不要（すでに表示されているため）

      // 状態を更新
      final newState = state
          .where((r) => r.notificationId != notificationId)
          .toList();

      state = newState;
      await _saveReminders(newState);
    }
  }

  // イベントの通知をスケジュール
  Future<void> _scheduleNotification(EventReminder reminder) async {
    final notificationTime = reminder.notificationTime;

    // 過去の時間の場合はスケジュールしない
    if (notificationTime.isBefore(DateTime.timestamp())) {
      appLogger.d('通知をスキップ: 過去の時間のため - ${reminder.eventTitle}');
      return;
    }

    try {
      // 通知の詳細を設定（変更なし）
      const androidDetails = AndroidNotificationDetails(
        'event_reminder_channel',
        'イベントリマインダー',
        channelDescription: 'VRChatのイベント開始前の通知',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'イベントリマインダー',
        color: Colors.purple,
        sound: RawResourceAndroidNotificationSound('notification_sound'),
        enableLights: true,
        visibility: NotificationVisibility.public,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'notification_sound.aiff',
        badgeNumber: 1,
      );

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // 日本時間として通知時間を設定（TimeZoneを明示的に指定）
      final scheduledDate = _createScheduledLocalNotificationDateTime(
        notificationTime,
      );

      appLogger.d(
        '通知をスケジュール: 「${reminder.eventTitle}」${reminder.reminderTime.label}',
      );
      appLogger.d('設定時間: ${notificationTime}');
      appLogger.d('スケジュール時間: ${scheduledDate}');

      // ここを修正：「〇〇前に始まります」→「〇〇後に始まります」
      final timeLabel = _formatTimeToFutureLabel(reminder.reminderTime.minutes);

      // _scheduleNotification メソッド内の通知テキスト部分
      final String notificationTitle;
      final String notificationBody;

      if (reminder.reminderTime.minutes == 0) {
        notificationTitle = 'イベント開始';
        notificationBody = '「${reminder.eventTitle}」が今から始まります';
      } else {
        notificationTitle = 'イベント開始まもなく';
        notificationBody = '「${reminder.eventTitle}」が$timeLabelに始まります';
      }

      await notifications.zonedSchedule(
        id: reminder.notificationId,
        title: notificationTitle,
        body: notificationBody,
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: reminder.eventId,
      );

      appLogger.d('通知スケジュール成功: ID=${reminder.notificationId}');
    } catch (e) {
      appLogger.d('通知スケジュールエラー: $e');
    }
  }

  // 分を「○○後」の形式に変換するヘルパーメソッド
  String _formatTimeToFutureLabel(int minutes) {
    if (minutes == 0) {
      return 'まもなく'; // イベント開始時間の場合
    } else if (minutes == 1440) {
      return '1日後';
    } else if (minutes >= 60 && minutes % 60 == 0) {
      return '${minutes ~/ 60}時間後';
    } else {
      return '$minutes分後';
    }
  }

  // すべてのリマインダーを再スケジュール（アプリ起動時などに使用）
  Future<void> rescheduleAllNotifications() async {
    // すべての通知をキャンセル
    await notifications.cancelAll();

    // 現在の時刻より後の通知だけを再スケジュール
    final now = DateTime.timestamp();
    for (final reminder in state) {
      if (reminder.notificationTime.isAfter(now)) {
        await _scheduleNotification(reminder);
      }
    }
  }

  // イベントIDに関連するすべてのリマインダーを取得
  List<EventReminder> getRemindersForEvent(String eventId) {
    return state.where((r) => r.eventId == eventId).toList();
  }

  // すべての通知をキャンセル
  Future<void> cancelAllNotifications() async {
    try {
      await notifications.cancelAll();
      appLogger.d('すべての通知をキャンセルしました');
    } catch (e) {
      appLogger.d('通知キャンセルエラー: $e');
    }
  }

  Future<void> cleanupOldReminders() async {
    // 過去の通知を全てチェック
    final now = DateTime.timestamp();
    final oldReminders = state
        .where((reminder) => reminder.notificationTime.isBefore(now))
        .toList();

    if (oldReminders.isNotEmpty) {
      appLogger.d('${oldReminders.length}件の過去のリマインダーをクリーンアップします');

      // 通知をキャンセル
      for (final reminder in oldReminders) {
        await notifications.cancel(id: reminder.notificationId);
      }

      // 状態を更新
      final newState = state
          .where((reminder) => reminder.notificationTime.isAfter(now))
          .toList();

      state = newState;
      await _saveReminders(newState);
    }
  }
}

// 通知スケジュール用の日本時間TZDateTimeを作成
tz.TZDateTime _createScheduledLocalNotificationDateTime(DateTime dateTime) {
  // 日本時間として扱い、TZDateTimeに変換
  final scheduledDate = tz.TZDateTime(
    tz.local,
    dateTime.year,
    dateTime.month,
    dateTime.day,
    dateTime.hour,
    dateTime.minute,
    dateTime.second,
  );

  return scheduledDate;
}

// プロバイダー
final eventReminderProvider =
    StateNotifierProvider<EventReminderNotifier, List<EventReminder>>((ref) {
      final prefs = ref.watch(sharedPreferencesProvider);
      final notifications = ref.watch(localNotificationsProvider);
      return EventReminderNotifier(prefs, notifications);
    });

// 通知IDを生成するヘルパー関数
int generateNotificationId(String eventId, ReminderTime reminderTime) {
  // 衝突しにくいようにハッシュとインデックスを組み合わせる
  return eventId.hashCode + reminderTime.index;
}

final localNotificationsProvider = Provider<FlutterLocalNotificationsPlugin>((
  ref,
) {
  throw UnimplementedError('通知プラグインが初期化されていません');
});
