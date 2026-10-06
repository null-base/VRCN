import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/app_icons.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/instance_helper.dart';
import 'package:vrchat/widgets/friend_list_item.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class FriendLocationGroup extends ConsumerWidget {
  const FriendLocationGroup({
    super.key,
    required this.locationName,
    this.location,
    required this.friends,
    required this.onTapFriend,
    required this.locationIcon,
    required this.iconColor,
    this.isOffline = false,
    this.isPrivate = false,
    this.isTraveling = false,
    this.travelingToLocation,
    this.compact = false,
    this.isActive = false,
  });

  final String locationName;
  final String? location;
  final List<LimitedUser> friends;
  final void Function(LimitedUser) onTapFriend;
  final IconData locationIcon;
  final Color iconColor;
  final bool isOffline;
  final bool isPrivate;
  final bool isTraveling;
  final String? travelingToLocation;
  final bool compact;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final effectiveInstance = isTraveling ? travelingToLocation : location;
    final instanceAsync =
        !isPrivate && !isOffline && isInstanceLocation(effectiveInstance)
        ? ref.watch(instanceDetailProvider(effectiveInstance!))
        : null;
    final instance = instanceAsync?.value;
    final thumbnailUrl = instance?.world.thumbnailImageUrl;
    final worldId = instance?.worldId;
    final api = ref.watch(vrchatProvider).value;
    final headers = <String, String>{
      'User-Agent': api?.userAgent.toString() ?? 'VRCN',
    };

    final statusText = isPrivate
        ? t.location.isPrivate(number: friends.length)
        : isOffline && isActive
        ? t.location.isActive(number: friends.length)
        : isOffline
        ? t.location.isOffline(number: friends.length)
        : isTraveling
        ? t.location.isTraveling(number: friends.length)
        : t.location.isStaying(number: friends.length);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
            child: Row(
              children: [
                _locationImage(context, thumbnailUrl, headers),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: worldId != null && !isPrivate && !isOffline
                            ? () => context.push('/world/$worldId')
                            : null,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                instance?.world.name ?? locationName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                            if (worldId != null && !isPrivate && !isOffline)
                              Icon(
                                AppIcons.chevron_right_rounded,
                                size: 18,
                                color: scheme.onSurfaceVariant,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        instance == null
                            ? statusText
                            : '${instance.userCount}/${instance.capacity} (${friends.length})',
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      if (instance?.name.isNotEmpty == true)
                        Text(
                          '${instance!.name} ${InstanceHelper.getInstanceTypeText(instance.type.value)} ${InstanceHelper.regionEmoji(instance.region.value)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            itemBuilder: (context, index) => FriendListItem(
              friend: friends[index],
              onTap: () => onTapFriend(friends[index]),
              compact: compact,
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationImage(
    BuildContext context,
    String? thumbnailUrl,
    Map<String, String> headers,
  ) {
    if (thumbnailUrl != null &&
        thumbnailUrl.isNotEmpty &&
        !isPrivate &&
        !isOffline) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: thumbnailUrl,
          httpHeaders: headers,
          cacheManager: JsonCacheManager(),
          width: 64,
          height: 52,
          fit: BoxFit.cover,
          memCacheWidth: 128,
          memCacheHeight: 104,
          placeholder: (context, url) => _fallbackImage(context),
          errorWidget: (context, url, error) => _fallbackImage(context),
        ),
      );
    }
    return _fallbackImage(context);
  }

  Widget _fallbackImage(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 64,
      height: 52,
      child: ColoredBox(
        color: scheme.surfaceContainerLow,
        child: Icon(locationIcon, size: 22, color: scheme.onSurfaceVariant),
      ),
    );
  }
}
