import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackBarUtils {
  SnackBarUtils._();

  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message,
      icon: Icons.check_circle,
      backgroundColor: Colors.green.shade600,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 5),
  }) {
    _show(
      context,
      message,
      icon: Icons.error,
      backgroundColor: Colors.red.shade600,
      duration: duration,
      expandText: true,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required IconData icon,
    required Color backgroundColor,
    Duration? duration,
    bool expandText = false,
  }) {
    if (!context.mounted) return;

    final text = Text(message, style: GoogleFonts.notoSans());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            if (expandText) Expanded(child: text) else text,
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: duration ?? const Duration(milliseconds: 4000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
