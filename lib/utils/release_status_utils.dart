import 'package:flutter/material.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class ReleaseStatusUtils {
  const ReleaseStatusUtils._();

  static Color color(ReleaseStatus status) {
    return switch (status) {
      ReleaseStatus.public => Colors.green,
      ReleaseStatus.private => Colors.orange,
      ReleaseStatus.hidden => Colors.red,
      _ => Colors.grey,
    };
  }
}
