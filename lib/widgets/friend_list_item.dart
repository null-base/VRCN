import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/app_icons.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/status_helpers.dart';
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
    final theme = Theme.of(context);
    final iconUrl = friend.userIcon;
    final avatarUrl = iconUrl != null && iconUrl.isNotEmpty
        ? iconUrl
        : friend.currentAvatarThumbnailImageUrl;
    final userAgent = ref.watch(vrchatProvider).value?.userAgent.toString();
    final imageProvider = avatarUrl != null && avatarUrl.isNotEmpty
        ? CachedNetworkImageProvider(
            avatarUrl,
            headers: {'User-Agent': userAgent ?? 'VRCN'},
            cacheManager: JsonCacheManager(),
          )
        : null;
    final isOffline = friend.location == 'offline';
    final statusColor = isOffline
        ? theme.colorScheme.onSurfaceVariant
        : StatusHelper.getStatusColor(friend.status);

    return Material(
      color: theme.colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 12 : 16,
            vertical: compact ? 8 : 11,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: theme.colorScheme.outlineVariant),
            ),
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: compact ? 18 : 22,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    backgroundImage: imageProvider,
                    child: imageProvider == null
                        ? Icon(
                            AppIcons.person,
                            size: compact ? 18 : 22,
                            color: theme.colorScheme.onSurfaceVariant,
                          )
                        : null,
                  ),
                  Positioned(
                    right: -1,
                    bottom: -1,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.surface,
                          width: 2,
                        ),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    if (friend.statusDescription.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        friend.statusDescription,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (!compact && friend.location == 'private') ...[
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            AppIcons.lock_outline,
                            size: 12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            t.friends.private,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (!compact) ...[
                const SizedBox(width: 8),
                Icon(
                  AppIcons.chevron_right,
                  size: 17,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
