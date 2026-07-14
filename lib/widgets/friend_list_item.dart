import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/status_helpers.dart';
import 'package:vrchat/utils/user_type_helpers.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class FriendListItem extends ConsumerWidget {
  const FriendListItem({
    super.key,
    required this.friend,
    required this.onTap,
    this.compact = false,
  });
  final LimitedUser friend;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    final statusColor = StatusHelper.getStatusColor(friend.status);
    final userTypeColor = UserTypeHelper.getUserTypeColor(friend.tags);

    // friend.idを使ってUserの詳細情報を取得（オンラインの場合のみ、かつコンパクトモードでない場合）
    final userDetailAsync =
        (!compact &&
            friend.location != 'offline' &&
            friend.location != 'private')
        ? ref.watch(userDetailProvider(friend.id))
        : null;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 2 : 4,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            statusColor.withAlpha(13),
            if (isDarkMode) Colors.black12 else Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(compact ? 4 : 8),
            blurRadius: compact ? 3 : 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: statusColor.withAlpha(77)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 8 : 12,
              vertical: compact ? 6 : 8,
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: statusColor.withAlpha(179),
                          width: compact ? 1.0 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: statusColor.withAlpha(51),
                            blurRadius: compact ? 3 : 6,
                            spreadRadius: compact ? 0 : 1,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: compact ? 16 : 22,
                        backgroundImage: friend.userIcon!.isNotEmpty
                            ? CachedNetworkImageProvider(
                                friend.userIcon!,
                                headers: headers,
                                cacheManager: JsonCacheManager(),
                              )
                            : (friend.currentAvatarThumbnailImageUrl != null
                                  ? CachedNetworkImageProvider(
                                      friend.currentAvatarThumbnailImageUrl!,
                                      headers: headers,
                                      cacheManager: JsonCacheManager(),
                                    )
                                  : null),
                        backgroundColor:
                            friend.userIcon!.isEmpty &&
                                friend.currentAvatarThumbnailImageUrl == null
                            ? Colors.grey[300]
                            : null,
                        child:
                            friend.userIcon!.isEmpty &&
                                friend.currentAvatarThumbnailImageUrl == null
                            ? Icon(
                                Icons.person,
                                size: compact ? 16 : 20,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: compact ? 8 : 12,
                        height: compact ? 8 : 12,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDarkMode ? Colors.black : Colors.white,
                            width: compact ? 1.0 : 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(26),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        friend.displayName,
                        style: GoogleFonts.notoSans(
                          fontSize: compact ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.1,
                          color: userTypeColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (friend.statusDescription.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          friend.statusDescription,
                          style: GoogleFonts.notoSans(
                            fontSize: compact ? 11 : 12,
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      // コンパクトモードでない場合のみロケーション情報を表示
                      if (!compact &&
                          friend.location != 'offline' &&
                          friend.location != null) ...[
                        const SizedBox(height: 2),

                        if (friend.location == 'private') ...[
                          Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                size: 12,
                                color: isDarkMode
                                    ? Colors.red[300]
                                    : Colors.red[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                t.friends.private,
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: isDarkMode
                                      ? Colors.red[300]
                                      : Colors.red[700],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ] else if (userDetailAsync != null)
                          ...[],
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
