import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/theme/app_theme.dart';

void main() {
  test('light and dark themes use neutral surfaces and native contrast', () {
    expect(AppTheme.light.scaffoldBackgroundColor, Colors.white);
    expect(AppTheme.light.colorScheme.primary, const Color(0xFF141414));
    expect(AppTheme.light.colorScheme.onPrimary, Colors.white);

    expect(AppTheme.dark.scaffoldBackgroundColor, const Color(0xFF0D0D0D));
    expect(AppTheme.dark.colorScheme.primary, Colors.white);
    expect(AppTheme.dark.colorScheme.onPrimary, const Color(0xFF141414));
  });
}
