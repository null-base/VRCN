import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';

// 検索前の空の状態
Widget buildEmptySearchState(
  String type,
  IconData icon,
  bool isDarkMode, {
  String? description,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 48,
          color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          type,
          style: GoogleFonts.notoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    ),
  );
}

// エラー状態のウィジェット
Widget buildErrorState(String errorMessage, bool isDarkMode) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
        const SizedBox(height: 16),
        Text(
          t.common.errorNomessage,
          style: GoogleFonts.notoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.red[300] : Colors.red[700],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}

// 検索結果がない状態のウィジェット
Widget buildNoResultsState(String query, bool isDarkMode) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off,
          size: 48,
          color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          t.search.tabs.worldSearch.noResultsWithQuery(query: query),
          style: GoogleFonts.notoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
      ],
    ),
  );
}
