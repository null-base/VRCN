import 'package:flutter/material.dart';
import 'package:vrchat/gen/strings.g.dart';

class InstanceHelper {
  static IconData getInstanceTypeIcon(String? type) {
    if (type == null) return Icons.question_mark;

    if (type.contains('public')) {
      return Icons.public;
    } else if (type.contains('hidden') || type.contains('friends+')) {
      return Icons.people;
    } else if (type.contains('friends')) {
      return Icons.person_add;
    } else if (type.contains('invite+')) {
      return Icons.lock_open;
    } else if (type.contains('invite') || type.contains('private')) {
      return Icons.lock;
    } else {
      return Icons.question_mark;
    }
  }

  static Color getInstanceTypeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'public':
        return Colors.green;
      case 'friends':
      case 'hidden':
        return Colors.orange;
      case 'private':
        return Colors.redAccent;
      default:
        return Colors.blue;
    }
  }

  // TODO: グループ判定
  static String getInstanceTypeText(String? type) {
    switch (type?.toLowerCase()) {
      case 'public':
        return t.instance.type.public;
      case 'hidden':
        return t.instance.type.hidden;
      case 'friends':
        return t.instance.type.friends;
      case 'private':
        return t.instance.type.private;
      default:
        return type ?? t.instance.type.unknown;
    }
  }

  static String regionEmoji(String region) {
    switch (region.toLowerCase()) {
      case 'us':
        return '🇺🇸';
      case 'use':
        return '🇺🇸';
      case 'eu':
        return '🇪🇺';
      case 'jp':
        return '🇯🇵';
      default:
        return '';
    }
  }
}
