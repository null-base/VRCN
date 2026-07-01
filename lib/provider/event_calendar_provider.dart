import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vrchat/config/app_config.dart';
import 'package:vrchat/models/event_calendar_models.dart';
import 'package:vrchat/provider/vrchat_extended_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart' as vrc;

final eventDataProvider = FutureProvider<EventData>((ref) async {
  final response = await http.get(Uri.parse(AppConfig.eventCalender));
  if (response.statusCode != 200) {
    throw Exception('イベントデータの取得に失敗しました');
  }

  final decoded = jsonDecode(response.body);
  if (decoded is! Map<String, Object?>) {
    throw const FormatException('イベントデータの形式が不正です');
  }

  return EventData.fromJson(decoded);
});

final vrchatCalendarEventsProvider = FutureProvider<List<vrc.CalendarEvent>>((
  ref,
) async {
  final api = await ref.watch(vrchatCalendarApiProvider.future);
  final date = DateTime.now();

  final responses = await Future.wait([
    api.getFollowedCalendarEvents(date: date, n: 30),
    api.getFeaturedCalendarEvents(date: date, n: 30),
    api.discoverCalendarEvents(n: 30),
  ]);

  final events = <vrc.CalendarEvent>[];
  for (final response in responses) {
    final data = response.data;
    if (data is vrc.PaginatedCalendarEventList) {
      events.addAll(data.results ?? const <vrc.CalendarEvent>[]);
    } else if (data is vrc.CalendarEventDiscovery) {
      events.addAll(data.results);
    }
  }

  final seenIds = <String>{};
  final uniqueEvents = <vrc.CalendarEvent>[];
  for (final event in events) {
    if (seenIds.add(event.id)) {
      uniqueEvents.add(event);
    }
  }

  return uniqueEvents..sort((a, b) => a.startsAt.compareTo(b.startsAt));
});
