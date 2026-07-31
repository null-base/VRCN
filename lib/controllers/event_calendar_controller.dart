import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/models/event_calendar_models.dart';
import 'package:vrchat/provider/event_calendar_provider.dart';
import 'package:vrchat/provider/event_filter_provider.dart';

class GroupedEvents {
  const GroupedEvents({required this.byDate, required this.sortedDates});

  final Map<String, List<Event>> byDate;
  final List<String> sortedDates;
}

class EventCalendarController {
  const EventCalendarController(this.ref);

  final Ref ref;

  Future<EventData> refreshEvents() {
    return ref.refresh(eventDataProvider.future);
  }

  List<Event> filterEvents(List<Event> events, EventFilter filter) {
    return events.where((event) => _matchesFilter(event, filter)).toList();
  }

  GroupedEvents groupByDate(List<Event> events) {
    final eventsByDate = <String, List<Event>>{};
    final dateFormat = DateFormat('yyyy-MM-dd');

    for (final event in events) {
      final dateKey = dateFormat.format(event.start);
      eventsByDate.putIfAbsent(dateKey, () => []).add(event);
    }

    for (final events in eventsByDate.values) {
      events.sort((a, b) => a.start.compareTo(b.start));
    }

    return GroupedEvents(
      byDate: eventsByDate,
      sortedDates: eventsByDate.keys.toList()..sort(),
    );
  }

  String? firstUrl(String content) {
    return RegExp(
      r'https?://[^\s]+',
      caseSensitive: false,
    ).firstMatch(content)?.group(0);
  }

  bool _matchesFilter(Event event, EventFilter filter) {
    if (!_matchesDateFilter(event, filter)) return false;
    if (!_matchesTimeFilter(event, filter)) return false;
    if (!_matchesSearchQuery(event, filter.searchQuery)) return false;
    if (!_matchesGenres(event, filter.selectedGenres)) return false;
    return true;
  }

  bool _matchesDateFilter(Event event, EventFilter filter) {
    final eventDate = DateTime(
      event.start.year,
      event.start.month,
      event.start.day,
    );

    if (filter.startDate != null) {
      final filterDate = DateTime(
        filter.startDate!.year,
        filter.startDate!.month,
        filter.startDate!.day,
      );
      if (eventDate.isBefore(filterDate)) return false;
    }

    if (filter.endDate != null) {
      final filterDate = DateTime(
        filter.endDate!.year,
        filter.endDate!.month,
        filter.endDate!.day,
      );
      if (eventDate.isAfter(filterDate)) return false;
    }

    return true;
  }

  bool _matchesTimeFilter(Event event, EventFilter filter) {
    final eventTime = TimeOfDay.fromDateTime(event.start);
    final eventMinutes = eventTime.hour * 60 + eventTime.minute;

    if (filter.startTime != null) {
      final startMinutes =
          filter.startTime!.hour * 60 + filter.startTime!.minute;
      if (eventMinutes < startMinutes) return false;
    }

    if (filter.endTime != null) {
      final endMinutes = filter.endTime!.hour * 60 + filter.endTime!.minute;
      if (eventMinutes > endMinutes) return false;
    }

    return true;
  }

  bool _matchesSearchQuery(Event event, String query) {
    if (query.isEmpty) return true;

    final normalizedQuery = query.toLowerCase();
    return event.title.toLowerCase().contains(normalizedQuery) ||
        event.body.toLowerCase().contains(normalizedQuery) ||
        event.author.toLowerCase().contains(normalizedQuery);
  }

  bool _matchesGenres(Event event, List<String> selectedGenres) {
    if (selectedGenres.isEmpty) return true;
    return event.genres.any(selectedGenres.contains);
  }
}

final eventCalendarControllerProvider = Provider<EventCalendarController>((
  ref,
) {
  return EventCalendarController(ref);
});
