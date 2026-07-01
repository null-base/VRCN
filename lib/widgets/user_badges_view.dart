import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class UserBadgesView extends ConsumerWidget {
  const UserBadgesView({
    super.key,
    required this.user,
    required this.isDarkMode,
  });
  final User user;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badges = user.badges;
    if (badges == null || badges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 最大3つのバッジを横に並べて表示
          ...badges.take(3).map((badge) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildBadgeIcon(badge, ref),
            );
          }),

          // バッジが3つ以上あれば「+N」と表示
          if (badges.length > 3)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                '+${badges.length - 3}',
                style: GoogleFonts.notoSans(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBadgeIcon(Badge badge, WidgetRef ref) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Tooltip(
      message: badge.badgeName,
      child: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: CachedNetworkImage(
          imageUrl: badge.badgeImageUrl,
          fit: BoxFit.cover,
          httpHeaders: headers,
          cacheManager: JsonCacheManager(),
          placeholder: (context, url) => const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          errorWidget: (context, url, error) => Container(
            color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.green,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
