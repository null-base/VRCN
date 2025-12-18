import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/instance_helper.dart';
import 'package:vrchat/widgets/friend_list_item.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

// サムネイルからのパレットプロバイダー
final worldPaletteProvider = FutureProvider.family<CorePalette?, String>((
  ref,
  imageUrl,
) async {
  if (imageUrl.isEmpty) return null;

  try {
    final headers = <String, String>{'User-Agent': 'VRCN'};
    final imageProvider = CachedNetworkImageProvider(
      imageUrl,
      cacheManager: JsonCacheManager(),
      headers: headers,
    );
    final completer = Completer<ui.Image>();
    final stream = imageProvider.resolve(const ImageConfiguration());
    late ImageStreamListener listener;
    listener = ImageStreamListener((info, _) {
      completer.complete(info.image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    final uiImage = await completer.future;

    // 画像のピクセルデータを取得
    final byteData = await uiImage.toByteData(
      format: ui.ImageByteFormat.rawRgba,
    );
    if (byteData == null) return null;
    final pixels = byteData.buffer.asUint32List();

    // quantizeImageで色抽出
    final quantized = await QuantizerCelebi().quantize(pixels, 16);
    final ranked = Score.score(quantized.colorToCount, desired: 1);
    final topColor = ranked.isNotEmpty ? ranked.first : 0xFF888888;

    // CorePaletteを生成
    final palette = CorePalette.of(topColor);
    return palette;
  } catch (e) {
    return null;
  }
});

class FriendLocationGroup extends ConsumerWidget {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    // 背景色とアクセントカラーの設定
    final backgroundColor =
        isDarkMode
            ? Color.lerp(colorScheme.surface, Colors.black, 0.3)
            : Color.lerp(colorScheme.surface, Colors.white, 0.7);

    // 洗練されたアクセントカラーの設定
    final accentColor =
        isActive && isOffline
            ? HSLColor.fromColor(Colors.green)
                .withSaturation(0.8)
                .withLightness(isDarkMode ? 0.5 : 0.4)
                .toColor()
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

    instanceAsync?.whenData((instance) {
      displayName = instance.world.name;
      thumbnailUrl = instance.world.thumbnailImageUrl;
      capacityCount = instance.capacity.toString();
      occupantCount = instance.userCount.toString();
      effectiveWorldId = instance.worldId.toString();
      instanceName = instance.name;
      instanceRegion = instance.region.value;
      instanceType = instance.type.value;
    });

    // サムネイル画像のパレットを取得
    final worldPalette =
        thumbnailUrl != null
            ? ref.watch(worldPaletteProvider(thumbnailUrl!))
            : null;

    // ステータステキスト
    String statusText;
    if (isPrivate) {
      statusText = t.location.isPrivate(number: friends.length).toString();
    } else if (isOffline && isActive) {
      statusText = t.location.isActive(number: friends.length).toString();
    } else if (isOffline) {
      statusText = t.location.isOffline(number: friends.length).toString();
    } else if (isTraveling) {
      statusText = t.location.isTraveling(number: friends.length).toString();
    } else {
      statusText = t.location.isStaying(number: friends.length).toString();
    }

    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 800),
      child: SlideAnimation(
        horizontalOffset: 50,
        child: FadeInAnimation(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuint,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: isDarkMode ? Colors.black26 : Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ヘッダー部分（ワールド情報とサムネイル）
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
                  ),
                  // フレンドのリスト
                  _buildFriendList(isDarkMode),
                ],
              ),
            ),
          ),
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
    final effectiveGradient =
        thumbnailUrl != null ? thumbnailHeaderGradient : headerGradient;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(gradient: effectiveGradient),
      child: Stack(
        children: [
          // サムネイル画像（ヘッダー背景として使用）
          if (thumbnailUrl != null && !isPrivate && !isOffline)
            Positioned.fill(
              child: _buildBackgroundImage(thumbnailUrl, headers),
            ),

          // 装飾パーティクル
          if (!isOffline && !isPrivate)
            Positioned.fill(child: _buildParticleEffects(dominantColor)),

          // ヘッダーコンテンツ
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

                      // 人数情報を横並びに表示
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                // ワールドにいるフレンド数/総人数バッジ
                                if (occupantCount != null &&
                                    !isPrivate &&
                                    !isOffline)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: _buildFriendsAndOccupantsBadge(
                                      '$occupantCount/$capacityCount (${friends.length})',
                                      dominantColor,
                                      isDarkMode,
                                      Icons.group,
                                    ),
                                  ),
                                // インスタンス名
                                if (instanceName != null)
                                  Container(
                                    child: _buildFriendsAndOccupantsBadge(
                                      '$instanceName ${InstanceHelper.getInstanceTypeText(instanceType)} ${InstanceHelper.regionEmoji(instanceRegion ?? '')}',
                                      dominantColor,
                                      isDarkMode,
                                      Icons.tag_sharp,
                                    ),
                                  ),
                                if (occupantCount == null ||
                                    isPrivate ||
                                    isOffline)
                                  _buildStatusBadge(
                                    statusText,
                                    dominantColor,
                                    isDarkMode,
                                  ),
                              ],
                            ),
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
        child: TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 20),
          tween: Tween<double>(begin: 1, end: 1.05),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: CachedNetworkImage(
                imageUrl: thumbnailUrl,
                httpHeaders: headers,
                cacheManager: JsonCacheManager(),
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) => const SizedBox(),
              ),
            );
          },
          onEnd: () {},
        ),
      ),
    );
  }

  Widget _buildParticleEffects(Color accentColor) {
    return IgnorePointer(
      child: Stack(
        children: List.generate(5, (index) {
          final random = math.Random(index);
          final top = random.nextDouble() * 80 - 20;
          final left = random.nextDouble() * 350;
          final size = random.nextDouble() * 5 + 3;
          final opacity = random.nextDouble() * 0.06 + 0.02;

          return Positioned(
            top: top,
            left: left,
            child: TweenAnimationBuilder<double>(
              duration: Duration(seconds: random.nextInt(10) + 20),
              tween: Tween<double>(begin: 0, end: 2 * math.pi),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(math.sin(value) * 8, math.cos(value) * 5),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor.withValues(alpha: opacity),
                    ),
                  ),
                );
              },
              onEnd: () {},
            ),
          );
        }),
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
        isDarkMode
            ? Colors.white
            : HSLColor.fromColor(
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
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1000),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
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
                );
              },
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

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: badgeGradient,
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              statusText,
              style: GoogleFonts.notoSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color:
                    HSLColor.fromColor(
                      accentColor,
                    ).withLightness(isDarkMode ? 0.7 : 0.3).toColor(),
                letterSpacing: 0.1,
              ),
            ),
          ),
        );
      },
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

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: badgeGradient,
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.1),
                  blurRadius: 4,
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
                  color:
                      HSLColor.fromColor(
                        accentColor,
                      ).withLightness(isDarkMode ? 0.75 : 0.35).toColor(),
                ),
                Text(
                  message,
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color:
                        HSLColor.fromColor(
                          accentColor,
                        ).withLightness(isDarkMode ? 0.75 : 0.35).toColor(),
                    letterSpacing: 0.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFriendList(bool isDarkMode) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? Colors.black.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: AnimationLimiter(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: friends.length,
          separatorBuilder:
              (context, index) => Divider(
                height: 1,
                indent: 68,
                endIndent: 16,
                color:
                    isDarkMode
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.black.withValues(alpha: 0.06),
              ),
          itemBuilder: (context, index) {
            final friend = friends[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                horizontalOffset: 50,
                child: FadeInAnimation(
                  child: FriendListItem(
                    friend: friend,
                    onTap: () => onTapFriend(friend),
                    compact: compact,
                  ),
                ),
              ),
            );
          },
        ),
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
                  color: accentColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: isDarkMode ? Colors.black38 : Colors.black26,
                  blurRadius: 6,
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
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(seconds: 10),
                  tween: Tween<double>(begin: 1, end: 1.05),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: CachedNetworkImage(
                        key: ValueKey(thumbnailUrl),
                        imageUrl: thumbnailUrl,
                        httpHeaders: headers,
                        cacheManager: JsonCacheManager(),
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) =>
                                _buildImagePlaceholder(isDarkMode),
                        errorWidget: (context, url, error) {
                          debugPrint('画像読み込みエラー: $url - $error');
                          return _buildImageError(isDarkMode, accentColor);
                        },
                        cacheKey: '$thumbnailUrl-${DateTime.timestamp().day}',
                        memCacheHeight: 120,
                        memCacheWidth: 120,
                      ),
                    );
                  },
                  onEnd: () {},
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      // アイコン表示部分は変更なし
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1500),
        tween: Tween<double>(begin: 0.5, end: 1),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
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
                    color: accentColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 0, end: 2 * math.pi),
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: (isActive && isOffline) ? 0 : value * 0.05,
                    child: Center(
                      child: Icon(
                        (isActive && isOffline) ? Icons.circle : locationIcon,
                        color:
                            HSLColor.fromColor(
                              accentColor,
                            ).withLightness(0.7).toColor(),
                        size: 24,
                      ),
                    ),
                  );
                },
                onEnd: () {},
              ),
            ),
          );
        },
      );
    }
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
          color:
              HSLColor.fromColor(
                accentColor,
              ).withLightness(isDarkMode ? 0.6 : 0.4).toColor(),
          size: 20,
        ),
      ),
    );
  }
}
