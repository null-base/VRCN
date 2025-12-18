import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrchat/config/app_config.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/event_filter_provider.dart';
import 'package:vrchat/provider/event_reminder_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/event_filter_sheet.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/reminder_dialog.dart';

// イベントデータを取得するためのプロバイダー
final eventDataProvider = FutureProvider<EventData>((ref) async {
  final response = await http.get(Uri.parse(AppConfig.eventCalender));
  if (response.statusCode == 200) {
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('イベントデータの取得に失敗しました');
  }
});

// 日本時間のDateTimeを作成するヘルパー関数
DateTime _parseJapanTime(String dateString) {
  try {
    // タイムゾーン情報を含む日時文字列をパース
    final parsedDateTime = DateTime.parse(dateString);

    // パースされた時間がUTCの場合、日本時間に変換
    if (parsedDateTime.isUtc) {
      // UTCとして解釈された場合、9時間を加算して日本時間に戻す
      return parsedDateTime.add(const Duration(hours: 9));
    } else {
      // ローカル時間として解釈された場合はそのまま返す
      return parsedDateTime;
    }
  } catch (e) {
    debugPrint('日時解析エラー: $e, 入力: $dateString');
    // フォールバック: 現在時刻を返す
    return DateTime.timestamp();
  }
}

// イベントデータモデル
@immutable
class EventData {
  final Map<String, int> genres;
  final List<Event> events;

  const EventData({required this.genres, required this.events});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      genres: Map<String, int>.from(json['genres'] ?? {}),
      events:
          (json['events'] as List? ?? [])
              .map((event) => Event.fromJson(event))
              .toList(),
    );
  }
}

// イベントモデル
@immutable
class Event {
  final String id;
  final bool quest;
  final String title;
  final DateTime start;
  final DateTime end;
  final String author;
  final String body;
  final List<String> genres;
  final String condition;
  final String way;
  final String note;

  const Event({
    required this.id,
    required this.quest,
    required this.title,
    required this.start,
    required this.end,
    required this.author,
    required this.body,
    required this.genres,
    required this.condition,
    required this.way,
    required this.note,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? '',
      quest: json['quest'] ?? false,
      title: json['title'] ?? '',
      start: _parseJapanTime(json['start'] ?? ''),
      end: _parseJapanTime(json['end'] ?? ''),
      author: json['author'] ?? '',
      body: json['body'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      condition: json['condition'] ?? '',
      way: json['way'] ?? '',
      note: json['note'] ?? '',
    );
  }
}

class EventCalendarPage extends ConsumerStatefulWidget {
  const EventCalendarPage({super.key});

