import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/provider/event_filter_provider.dart';
import 'package:vrchat/theme/app_theme.dart';

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({
    super.key,
    required this.isDarkMode,
    required this.genres,
  });
  final bool isDarkMode;
  final Map<String, int> genres;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(eventFilterProvider);
    final dateFormat = DateFormat('yyyy/MM/dd');
    final primaryColor = Theme.of(context).colorScheme.primary;

    // ジャンルをイベント数でソート
    final sortedGenres = genres.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // セクションの背景色
    final sectionColor = isDarkMode
        ? const Color(0xFF222222)
        : const Color(0xFFF5F5F5);

    // 境界線の色
    final borderColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.15)
        : Colors.grey.withValues(alpha: 0.25);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.5 : 0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ハンドル
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          // ヘッダー
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: borderColor)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      color: primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'イベントを絞り込む',
                      style: GoogleFonts.notoSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () =>
                      ref.read(eventFilterActionsProvider).clearAll(),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(
                    'クリア',
                    style: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: const Duration(milliseconds: 200)),

          // フィルターオプション
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              physics: const BouncingScrollPhysics(),
              children: [
                // キーワード検索セクション
                _buildFilterSection(
                  icon: Icons.search_rounded,
                  title: 'キーワード検索',
                  child: TextFormField(
                    initialValue: filter.searchQuery,
                    decoration: InputDecoration(
                      hintText: 'イベント名、説明、主催者など',
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Colors.grey[850]
                          : Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: primaryColor, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                    style: GoogleFonts.notoSans(
                      fontSize: 15,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    cursorColor: primaryColor,
                    onChanged: (value) => ref
                        .read(eventFilterActionsProvider)
                        .setSearchQuery(
                          value,
                        ),
                  ),
                  isDarkMode: isDarkMode,
                  backgroundColor: sectionColor,
                  borderColor: borderColor,
                ).animate().fadeIn(
                  duration: const Duration(milliseconds: 300),
                  delay: const Duration(milliseconds: 100),
                ),

                const SizedBox(height: 20),

                // 日付セクション
                _buildFilterSection(
                  icon: Icons.event_rounded,
                  title: '日付で絞り込み',
                  child: Column(
                    children: [
                      // 日付選択ヒント
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.blue.withValues(alpha: 0.1)
                              : Colors.blue.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blue.withValues(
                              alpha: isDarkMode ? 0.3 : 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '特定の日付範囲のイベントを表示できます',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 日付選択
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateSelector(
                              context: context,
                              ref: ref,
                              isStart: true,
                              date: filter.startDate,
                              labelText: '開始日',
                              onSelect: (date) {
                                ref
                                    .read(eventFilterActionsProvider)
                                    .setDateRange(date, filter.endDate);
                              },
                              onClear: () {
                                ref
                                    .read(eventFilterActionsProvider)
                                    .setDateRange(null, filter.endDate);
                              },
                              dateFormat: dateFormat,
                              isDarkMode: isDarkMode,
                              primaryColor: primaryColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: 20,
                            height: 2,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          Expanded(
                            child: _buildDateSelector(
                              context: context,
                              ref: ref,
                              isStart: false,
                              date: filter.endDate,
                              labelText: '終了日',
                              onSelect: (date) {
                                ref
                                    .read(eventFilterActionsProvider)
                                    .setDateRange(filter.startDate, date);
                              },
                              onClear: () {
                                ref
                                    .read(eventFilterActionsProvider)
                                    .setDateRange(filter.startDate, null);
                              },
                              dateFormat: dateFormat,
                              isDarkMode: isDarkMode,
                              primaryColor: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  isDarkMode: isDarkMode,
                  backgroundColor: sectionColor,
                  borderColor: borderColor,
                ).animate().fadeIn(
                  duration: const Duration(milliseconds: 300),
                  delay: const Duration(milliseconds: 200),
                ),

                const SizedBox(height: 20),

                // 時間セクション
                _buildFilterSection(
                  icon: Icons.schedule_rounded,
                  title: '時間帯で絞り込み',
                  child: Column(
                    children: [
                      // 時間選択ヒント
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.green.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green.withValues(
                              alpha: isDarkMode ? 0.3 : 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '特定の時間帯に開催されるイベントを表示できます',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 時間選択
                      Row(
                        children: [
                          Expanded(
                            child: _buildTimeSelector(
                              context: context,
                              ref: ref,
                              isStart: true,
                              time: filter.startTime,
                              labelText: '開始時間',
                              onSelect: (time) {
                                ref
                                    .read(eventFilterActionsProvider)
                                    .setTimeRange(time, filter.endTime);
                              },
                              onClear: () {
                                ref
                                    .read(eventFilterActionsProvider)
                                    .setTimeRange(null, filter.endTime);
                              },
                              isDarkMode: isDarkMode,
                              primaryColor: primaryColor,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: 20,
                            height: 2,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          Expanded(
                            child: _buildTimeSelector(
                              context: context,
                              ref: ref,
                              isStart: false,
                              time: filter.endTime,
                              labelText: '終了時間',
                              onSelect: (time) {
                                ref
                                    .read(eventFilterActionsProvider)
                                    .setTimeRange(filter.startTime, time);
                              },
                              onClear: () {
                                ref
                                    .read(eventFilterActionsProvider)
                                    .setTimeRange(filter.startTime, null);
                              },
                              isDarkMode: isDarkMode,
                              primaryColor: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  isDarkMode: isDarkMode,
                  backgroundColor: sectionColor,
                  borderColor: borderColor,
                ).animate().fadeIn(
                  duration: const Duration(milliseconds: 300),
                  delay: const Duration(milliseconds: 300),
                ),

                const SizedBox(height: 20),

                // ジャンルセクション
                _buildFilterSection(
                  icon: Icons.category_rounded,
                  title: 'ジャンルで絞り込み',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 選択されたジャンル数表示
                      if (filter.selectedGenres.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? primaryColor.withValues(alpha: 0.15)
                                : primaryColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: primaryColor.withValues(
                                alpha: isDarkMode ? 0.3 : 0.2,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline_rounded,
                                size: 16,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${filter.selectedGenres.length}個のジャンルを選択中',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // ジャンルチップ
                      Wrap(
                        spacing: 8,
                        runSpacing: 12,
                        children: sortedGenres.map((entry) {
                          filter.selectedGenres.contains(entry.key);

                          // ジャンルごとの色を決定
                          _getGenreColor(entry.key, isDarkMode);

                          return _buildGenreChip(
                            entry,
                            filter,
                            isDarkMode,
                            primaryColor,
                            ref,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  isDarkMode: isDarkMode,
                  backgroundColor: sectionColor,
                  borderColor: borderColor,
                ).animate().fadeIn(
                  duration: const Duration(milliseconds: 300),
                  delay: const Duration(milliseconds: 400),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          // 適用ボタンセクション
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -4),
                ),
              ],
              border: Border(top: BorderSide(color: borderColor)),
            ),
            child: Column(
              // Rowの代わりにColumnを使用して縦方向にレイアウト
              children: [
                // フィルター状態サマリー
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'フィルター',
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildFilterSummary(filter, isDarkMode),
                    ],
                  ),
                ),

                // 適用ボタン
                _buildApplyButton(context, primaryColor),
              ],
            ),
          ).animate().fadeIn(
            duration: const Duration(milliseconds: 300),
            delay: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  // フィルターセクションのウィジェット
  Widget _buildFilterSection({
    required IconData icon,
    required String title,
    required Widget child,
    required bool isDarkMode,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // セクションヘッダー
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppTheme.primaryColor.withValues(alpha: 0.2)
                        : AppTheme.primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppTheme.primaryColor, size: 18),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // 線
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: borderColor,
          ),

          // コンテンツ
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }

  // 日付選択ウィジェット
  Widget _buildDateSelector({
    required BuildContext context,
    required WidgetRef ref,
    required bool isStart,
    required DateTime? date,
    required String labelText,
    required Function(DateTime) onSelect,
    required VoidCallback onClear,
    required DateFormat dateFormat,
    required bool isDarkMode,
    required Color primaryColor,
  }) {
    final hasValue = date != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final selected = await showDatePicker(
            context: context,
            initialDate: date ?? DateTime.timestamp(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(
                    context,
                  ).colorScheme.copyWith(primary: primaryColor),
                ),
                child: child!,
              );
            },
          );
          if (selected != null) {
            onSelect(selected);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: hasValue
                ? isDarkMode
                      ? primaryColor.withValues(alpha: .15)
                      : primaryColor.withValues(alpha: 0.05)
                : isDarkMode
                ? Colors.grey[850]
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasValue
                  ? primaryColor.withValues(alpha: isDarkMode ? 0.5 : 0.3)
                  : isDarkMode
                  ? Colors.grey[700]!
                  : Colors.grey[300]!,
              width: hasValue ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ラベル
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    labelText,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: hasValue
                          ? primaryColor
                          : isDarkMode
                          ? Colors.grey[400]
                          : Colors.grey[600],
                    ),
                  ),
                  if (hasValue)
                    GestureDetector(
                      onTap: onClear,
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              // 値 - オーバーフロー修正
              Row(
                children: [
                  Icon(
                    isStart
                        ? Icons.calendar_today_rounded
                        : Icons.event_rounded,
                    size: 18,
                    color: hasValue
                        ? primaryColor
                        : isDarkMode
                        ? Colors.grey[400]
                        : Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    // Expandedで囲んでオーバーフロー防止
                    child: Text(
                      hasValue ? dateFormat.format(date) : '選択してください',
                      style: GoogleFonts.notoSans(
                        fontSize: 15,
                        fontWeight: hasValue
                            ? FontWeight.w500
                            : FontWeight.normal,
                        color: hasValue
                            ? isDarkMode
                                  ? Colors.white
                                  : Colors.black87
                            : isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis, // オーバーフロー時に省略
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 時間選択ウィジェット
  Widget _buildTimeSelector({
    required BuildContext context,
    required WidgetRef ref,
    required bool isStart,
    required TimeOfDay? time,
    required String labelText,
    required Function(TimeOfDay) onSelect,
    required VoidCallback onClear,
    required bool isDarkMode,
    required Color primaryColor,
  }) {
    final hasValue = time != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final selected = await showTimePicker(
            context: context,
            initialTime: time ?? TimeOfDay.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(
                    context,
                  ).colorScheme.copyWith(primary: primaryColor),
                ),
                child: child!,
              );
            },
          );
          if (selected != null) {
            onSelect(selected);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: hasValue
                ? isDarkMode
                      ? primaryColor.withValues(alpha: 0.15)
                      : primaryColor.withValues(alpha: 0.05)
                : isDarkMode
                ? Colors.grey[850]
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasValue
                  ? primaryColor.withValues(alpha: isDarkMode ? 0.5 : 0.3)
                  : isDarkMode
                  ? Colors.grey[700]!
                  : Colors.grey[300]!,
              width: hasValue ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    labelText,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: hasValue
                          ? primaryColor
                          : isDarkMode
                          ? Colors.grey[400]
                          : Colors.grey[600],
                    ),
                  ),
                  if (hasValue)
                    GestureDetector(
                      onTap: onClear,
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    isStart
                        ? Icons.access_time_rounded
                        : Icons.schedule_rounded,
                    size: 18,
                    color: hasValue
                        ? primaryColor
                        : isDarkMode
                        ? Colors.grey[400]
                        : Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    // Expandedで囲むことでテキストのオーバーフロー防止
                    child: Text(
                      hasValue
                          ? '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'
                          : '選択してください',
                      style: GoogleFonts.notoSans(
                        fontSize: 15,
                        fontWeight: hasValue
                            ? FontWeight.w500
                            : FontWeight.normal,
                        color: hasValue
                            ? isDarkMode
                                  ? Colors.white
                                  : Colors.black87
                            : isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis, // 長いテキストは省略
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // フィルター適用状態のサマリー
  Widget _buildFilterSummary(EventFilter filter, bool isDarkMode) {
    final hasDateFilter = filter.startDate != null || filter.endDate != null;
    final hasTimeFilter = filter.startTime != null || filter.endTime != null;
    final hasKeywordFilter = filter.searchQuery.isNotEmpty;
    final hasGenreFilter = filter.selectedGenres.isNotEmpty;

    final hasAnyFilter =
        hasDateFilter || hasTimeFilter || hasKeywordFilter || hasGenreFilter;

    if (!hasAnyFilter) {
      return Text(
        'フィルターは設定されていません',
        style: GoogleFonts.notoSans(
          fontSize: 13,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
      );
    }

    final summaries = <Widget>[];

    if (hasKeywordFilter) {
      summaries.add(
        _buildFilterTag('検索: ${filter.searchQuery}', Colors.blue, isDarkMode),
      );
    }

    if (hasDateFilter) {
      final dateFormat = DateFormat('MM/dd');
      var dateText = '';

      if (filter.startDate != null && filter.endDate != null) {
        dateText =
            '${dateFormat.format(filter.startDate!)} 〜 ${dateFormat.format(filter.endDate!)}';
      } else if (filter.startDate != null) {
        dateText = '${dateFormat.format(filter.startDate!)} 以降';
      } else if (filter.endDate != null) {
        dateText = '${dateFormat.format(filter.endDate!)} まで';
      }

      summaries.add(
        _buildFilterTag('日付: $dateText', Colors.orange, isDarkMode),
      );
    }

    if (hasTimeFilter) {
      var timeText = '';

      if (filter.startTime != null && filter.endTime != null) {
        timeText =
            '${_formatTime(filter.startTime!)} 〜 ${_formatTime(filter.endTime!)}';
      } else if (filter.startTime != null) {
        timeText = '${_formatTime(filter.startTime!)} 以降';
      } else if (filter.endTime != null) {
        timeText = '${_formatTime(filter.endTime!)} まで';
      }

      summaries.add(_buildFilterTag('時間: $timeText', Colors.green, isDarkMode));
    }

    if (hasGenreFilter) {
      summaries.add(
        _buildFilterTag(
          'ジャンル: ${filter.selectedGenres.length}個',
          Colors.purple,
          isDarkMode,
        ),
      );
    }

    return Wrap(spacing: 8, runSpacing: 8, children: summaries);
  }

  // フィルタータグウィジェット
  Widget _buildFilterTag(String text, Color color, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDarkMode ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: isDarkMode ? 0.4 : 0.3),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.notoSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color.withValues(alpha: isDarkMode ? 0.9 : 1.0),
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // 時間をフォーマットするヘルパーメソッド
  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  // ジャンル名から色を取得するヘルパーメソッド
  Color _getGenreColor(String genre, bool isDarkMode) {
    final genreColors = <String, MaterialColor>{
      'トーク': Colors.blue,
      'ゲーム': Colors.green,
      'ライブ': Colors.purple,
      'お祭り': Colors.orange,
      'クラブ': Colors.pink,
      'アート': Colors.teal,
      'レース': Colors.red,
      'セミナー': Colors.indigo,
      '初心者歓迎': Colors.cyan,
      'フリー': Colors.amber,
      'お酒': Colors.deepOrange,
      '音楽': Colors.deepPurple,
      'アニメ': Colors.lightBlue,
      'ビジネス': Colors.blueGrey,
      'コスプレ': Colors.lightGreen,
    };

    // ジャンル名に部分一致する色を探す
    for (final entry in genreColors.entries) {
      if (genre.contains(entry.key)) {
        return isDarkMode ? entry.value[300]! : entry.value[600]!;
      }
    }

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

  // ジャンルチップの改善
  Widget _buildGenreChip(
    MapEntry<String, int> entry,
    EventFilter filter,
    bool isDarkMode,
    Color primaryColor,
    WidgetRef ref,
  ) {
    final isSelected = filter.selectedGenres.contains(entry.key);
    final baseColor = _getGenreColor(entry.key, isDarkMode);

    // Heroアニメーションを使用せずに、より軽量な実装に
    return Material(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // アニメーション時間を少し短く
        decoration: BoxDecoration(
          color: isSelected
              ? baseColor.withValues(alpha: isDarkMode ? 0.3 : 0.2)
              : isDarkMode
              ? Colors.grey[800]!
              : Colors.grey[200]!,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? baseColor.withValues(alpha: isDarkMode ? 0.6 : 0.5)
                : isDarkMode
                ? Colors.grey[700]!
                : Colors.grey[300]!,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: baseColor.withValues(
                      alpha: isDarkMode ? 0.2 : 0.1,
                    ),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: InkWell(
          onTap: () => ref
              .read(eventFilterActionsProvider)
              .toggleGenre(
                entry.key,
              ),
          borderRadius: BorderRadius.circular(20),
          splashColor: baseColor.withValues(alpha: 0.1),
          highlightColor: baseColor.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected) ...[
                  Icon(Icons.check_rounded, size: 16, color: baseColor),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  // Flexibleで囲むことでテキストのオーバーフロー防止
                  child: Text(
                    entry.key,
                    style: GoogleFonts.notoSans(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? baseColor
                          : isDarkMode
                          ? Colors.grey[300]
                          : Colors.grey[800],
                    ),
                    overflow: TextOverflow.ellipsis, // 長いテキストは省略
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? baseColor.withValues(alpha: 0.2)
                        : isDarkMode
                        ? Colors.grey[700]
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${entry.value}',
                    style: GoogleFonts.notoSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? baseColor
                          : isDarkMode
                          ? Colors.grey[300]
                          : Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 魅力的な適用ボタン
  Widget _buildApplyButton(BuildContext context, Color primaryColor) {
    return SizedBox(
      // Containerの代わりにSizedBoxを使用
      height: 56,
      // width: double.infinityは使用しない
      child: DecoratedBox(
        // Containerの代わりにDecoratedBoxを使用
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              HSLColor.fromColor(primaryColor)
                  .withLightness(
                    HSLColor.fromColor(primaryColor).lightness * 0.8,
                  )
                  .toColor(),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.white.withValues(alpha: 0.2),
            highlightColor: Colors.white.withValues(alpha: 0.1),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 中央揃えを追加
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '適用する',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
