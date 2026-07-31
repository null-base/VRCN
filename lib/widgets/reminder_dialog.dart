import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/controllers/event_reminder_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/models/event_calendar_models.dart';
import 'package:vrchat/provider/event_reminder_provider.dart';
import 'package:vrchat/theme/app_theme.dart';

class ReminderDialog extends ConsumerStatefulWidget {
  const ReminderDialog({
    super.key,
    required this.event,
    required this.isDarkMode,
  });
  final Event event;
  final bool isDarkMode;

  @override
  ConsumerState<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends ConsumerState<ReminderDialog> {
  ReminderTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    final eventTime = DateFormat('yyyy/MM/dd HH:mm').format(widget.event.start);
    final reminders = ref
        .watch(eventReminderProvider)
        .where((r) => r.eventId == widget.event.id)
        .map((r) => r.reminderTime)
        .toSet();

    return AlertDialog(
      title: Text(
        t.reminder.dialogTitle,
        style: GoogleFonts.notoSans(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.event.title,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.event,
                size: 14,
                color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                eventTime,
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: widget.isDarkMode
                      ? Colors.grey[400]
                      : Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            t.reminder.receiveNotification,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          ...ReminderTime.values.map((time) {
            final isSelected = _selectedTime == time;
            final isAlreadySet = reminders.contains(time);
            final isDisabled =
                isAlreadySet ||
                widget.event.start
                    .subtract(Duration(minutes: time.minutes))
                    .isBefore(DateTime.timestamp());

            return _buildTimeOption(
              time: time,
              isSelected: isSelected,
              isDisabled: isDisabled,
              isAlreadySet: isAlreadySet,
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.reminder.cancel, style: GoogleFonts.notoSans()),
        ),
        ElevatedButton(
          onPressed: _selectedTime == null ? null : () => _addReminder(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: Text(t.reminder.set, style: GoogleFonts.notoSans()),
        ),
      ],
    );
  }

  Widget _buildTimeOption({
    required ReminderTime time,
    required bool isSelected,
    required bool isDisabled,
    required bool isAlreadySet,
  }) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        title: Row(
          children: [
            Text(
              time.label,
              style: GoogleFonts.notoSans(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isAlreadySet) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  t.reminder.alreadySet,
                  style: GoogleFonts.notoSans(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
        leading: Radio<ReminderTime>(
          value: time,
          groupValue: _selectedTime,
          onChanged: isDisabled
              ? null
              : (value) {
                  setState(() {
                    _selectedTime = value;
                  });
                },
          activeColor: AppTheme.primaryColor,
        ),
        onTap: isDisabled
            ? null
            : () {
                setState(() {
                  _selectedTime = time;
                });
              },
      ),
    );
  }

  void _addReminder(BuildContext context) {
    if (_selectedTime == null) return;

    // 通知IDを生成
    final notificationId = generateNotificationId(
      widget.event.id,
      _selectedTime!,
    );

    // リマインダーを作成
    final reminder = EventReminder(
      eventId: widget.event.id,
      eventTitle: widget.event.title,
      eventTime: widget.event.start,
      reminderTime: _selectedTime!,
      notificationId: notificationId,
    );

    // リマインダーを追加
    ref.read(eventReminderControllerProvider).addReminder(reminder);

    // 成功メッセージを表示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedTime!.label}${t.reminder.set}'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    // ダイアログを閉じる
    Navigator.pop(context);
  }
}
