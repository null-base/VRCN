import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// アプリケーションのデザインシステムを管理するクラス
class AppTheme {
  // インスタンス化禁止
  AppTheme._();

  static const primaryColor = Color(0xFF597BFF);
  static const secondaryColor = Color(0xFF353535);
  static const accentColor = Color(0xFF6C38FF);
  static const successColor = Color(0xFF22A06B);
  static const dangerColor = Color(0xFFE5484D);
  static const infoColor = Color(0xFF2F80ED);
  static const lightSurface = Color(0xFFF7F8FB);
  static const lightSurfaceRaised = Color(0xFFFFFFFF);
  static const darkSurface = Color(0xFF101114);
  static const darkSurfaceRaised = Color(0xFF181A20);

  /// ベーステキストテーマ
  static final TextTheme _baseTextTheme = GoogleFonts.notoSansTextTheme();

  /// ライトテーマ
  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: lightSurface,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surface: lightSurfaceRaised,
      onSurface: Color(0xFF171A21),
      onSurfaceVariant: Color(0xFF667085),
      outline: Color(0xFFD0D5DD),
      outlineVariant: Color(0xFFE4E7EC),
      surfaceContainerLow: Color(0xFFF9FAFB),
      surfaceContainerHighest: Color(0xFFEFF2F7),
    ),
    textTheme: _baseTextTheme,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: primaryColor.withValues(alpha: 0.04),
    cardTheme: CardThemeData(
      elevation: 0,
      color: lightSurfaceRaised,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE4E7EC)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: const BorderSide(color: Color(0xFFE4E7EC)),
      selectedColor: primaryColor.withValues(alpha: 0.12),
      backgroundColor: lightSurfaceRaised,
      showCheckmark: false,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurfaceRaised,
      foregroundColor: Color(0xFF171A21),
      elevation: 0,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    ),
  );

  /// ダークテーマ
  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: secondaryColor,
          tertiary: accentColor,
          brightness: Brightness.dark,
        ).copyWith(
          surface: darkSurfaceRaised,
          onSurface: Colors.white,
          onSurfaceVariant: const Color(0xFF98A2B3),
          outline: const Color(0xFF3A3F4B),
          outlineVariant: const Color(0xFF252A34),
          surfaceContainerLow: const Color(0xFF151820),
          surfaceContainerHighest: const Color(0xFF222733),
        ),
    textTheme: _baseTextTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    scaffoldBackgroundColor: darkSurface,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: primaryColor.withValues(alpha: 0.08),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF252A34)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: darkSurfaceRaised,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: const BorderSide(color: Color(0xFF252A34)),
      selectedColor: primaryColor.withValues(alpha: 0.2),
      backgroundColor: darkSurfaceRaised,
      showCheckmark: false,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurfaceRaised,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    ),
  );

  /// アプリ全体で使用するアニメーション設定
  static const animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOut;
}