  @override
  ConsumerState<EventCalendarPage> createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends ConsumerState<EventCalendarPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  var _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // リフレッシュアクション
  Future<void> _refreshEvents() async {
    setState(() {
      _isRefreshing = true;
    });

    // アニメーションを開始
    await _animationController.forward(from: 0);

    // データをリフレッシュ
    final _ = ref.refresh(eventDataProvider);

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  // フィルタリングされたイベントリストを取得するメソッド
  List<Event> _getFilteredEvents(List<Event> events, EventFilter filter) {
    return events.where((event) {
      // 日付フィルター
      if (filter.startDate != null) {
        final eventDate = DateTime(
          event.start.year,
          event.start.month,
          event.start.day,
        );
        final filterDate = DateTime(
          filter.startDate!.year,
          filter.startDate!.month,
          filter.startDate!.day,
        );
        if (eventDate.isBefore(filterDate)) return false;
      }

      if (filter.endDate != null) {
        final eventDate = DateTime(
          event.start.year,
          event.start.month,
          event.start.day,
        );
        final filterDate = DateTime(
          filter.endDate!.year,
          filter.endDate!.month,
          filter.endDate!.day,
        );
        if (eventDate.isAfter(filterDate)) return false;
      }

      // 時間フィルター
      if (filter.startTime != null) {
        final eventTime = TimeOfDay.fromDateTime(event.start);
        final minutes1 = eventTime.hour * 60 + eventTime.minute;
        final minutes2 = filter.startTime!.hour * 60 + filter.startTime!.minute;
        if (minutes1 < minutes2) return false;
      }

      if (filter.endTime != null) {
        final eventTime = TimeOfDay.fromDateTime(event.start);
        final minutes1 = eventTime.hour * 60 + eventTime.minute;
        final minutes2 = filter.endTime!.hour * 60 + filter.endTime!.minute;
        if (minutes1 > minutes2) return false;
      }

      // キーワード検索
      if (filter.searchQuery.isNotEmpty) {
        final query = filter.searchQuery.toLowerCase();
        final title = event.title.toLowerCase();
        final body = event.body.toLowerCase();
        final author = event.author.toLowerCase();

        if (!title.contains(query) &&
            !body.contains(query) &&
            !author.contains(query)) {
          return false;
        }
      }

      // ジャンルフィルター
      if (filter.selectedGenres.isNotEmpty) {
        if (!event.genres.any(
          (genre) => filter.selectedGenres.contains(genre),
        )) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  // フィルターUIを表示するダイアログを追加
  void _showFilterDialog(
    BuildContext context,
    bool isDarkMode,
    Map<String, int> genres,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) =>
              FilterBottomSheet(isDarkMode: isDarkMode, genres: genres),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventDataAsync = ref.watch(eventDataProvider);
    final themeMode = ref.watch(themeModeProvider);

    // テーマモードに基づいてダークモードかどうかを判定
    final isDarkMode = switch (themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system => Theme.of(context).brightness == Brightness.dark,
    };

    // 背景グラデーション
    final backgroundColor =
        isDarkMode ? const Color(0xFF121212) : const Color(0xFFF9F9F9);

    const accentColor = AppTheme.primaryColor;
    final secondaryColor =
        isDarkMode
            ? HSLColor.fromColor(accentColor).withLightness(0.3).toColor()
            : HSLColor.fromColor(accentColor).withLightness(0.8).toColor();

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          t.eventCalendar.title,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.8),
                border: Border(
                  bottom: BorderSide(
                    color:
                        isDarkMode
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          // フィルターボタン
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            color:
                _isRefreshing
                    ? Colors.grey
                    : isDarkMode
                    ? Colors.white
                    : Colors.black87,
            onPressed:
                _isRefreshing || !eventDataAsync.hasValue
                    ? null
                    : () => _showFilterDialog(
                      context,
                      isDarkMode,
                      eventDataAsync.value!.genres,
                    ),
            tooltip: t.eventCalendar.filter,
          ),

          // リフレッシュボタン
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animationController.value * 2 * 3.14159,
                child: IconButton(
                  icon: Icon(
                    Icons.refresh_rounded,
                    color:
                        _isRefreshing
                            ? Colors.grey
                            : isDarkMode
                            ? Colors.white
                            : Colors.black87,
                  ),
                  onPressed: _isRefreshing ? null : _refreshEvents,
                  tooltip: t.eventCalendar.refresh,
                ),
              );
            },
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor,
              isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: eventDataAsync.when(
            data:
                (eventData) => _buildEventList(
                  context,
                  eventData,
                  isDarkMode,
                  accentColor,
                  secondaryColor,
                  t,
                ),
            loading: () => LoadingIndicator(message: t.eventCalendar.loading),
            error:
                (error, stack) => ErrorContainer(
                  message: t.eventCalendar.error(error: error.toString()),
                  onRetry: _refreshEvents,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(
    BuildContext context,
    EventData eventData,
    bool isDarkMode,
    Color accentColor,
    Color secondaryColor,
    Translations t,
  ) {
    // フィルターを取得
    final filter = ref.watch(eventFilterProvider);

    // イベントにフィルターを適用
    final filteredEvents = _getFilteredEvents(eventData.events, filter);

    // 日付ごとにグループ化
    final eventsByDate = <String, List<Event>>{};
    final dateFormat = DateFormat('yyyy-MM-dd');

    for (final event in filteredEvents) {
      final dateKey = dateFormat.format(event.start);
      if (!eventsByDate.containsKey(dateKey)) {
        eventsByDate[dateKey] = [];
      }
      eventsByDate[dateKey]!.add(event);
    }

    // 日付でソート
    final sortedDates = eventsByDate.keys.toList()..sort();

    // フィルターが適用されているかのステータス表示
    final hasActiveFilter =
        filter.startDate != null ||
        filter.endDate != null ||
        filter.startTime != null ||
        filter.endTime != null ||
        filter.searchQuery.isNotEmpty ||
        filter.selectedGenres.isNotEmpty;

    return Column(
      children: [
        // フィルター状態バー
        if (hasActiveFilter)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? Colors.blue.withValues(alpha: 0.2)
                      : Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isDarkMode
                        ? Colors.blue.withValues(alpha: 0.3)
                        : Colors.blue.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.filter_list, size: 18, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    t.eventCalendar.filterActive(
                      count: filteredEvents.length.toString(),
                    ),
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton(
                  onPressed:
                      () => ref.read(eventFilterProvider.notifier).clearAll(),
                  child: Text(
                    t.eventCalendar.clear,
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        // イベントリスト
        if (sortedDates.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 64,
                    color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.eventCalendar.noEvents,
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed:
                        () => ref.read(eventFilterProvider.notifier).clearAll(),
                    icon: const Icon(Icons.filter_list_off),
                    label: Text(t.eventCalendar.clearFilter),
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                final dateKey = sortedDates[index];
                final events = eventsByDate[dateKey]!;

                // 日付ごとのイベントを時間順にソート
                events.sort((a, b) => a.start.compareTo(b.start));

                return _buildDateSection(
                  context,
                  dateKey,
                  events,
                  isDarkMode,
                  accentColor,
                  secondaryColor,
                  index,
                  t,
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildDateSection(
    BuildContext context,
    String dateKey,
    List<Event> events,
    bool isDarkMode,
    Color accentColor,
    Color secondaryColor,
    int index,
    Translations t,
  ) {
    // 日付をフォーマット
    final date = DateFormat('yyyy-MM-dd').parse(dateKey);
    final now = DateTime.timestamp();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;

    final displayDate = DateFormat('yyyy年MM月dd日 (E)', 'ja').format(date);

    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color:
                isDarkMode ? Colors.black.withValues(alpha: 0.3) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color:
                  isToday
                      ? accentColor.withValues(alpha: isDarkMode ? 0.5 : 0.3)
                      : isDarkMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.2),
              width: isToday ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              // 日付ヘッダー
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors:
                        isToday
                            ? [
                              accentColor.withValues(alpha: 0.8),
                              accentColor.withValues(alpha: 0.6),
                            ]
                            : isDarkMode
                            ? [
                              Colors.grey[850]!.withValues(alpha: 0.5),
                              Colors.grey[900]!.withValues(alpha: 0.5),
                            ]
                            : [
                              secondaryColor.withValues(alpha: 0.3),
                              secondaryColor.withValues(alpha: 0.1),
                            ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isToday ? Icons.calendar_today : Icons.calendar_month,
                      size: 18,
                      color:
                          isToday
                              ? (isDarkMode ? Colors.white : accentColor)
                              : (isDarkMode
                                  ? Colors.grey[300]
                                  : Colors.grey[700]),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      displayDate,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color:
                            isToday
                                ? (isDarkMode ? Colors.white : accentColor)
                                : (isDarkMode ? Colors.white : Colors.black87),
                      ),
                    ),
                    if (isToday) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          t.eventCalendar.today,
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: isDarkMode ? Colors.white : accentColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // イベントリスト
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: events.length,
                itemBuilder: (context, eventIndex) {
                  return _buildEventCard(
                        context,
                        events[eventIndex],
                        isDarkMode,
                        accentColor,
                        eventIndex,
                        t,
                      )
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 100 * eventIndex),
                        duration: const Duration(milliseconds: 500),
                      )
                      .slideX(
                        begin: 0.1,
                        end: 0,
                        curve: Curves.easeOutQuad,
                        delay: Duration(milliseconds: 100 * eventIndex),
                      );
                },
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 150 * index),
          duration: const Duration(milliseconds: 800),
        )
        .slideY(
          begin: 0.1,
          end: 0,
          curve: Curves.easeOutQuad,
          delay: Duration(milliseconds: 150 * index),
        );
  }

  Widget _buildEventCard(
    BuildContext context,
    Event event,
    bool isDarkMode,
    Color accentColor,
    int index,
    Translations t,
  ) {
    // 時間をフォーマット（日本時間として表示）
    final startTime = DateFormat('HH:mm').format(event.start);
    final endTime = DateFormat('HH:mm').format(event.end);

    // イベントの種類に基づいて色を選択
    final eventColor =
        event.genres.isNotEmpty
            ? _getGenreColor(event.genres.first, accentColor, isDarkMode)
            : accentColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              isDarkMode
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      color: isDarkMode ? Colors.black.withValues(alpha: 0.2) : Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.all(0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(
          event.title,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // リマインダー設定ボタン
            IconButton(
              icon: const Icon(Icons.notifications_outlined, size: 20),
              splashRadius: 20,
              tooltip: t.eventCalendar.reminderSet,
              onPressed: () => _showReminderDialog(context, event, isDarkMode),
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            ),

            // 展開アイコン（ビルトイン）
            // ExpansionTileは自動的にこれを追加するが、
            // trailingを上書きしたので手動で追加
            RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.chevron_right,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      t.eventCalendar.startToEnd(
                        start: startTime,
                        end: endTime,
                      ),
                      style: GoogleFonts.notoSans(
                        fontSize: 13,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (event.quest) _buildQuestBadge(isDarkMode, t),
                  Consumer(
                    builder: (context, ref, child) {
                      final reminders =
                          ref
                              .watch(eventReminderProvider)
                              .where((r) => r.eventId == event.id)
                              .toList();

                      if (reminders.isEmpty) return const SizedBox.shrink();

                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_active,
                              size: 14,
                              color: eventColor.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              t.eventCalendar.reminderCount(
                                count: reminders.length.toString(),
                              ),
                              style: GoogleFonts.notoSans(
                                fontSize: 11,
                                color: eventColor.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                eventColor.withValues(alpha: 0.8),
                eventColor.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: eventColor.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              startTime,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 区切り線
                Container(
                  height: 1,
                  color:
                      isDarkMode
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.withValues(alpha: 0.1),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                ),

                _buildInfoSection(
                  t.eventCalendar.eventName,
                  event.title,
                  Icons.calendar_month,
                  isDarkMode,
                  eventColor,
                ),
                const SizedBox(height: 16),

                _buildInfoSection(
                  t.eventCalendar.organizer,
                  event.author,
                  Icons.person_outline_rounded,
                  isDarkMode,
                  eventColor,
                ),
                const SizedBox(height: 16),

                _buildInfoSection(
                  t.eventCalendar.description,
                  event.body,
                  Icons.description_outlined,
                  isDarkMode,
                  eventColor,
                ),
                const SizedBox(height: 16),

                _buildGenreChips(event.genres, isDarkMode, eventColor, t),
                const SizedBox(height: 16),

                _buildInfoSection(
                  t.eventCalendar.condition,
                  event.condition,
                  Icons.verified_user_outlined,
                  isDarkMode,
                  eventColor,
                ),
                const SizedBox(height: 16),

                _buildInfoSection(
                  t.eventCalendar.way,
                  event.way,
                  Icons.login_rounded,
                  isDarkMode,
                  eventColor,
                ),
                if (event.note.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildInfoWithLink(
                    t.eventCalendar.note,
                    event.note,
                    Icons.sticky_note_2_outlined,
                    isDarkMode,
                    eventColor,
                  ),
                ],

                const SizedBox(height: 16),
                // 通知設定ボタン
                Center(
                  child: OutlinedButton.icon(
                    onPressed:
                        () => _showReminderDialog(context, event, isDarkMode),
                    icon: const Icon(Icons.notifications_active_outlined),
                    label: Text(t.eventCalendar.reminderSet),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: eventColor,
                      side: BorderSide(color: eventColor),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                // 設定済みリマインダーの表示
                _buildExistingReminders(
                  context,
                  event,
                  isDarkMode,
                  eventColor,
                  t,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // リマインダー設定ダイアログを表示
  void _showReminderDialog(BuildContext context, Event event, bool isDarkMode) {
    showDialog(
      context: context,
      builder:
          (context) => ReminderDialog(event: event, isDarkMode: isDarkMode),
    );
  }

  // 設定済みリマインダーを表示するウィジェット
  Widget _buildExistingReminders(
    BuildContext context,
    Event event,
    bool isDarkMode,
    Color eventColor,
    Translations t,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        final reminders =
            ref
                .watch(eventReminderProvider)
                .where((r) => r.eventId == event.id)
                .toList();

        if (reminders.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              t.eventCalendar.reminderSetDone,
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            ...reminders.map(
              (reminder) => _buildReminderItem(
                context,
                reminder,
                isDarkMode,
                eventColor,
                ref,
                t,
              ),
            ),
          ],
        );
      },
    );
  }

  // 設定済みリマインダー項目
  Widget _buildReminderItem(
    BuildContext context,
    EventReminder reminder,
    bool isDarkMode,
    Color eventColor,
    WidgetRef ref,
    Translations t,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: eventColor.withValues(alpha: isDarkMode ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: eventColor.withValues(alpha: isDarkMode ? 0.3 : 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications,
            size: 16,
            color: eventColor.withValues(alpha: isDarkMode ? 0.8 : 1.0),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              reminder.reminderTime.label,
              style: GoogleFonts.notoSans(
                fontSize: 13,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            onPressed: () {
              ref
                  .read(eventReminderProvider.notifier)
                  .removeReminder(reminder.eventId, reminder.reminderTime);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.eventCalendar.reminderDeleted),
                  backgroundColor: Colors.red[700],
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestBadge(bool isDarkMode, Translations t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: isDarkMode ? 0.3 : 0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.green.withValues(alpha: isDarkMode ? 0.5 : 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.headset_rounded,
            size: 10,
            color: isDarkMode ? Colors.green[300] : Colors.green[700],
          ),
          const SizedBox(width: 3),
          Text(
            t.eventCalendar.quest,
            style: GoogleFonts.notoSans(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.green[300] : Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
    String title,
    String content,
    IconData icon,
    bool isDarkMode,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: accentColor.withValues(alpha: isDarkMode ? 0.8 : 1.0),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            content,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              height: 1.5,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoWithLink(
    String title,
    String content,
    IconData icon,
    bool isDarkMode,
    Color accentColor,
  ) {
    // URLを検出する正規表現
    final urlRegExp = RegExp(r'https?://[^\s]+', caseSensitive: false);

    final matches = urlRegExp.allMatches(content);
    if (matches.isEmpty) {
      return _buildInfoSection(title, content, icon, isDarkMode, accentColor);
    }

    // URLを含むテキストをリッチテキストに変換
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: accentColor.withValues(alpha: isDarkMode ? 0.8 : 1.0),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: GestureDetector(
            onTap: () {
              final url = matches.first.group(0);
              if (url != null) {
                _launchUrl(url);
              }
            },
            child: Text(
              content,
              style: GoogleFonts.notoSans(
                fontSize: 14,
                height: 1.5,
                color: Colors.blue[400],
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenreChips(
    List<String> genres,
    bool isDarkMode,
    Color baseColor,
    Translations t,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.category_outlined,
              size: 16,
              color: baseColor.withValues(alpha: isDarkMode ? 0.8 : 1.0),
            ),
            const SizedBox(width: 8),
            Text(
              t.eventCalendar.genre,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                genres.map((genre) {
                  final color = _getGenreColor(genre, baseColor, isDarkMode);

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: color.withValues(alpha: isDarkMode ? 0.4 : 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      genre,
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode ? color.withValues(alpha: 0.9) : color,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  // ジャンル名から色を取得するヘルパーメソッド
  Color _getGenreColor(String genre, Color defaultColor, bool isDarkMode) {
    // マッチしない場合はハッシュ値をもとに色を生成
    final hash = genre.hashCode.abs() % 5;
    final fallbackColors = <Color>[
      Colors.blue[isDarkMode ? 300 : 600]!,
      Colors.purple[isDarkMode ? 300 : 600]!,
      Colors.orange[isDarkMode ? 300 : 600]!,
      Colors.teal[isDarkMode ? 300 : 600]!,
      Colors.pink[isDarkMode ? 300 : 600]!,
    ];

    return fallbackColors[hash];
  }

  void _launchUrl(String urlString) async {
    final url = Uri.tryParse(urlString);
    if (url != null) {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }
}
