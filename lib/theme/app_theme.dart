import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Legacy call sites still use this color directly. Keep it neutral and
  // legible in both brightness modes until those screens use ColorScheme.
  static const primaryColor = Color(0xFF6B6B6B);
  static const secondaryColor = Color(0xFF343434);
  static const accentColor = Color(0xFF818181);
  static const successColor = Color(0xFF21845A);
  static const dangerColor = Color(0xFFC83F45);
  static const infoColor = Color(0xFF3D73A8);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceRaised = Color(0xFFFFFFFF);
  static const darkSurface = Color(0xFF0D0D0D);
  static const darkSurfaceRaised = Color(0xFF191919);

  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final foreground = isDark ? Colors.white : const Color(0xFF141414);
    final background = isDark ? darkSurface : lightSurface;
    final surface = isDark ? darkSurfaceRaised : lightSurfaceRaised;
    final border = isDark ? const Color(0xFF343434) : const Color(0xFFE5E5E5);
    final secondary = isDark
        ? const Color(0xFFABABAB)
        : const Color(0xFF626262);
    final subtleSurface = isDark
        ? const Color(0xFF232323)
        : const Color(0xFFF5F5F5);
    final scheme = isDark
        ? ColorScheme.dark(
            primary: Colors.white,
            onPrimary: const Color(0xFF141414),
            secondary: secondary,
            surface: surface,
            onSurface: foreground,
            onSurfaceVariant: secondary,
            outline: border,
            outlineVariant: border,
            surfaceContainerLow: background,
            surfaceContainerHighest: subtleSurface,
          )
        : ColorScheme.light(
            primary: foreground,
            onPrimary: Colors.white,
            secondary: secondary,
            surface: surface,
            onSurface: foreground,
            onSurfaceVariant: secondary,
            outline: border,
            outlineVariant: border,
            surfaceContainerLow: subtleSurface,
            surfaceContainerHighest: const Color(0xFFEBEBEB),
          );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: scheme,
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: scheme.primary,
        scaffoldBackgroundColor: background,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: border),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: background,
        indicatorColor: subtleSurface,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: foreground,
        unselectedLabelColor: secondary,
        indicatorColor: foreground,
        dividerColor: border,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: foreground),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: subtleSurface,
        side: BorderSide(color: border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        showCheckmark: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: subtleSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
    );
  }

  static const animationDuration = Duration(milliseconds: 220);
  static const Curve animationCurve = Curves.easeOutCubic;
}
