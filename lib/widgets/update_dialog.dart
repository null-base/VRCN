import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/theme/app_theme.dart';

class UpdateDialog extends StatelessWidget {
  final VersionStatus versionStatus;

  const UpdateDialog({super.key, required this.versionStatus});

  @override
  Widget build(BuildContext context) {
    Translations.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.system_update,
                color: AppTheme.primaryColor,
                size: 24,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // バージョン情報
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '現在のバージョン:',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color:
                                isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[600],
                          ),
                        ),
                        Text(
                          versionStatus.localVersion,
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '最新バージョン:',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color:
                                isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[600],
                          ),
                        ),
                        Text(
                          versionStatus.storeVersion,
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // アップデート内容（もしあれば）
              if (versionStatus.releaseNotes?.isNotEmpty == true) ...[
                Text(
                  'アップデート内容:',
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
                    ),
                  ),
                  child: Text(
                    versionStatus.releaseNotes!,
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
        actions: [
          // アップデートボタン
          ElevatedButton(
            onPressed: () => _launchStore(versionStatus),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.download, size: 18),
                const SizedBox(width: 8),
                Text(
                  'アップデート',
                  style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchStore(VersionStatus versionStatus) async {
    try {
      final uri = Uri.parse(versionStatus.appStoreLink);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('ストア起動エラー: $e');
    }
  }
}
