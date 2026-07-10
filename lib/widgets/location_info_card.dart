import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/invite_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat/widgets/world_instance_view.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class LocationInfoCard extends ConsumerWidget {
  const LocationInfoCard({
    super.key,
    required this.user,
    required this.isDarkMode,
  });
  final User user;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (user.location == 'private') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.red.shade900.withValues(alpha: 0.2)
              : Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.lock_outline, color: Colors.red[300], size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                t.location.private,
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.red[300],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // 必要なデータソースの取得
    final worldDetailAsync = user.worldId != null
        ? ref.watch(worldDetailProvider(user.worldId!))
        : null;

    final instanceDetailAsync =
        (user.worldId != null && user.instanceId != null)
        ? ref.watch(instanceDetailProvider(user.location.toString()))
        : null;

    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1A3320) : const Color(0xFFE0F5E6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // インスタンス情報とワールド情報の表示を統合
          WorldInstanceView(
            worldDetailAsync: worldDetailAsync,
            instanceDetailAsync: instanceDetailAsync,
            isDarkMode: isDarkMode,
            headers: headers,
          ),

          const SizedBox(height: 20),

          // アクションボタン
          if (user.worldId != null && user.instanceId != null)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        // ローディング表示
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(t.location.inviteSending),
                            duration: const Duration(seconds: 1),
                          ),
                        );

                        // 招待プロバイダーを呼び出し、結果を待つ
                        await ref.read(
                          inviteMyselfProvider(
                            InviteParams(
                              worldId: user.worldId!,
                              instanceId: user.instanceId!,
                            ),
                          ).future,
                        );

                        // 招待が成功した場合
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(t.location.inviteSent),
                              backgroundColor: Colors.green[700],
                              duration: const Duration(seconds: 3),
                              action: SnackBarAction(
                                label: t.common.close,
                                textColor: Colors.white,
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        // エラーが発生した場合
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                t.location.inviteFailed(error: e.toString()),
                              ),
                              backgroundColor: Colors.red[700],
                              duration: const Duration(seconds: 5),
                              action: SnackBarAction(
                                label: t.common.close,
                                textColor: Colors.white,
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.login),
                    label: Text(
                      t.location.inviteButton,
                      style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
