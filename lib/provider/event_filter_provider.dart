import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// イベントフィルターの状態を管理するクラス
@immutable
class EventFilter {
  const EventFilter({
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.searchQuery = '',
    this.selectedGenres = const [],
  });
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String searchQuery;
  final List<String> selectedGenres;

  EventFilter copyWith({
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? searchQuery,
    List<String>? selectedGenres,
    bool clearStartDate = false,
    bool clearEndDate = false,
    bool clearStartTime = false,
    bool clearEndTime = false,
  }) {
    return EventFilter(
      startDate: clearStartDate ? null : startDate ?? this.startDate,
      endDate: clearEndDate ? null : endDate ?? this.endDate,
      startTime: clearStartTime ? null : startTime ?? this.startTime,
      endTime: clearEndTime ? null : endTime ?? this.endTime,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedGenres: selectedGenres ?? this.selectedGenres,
    );
  }
}

// フィルター状態を管理するプロバイダー
final eventFilterProvider =
    StateNotifierProvider<EventFilterNotifier, EventFilter>(
      (ref) => EventFilterNotifier(),
    );

final eventFilterActionsProvider = Provider<EventFilterActions>(
  EventFilterActions.new,
);

class EventFilterActions {
  const EventFilterActions(this._ref);

  final Ref _ref;

  void clearAll() {
    _ref.read(eventFilterProvider.notifier).clearAll();
  }

  void setDateRange(DateTime? start, DateTime? end) {
    _ref.read(eventFilterProvider.notifier).setDateRange(start, end);
  }

  void setTimeRange(TimeOfDay? start, TimeOfDay? end) {
    _ref.read(eventFilterProvider.notifier).setTimeRange(start, end);
  }

  void setSearchQuery(String query) {
    _ref.read(eventFilterProvider.notifier).setSearchQuery(query);
  }

  void toggleGenre(String genre) {
    _ref.read(eventFilterProvider.notifier).toggleGenre(genre);
  }
}

class EventFilterNotifier extends StateNotifier<EventFilter> {
  EventFilterNotifier() : super(const EventFilter());

  void setDateRange(DateTime? start, DateTime? end) {
    state = state.copyWith(
      startDate: start,
      endDate: end,
      clearStartDate: start == null,
      clearEndDate: end == null,
    );
  }

  void setTimeRange(TimeOfDay? start, TimeOfDay? end) {
    state = state.copyWith(
      startTime: start,
      endTime: end,
      clearStartTime: start == null,
      clearEndTime: end == null,
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleGenre(String genre) {
    final currentGenres = List<String>.from(state.selectedGenres);
    if (currentGenres.contains(genre)) {
      currentGenres.remove(genre);
    } else {
      currentGenres.add(genre);
    }
    state = state.copyWith(selectedGenres: currentGenres);
  }

  void clearAll() {
    state = const EventFilter();
  }
}
