import 'package:flutter/foundation.dart';
import 'package:vrchat/utils/app_logger.dart';

DateTime parseJapanTime(String dateString) {
  try {
    final parsedDateTime = DateTime.parse(dateString);
    if (parsedDateTime.isUtc) {
      return parsedDateTime.add(const Duration(hours: 9));
    }

    return parsedDateTime;
  } catch (error) {
    appLogger.d('日時解析エラー: $error, 入力: $dateString');
    return DateTime.timestamp();
  }
}

@immutable
class EventData {
  const EventData({required this.genres, required this.events});

  factory EventData.fromJson(Map<String, Object?> json) {
    final genresJson = json['genres'];
    final eventsJson = json['events'];

    return EventData(
      genres: genresJson is Map<String, Object?>
          ? genresJson.map(
              (key, value) => MapEntry(key, value is int ? value : 0),
            )
          : const {},
      events: eventsJson is List<Object?>
          ? [
              for (final event in eventsJson)
                if (event is Map<String, Object?>) Event.fromJson(event),
            ]
          : const [],
    );
  }

  final Map<String, int> genres;
  final List<Event> events;
}

@immutable
class Event {
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

  factory Event.fromJson(Map<String, Object?> json) {
    final genresJson = json['genres'];

    return Event(
      id: json['id'] as String? ?? '',
      quest: json['quest'] as bool? ?? false,
      title: json['title'] as String? ?? '',
      start: parseJapanTime(json['start'] as String? ?? ''),
      end: parseJapanTime(json['end'] as String? ?? ''),
      author: json['author'] as String? ?? '',
      body: json['body'] as String? ?? '',
      genres: genresJson is List<Object?>
          ? [
              for (final genre in genresJson)
                if (genre is String) genre,
            ]
          : const [],
      condition: json['condition'] as String? ?? '',
      way: json['way'] as String? ?? '',
      note: json['note'] as String? ?? '',
    );
  }

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
}
