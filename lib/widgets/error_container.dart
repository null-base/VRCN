import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';

class ErrorContainer extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorContainer({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(t.common.retry, style: GoogleFonts.notoSans()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
