import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/world_palette_provider.dart';
import 'package:vrchat/utils/app_logger.dart';
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
  final Function(LimitedUser) onTapFriend;
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    // 背景色とアクセントカラーの設定
    final backgroundColor = isDarkMode
        ? Color.lerp(colorScheme.surface, Colors.black, 0.3)
        : Color.lerp(colorScheme.surface, Colors.white, 0.7);

    // 洗練されたアクセントカラーの設定
    final accentColor = isActive && isOffline
        ? HSLColor.fromColor(
            Colors.green,
          ).withSaturation(0.8).withLightness(isDarkMode ? 0.5 : 0.4).toColor()
        : isOffline
        ? HSLColor.fromColor(Colors.grey)
              .withSaturation(0.15)
              .withLightness(isDarkMode ? 0.6 : 0.45)
              .toColor()
        : isPrivate
        ? HSLColor.fromColor(Colors.amber)
              .withSaturation(0.85)
              .withLightness(isDarkMode ? 0.55 : 0.4)
              .toColor()
        : isTraveling
        ? HSLColor.fromColor(Colors.blue)
              .withSaturation(0.7)
              .withLightness(isDarkMode ? 0.55 : 0.45)
              .toColor()
        : HSLColor.fromColor(Colors.deepPurple)
              .withSaturation(0.75)
              .withLightness(isDarkMode ? 0.6 : 0.45)
              .toColor();

    // ヘッダー背景のアニメーショングラデーション
    final headerGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        HSLColor.fromColor(accentColor)
            .withLightness(isDarkMode ? 0.2 : 0.85)
            .withSaturation(0.6)
            .toColor()
            .withValues(alpha: isDarkMode ? 0.25 : 0.15),
        HSLColor.fromColor(accentColor)
            .withLightness(isDarkMode ? 0.15 : 0.9)
            .withSaturation(0.4)
            .toColor()
            .withValues(alpha: isDarkMode ? 0.1 : 0.05),
      ],
      stops: const [0.3, 1.0],
    );

    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    // 使用するワールドIDを決定
    final effectiveInstance = isTraveling ? travelingToLocation : location;

    // ワールド情報を取得
    final instanceAsync =
        (!isPrivate && !isOffline && effectiveInstance != null)
        ? ref.watch(instanceDetailProvider(effectiveInstance))
        : null;

    // ワールド情報の展開
    var displayName = locationName;
    String? thumbnailUrl;
    String? capacityCount;
    String? occupantCount;
    String? effectiveWorldId;
    String? instanceName;
    String? instanceRegion;
    String? instanceType;
    var supportsQuest = false;
    int? questOccupantCount;

    instanceAsync?.whenData((instance) {
      displayName = instance.world.name;
      thumbnailUrl = instance.world.thumbnailImageUrl;
      capacityCount = instance.capacity.toString();
      occupantCount = instance.userCount.toString();
      effectiveWorldId = instance.worldId;
      instanceName = instance.name;
      instanceRegion = instance.region.value;
      instanceType = instance.type.value;
      questOccupantCount = instance.platforms.android;
      supportsQuest =
          questOccupantCount! > 0 ||
          _worldSupportsQuest(instance.world.unityPackages);
    });

    // サムネイル画像のパレットを取得
    final worldPalette = thumbnailUrl != null
        ? ref.watch(worldPaletteProvider(thumbnailUrl!))
        : null;

    // ステータステキスト
    String statusText;
    if (isPrivate) {
      statusText = t.location.isPrivate(number: friends.length);
    } else if (isOffline && isActive) {
      statusText = t.location.isActive(number: friends.length);
    } else if (isOffline) {
      statusText = t.location.isOffline(number: friends.length);
    } else if (isTraveling) {
      statusText = t.location.isTraveling(number: friends.length);
    } else {
      statusText = t.location.isStaying(number: friends.length);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedHeader(
              context,
              headerGradient,
              thumbnailUrl,
              headers,
              isDarkMode,
              accentColor,
              displayName,
              effectiveWorldId,
              statusText,
              worldPalette,
              ref,
              capacityCount,
              occupantCount,
              instanceName,
              instanceRegion,
              instanceType,
              supportsQuest,
              questOccupantCount,
            ),
            _buildFriendList(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader(
    BuildContext context,
    LinearGradient headerGradient,
    String? thumbnailUrl,
    Map<String, String> headers,
    bool isDarkMode,
    Color accentColor,
    String displayName,
    String? effectiveWorldId,
    String statusText,
    AsyncValue<CorePalette?>? worldPalette,
    WidgetRef ref,
    String? capacityCount,
    String? occupantCount,
    String? instanceName,
    String? instanceRegion,
    String? instanceType,
    bool supportsQuest,
    int? questOccupantCount,
  ) {
    // サムネイルからカラーパレットを取得
    final dominantColor =
        worldPalette?.maybeWhen(
          data: (palette) {
            if (palette == null) return accentColor;
            // CorePaletteのprimaryから色を取得
            final color = Color(palette.primary.get(40));
            // 明るさを調整
            final hslColor = HSLColor.fromColor(color);
            return hslColor
                .withLightness(isDarkMode ? 0.55 : 0.45)
                .withSaturation(0.8)
                .toColor();
          },
          orElse: () => accentColor,
        ) ??
        accentColor;

    // サムネイル由来のヘッダーグラデーション
    final thumbnailHeaderGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        HSLColor.fromColor(dominantColor)
            .withLightness(isDarkMode ? 0.2 : 0.85)
            .withSaturation(0.6)
            .toColor()
            .withValues(alpha: isDarkMode ? 0.25 : 0.15),
        HSLColor.fromColor(dominantColor)
            .withLightness(isDarkMode ? 0.15 : 0.9)
            .withSaturation(0.4)
            .toColor()
            .withValues(alpha: isDarkMode ? 0.1 : 0.05),
      ],
      stops: const [0.3, 1.0],
    );

    // 実際に使用するグラデーション
    final effectiveGradient = thumbnailUrl != null
        ? thumbnailHeaderGradient
        : headerGradient;

    return DecoratedBox(
      decoration: BoxDecoration(gradient: effectiveGradient),
      child: Stack(
        children: [
          // サムネイル画像（ヘッダー背景として使用）
          if (thumbnailUrl != null && !isPrivate && !isOffline)
            Positioned.fill(
              child: _buildBackgroundImage(thumbnailUrl, headers),
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // サムネイルまたはアイコン
                _buildLocationImage(
                  thumbnailUrl,
                  headers,
                  isDarkMode,
                  dominantColor,
                ),

                const SizedBox(width: 16),

                // ワールド名と人数
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ワールド名をタップ可能にする
                      _buildWorldNameButton(
                        context,
                        displayName,
                        effectiveWorldId,
                        isDarkMode,
                        dominantColor,
                      ),

                      const SizedBox(height: 4),

                      // 人数情報。長いインスタンス名では折り返して overflow を避ける。
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          if (occupantCount != null && !isPrivate && !isOffline)
                            _buildFriendsAndOccupantsBadge(
                              '$occupantCount/$capacityCount (${friends.length})',
                              dominantColor,
                              isDarkMode,
                              Icons.group,
                            ),
                          if (supportsQuest && !isPrivate && !isOffline)
                            _buildFriendsAndOccupantsBadge(
                              questOccupantCount != null &&
                                      questOccupantCount > 0
                                  ? 'Quest $questOccupantCount'
                                  : 'Quest',
                              Colors.green,
                              isDarkMode,
                              Icons.android,
                            ),
                          if (instanceName != null)
                            _buildFriendsAndOccupantsBadge(
                              '$instanceName ${InstanceHelper.getInstanceTypeText(instanceType)} ${InstanceHelper.regionEmoji(instanceRegion ?? '')}',
                              dominantColor,
                              isDarkMode,
                              Icons.tag_sharp,
                            ),
                          if (occupantCount == null || isPrivate || isOffline)
                            _buildStatusBadge(
                              statusText,
                              dominantColor,
                              isDarkMode,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _worldSupportsQuest(List<UnityPackage>? unityPackages) {
    return unityPackages?.any((package) => package.platform == 'android') ??
        false;
  }

  Widget _buildBackgroundImage(
    String thumbnailUrl,
    Map<String, String> headers,
  ) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstIn,
      child: Opacity(
        opacity: 0.2,
        child: CachedNetworkImage(
          imageUrl: thumbnailUrl,
          httpHeaders: headers,
          cacheManager: JsonCacheManager(),
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(),
          errorWidget: (context, url, error) => const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildWorldNameButton(
    BuildContext context,
    String displayName,
    String? effectiveWorldId,
    bool isDarkMode,
    Color accentColor,
  ) {
    final nameGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        HSLColor.fromColor(
          accentColor,
        ).withLightness(isDarkMode ? 0.8 : 0.65).withSaturation(0.9).toColor(),
        if (isDarkMode)
          Colors.white
        else
          HSLColor.fromColor(
            Colors.black,
          ).withLightness(0.2).toColor().withValues(alpha: 0.9),
      ],
      stops: const [0.3, 1.0],
    );

    return InkWell(
      onTap: () {
        if (effectiveWorldId != null && !isPrivate && !isOffline) {
          context.push('/world/$effectiveWorldId');
        }
      },
      child: Row(
        children: [
          Expanded(
            child: ShaderMask(
              shaderCallback: nameGradient.createShader,
              child: Text(
                displayName,
                style: GoogleFonts.notoSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.2,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (effectiveWorldId != null && !isPrivate && !isOffline)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accentColor.withValues(alpha: 0.2),
                    accentColor.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: accentColor.withValues(alpha: 0.9),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(
    String statusText,
    Color accentColor,
    bool isDarkMode,
  ) {
    final badgeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        accentColor.withValues(alpha: 0.2),
        HSLColor.fromColor(
          accentColor,
        ).withLightness(0.55).toColor().withValues(alpha: 0.1),
      ],
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: badgeGradient,
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        statusText,
        style: GoogleFonts.notoSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: HSLColor.fromColor(
            accentColor,
          ).withLightness(isDarkMode ? 0.7 : 0.3).toColor(),
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  // フレンド数/総人数バッジ
  Widget _buildFriendsAndOccupantsBadge(
    String message,
    Color accentColor,
    bool isDarkMode,
    IconData icon,
  ) {
    final badgeGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        HSLColor.fromColor(
          accentColor,
        ).withLightness(0.7).toColor().withValues(alpha: 0.3),
        HSLColor.fromColor(
          accentColor,
        ).withLightness(0.5).toColor().withValues(alpha: 0.2),
      ],
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: badgeGradient,
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.08),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: HSLColor.fromColor(
              accentColor,
            ).withLightness(isDarkMode ? 0.75 : 0.35).toColor(),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              message,
              style: GoogleFonts.notoSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: HSLColor.fromColor(
                  accentColor,
                ).withLightness(isDarkMode ? 0.75 : 0.35).toColor(),
                letterSpacing: 0.1,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendList(bool isDarkMode) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.black.withValues(alpha: 0.15)
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: friends.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          indent: 68,
          endIndent: 16,
          color: isDarkMode
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.06),
        ),
        itemBuilder: (context, index) {
          final friend = friends[index];
          return FriendListItem(
            friend: friend,
            onTap: () => onTapFriend(friend),
            compact: compact,
          );
        },
      ),
    );
  }

  Widget _buildLocationImage(
    String? thumbnailUrl,
    Map<String, String> headers,
    bool isDarkMode,
    Color accentColor,
  ) {
    // サムネイルURLがあり、プライベートでなく、オフラインでもない場合
    if (thumbnailUrl != null && !isPrivate && !isOffline) {
      return SizedBox(
        height: 60,
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.24),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: isDarkMode ? Colors.black38 : Colors.black26,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.transparent,
                      HSLColor.fromColor(
                        accentColor,
                      ).withLightness(0.6).toColor().withValues(alpha: 0.3),
                    ],
                  ).createShader(rect);
                },
                blendMode: BlendMode.srcATop,
                child: CachedNetworkImage(
                  key: ValueKey(thumbnailUrl),
                  imageUrl: thumbnailUrl,
                  httpHeaders: headers,
                  cacheManager: JsonCacheManager(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      _buildImagePlaceholder(isDarkMode),
                  errorWidget: (context, url, error) {
                    appLogger.d('画像読み込みエラー: $url - $error');
                    return _buildImageError(isDarkMode, accentColor);
                  },
                  cacheKey: '$thumbnailUrl-${DateTime.timestamp().day}',
                  memCacheHeight: 120,
                  memCacheWidth: 120,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            accentColor.withValues(alpha: 0.3),
            accentColor.withValues(alpha: 0.1),
          ],
          stops: const [0.4, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.24),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          (isActive && isOffline) ? Icons.circle : locationIcon,
          color: HSLColor.fromColor(accentColor).withLightness(0.7).toColor(),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(bool isDarkMode) {
    return Container(
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

  Widget _buildImageError(bool isDarkMode, Color accentColor) {
    return Container(
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      child: Center(
        child: Icon(
          locationIcon,
          color: HSLColor.fromColor(
            accentColor,
          ).withLightness(isDarkMode ? 0.6 : 0.4).toColor(),
          size: 20,
        ),
      ),
    );
  }
}
