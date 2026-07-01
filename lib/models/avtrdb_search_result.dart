import 'package:flutter/foundation.dart';

@immutable
class AvtrDbSearchResult {
  const AvtrDbSearchResult({
    required this.id,
    required this.name,
    required this.authorName,
    required this.imageUrl,
  });

  factory AvtrDbSearchResult.fromJson(Map<String, dynamic> json) {
    return AvtrDbSearchResult(
      id: json['id'] as String,
      name: json['name'] as String,
      authorName: json['authorName'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
  final String id;
  final String name;
  final String authorName;
  final String imageUrl;
}
