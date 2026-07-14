import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/avatar_provider.dart';
import 'package:vrchat/provider/favorite_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart' hide FavoriteType;

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollControllers = <ScrollController>[
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (final controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 72,
            pinned: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            backgroundColor: backgroundColor,
            surfaceTintColor: backgroundColor,
            elevation: innerBoxIsScrolled ? 1 : 0,
            title: Text(
              t.favorites.title,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: theme.colorScheme.onSurface,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              labelStyle: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelStyle: GoogleFonts.notoSans(),
              indicatorColor: theme.colorScheme.primary,
              indicatorWeight: 2,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: theme.colorScheme.outlineVariant,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.people, size: 20),
                      const SizedBox(width: 6),
                      Text(t.favorites.friendsTab),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.public, size: 20),
                      const SizedBox(width: 6),
                      Text(t.favorites.worldsTab),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.face, size: 20),
                      const SizedBox(width: 6),
                      Text(t.favorites.avatarsTab),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _FavoriteFriendsTab(controller: _scrollControllers[0]),
            _FavoriteWorldsTab(controller: _scrollControllers[1]),
            _FavoriteAvatarsTab(controller: _scrollControllers[2]),
          ],
        ),
      ),
    );
  }
}

// フレンドお気に入りタブ
class _FavoriteFriendsTab extends ConsumerWidget {
  const _FavoriteFriendsTab({required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteFriendsAsync = ref.watch(favoriteFriendsProvider);
    final favoriteGroupsAsync = ref.watch(myFavoriteGroupsProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return favoriteFriendsAsync.when(
      data: (favorites) {
        return favoriteGroupsAsync.when(
          data: (groups) {
            final friendGroups = groups
                .where(
                  (group) => group.type.toString() == FavoriteType.friend.value,
                )
                .toList();

            if (friendGroups.isEmpty) {
              return _buildEmptyState(
                context,
                t.favorites.emptyFolderTitle,
                t.favorites.emptyFolderDescription,
                Icons.folder_outlined,
                isDarkMode,
              );
            }

            final groupedFavorites = _groupFavoritesByFolder(
              favorites: favorites,
              groups: groups,
              type: FavoriteType.friend,
            );

            for (final group in friendGroups) {
              final displayName = group.displayName;
              if (!groupedFavorites.containsKey(displayName)) {
                groupedFavorites[displayName] = [];
              }
            }

            return ListView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              itemCount: groupedFavorites.length,
              itemBuilder: (context, index) {
                final folderName = groupedFavorites.keys.elementAt(index);
                final folderFavorites = groupedFavorites[folderName]!;
                final folderColor = _getFolderColor(folderName, isDarkMode);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StylishFolderHeader(
                      folderName: folderName,
                      color: folderColor,
                      isDarkMode: isDarkMode,
                      itemCount: folderFavorites.length,
                    ),
                    if (folderFavorites.isEmpty)
                      _buildEmptyFolderMessage(
                        context,
                        t.favorites.emptyFriends,
                        Icons.people_outline,
                        isDarkMode,
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: folderFavorites.length,
                        itemBuilder: (context, itemIndex) {
                          final favorite = folderFavorites[itemIndex];
                          final userAsync = ref.watch(
                            userDetailProvider(favorite.favoriteId),
                          );

                          return userAsync.when(
                            data: (user) => _buildEnhancedFriendItem(
                              context,
                              user,
                              favorite.id,
                              ref,
                              isDarkMode,
                            ),
                            loading: () => _buildLoadingItem(isDarkMode),
                            error: (_, _) => _buildErrorItem(
                              favorite.favoriteId,
                              favorite.id,
                              ref,
                              context,
                              isDarkMode,
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
            );
          },
          loading: () => LoadingIndicator(message: t.favorites.loadingFolder),
          error: (_, _) => ErrorContainer(
            message: t.favorites.errorFolder,
            onRetry: () {
              ref.invalidate(myFavoriteGroupsProvider);
              ref.invalidate(favoriteFriendsProvider);
            },
          ),
        );
      },
      loading: () => LoadingIndicator(message: t.favorites.loading),
      error: (error, stack) => ErrorContainer(
        message: t.favorites.error(error: error.toString()),
        onRetry: () => ref.invalidate(favoriteFriendsProvider),
      ),
    );
  }
}

// ワールドお気に入りタブ
class _FavoriteWorldsTab extends ConsumerWidget {
  const _FavoriteWorldsTab({required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteWorldsAsync = ref.watch(favoriteWorldsProvider);
    final favoriteGroupsAsync = ref.watch(myFavoriteGroupsProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return favoriteWorldsAsync.when(
      data: (favorites) {
        if (favorites.isEmpty) {
          return _buildEmptyState(
            context,
            t.favorites.emptyWorldsTabTitle,
            t.favorites.emptyWorldsTabDescription,
            Icons.public,
            isDarkMode,
          );
        }

        return favoriteGroupsAsync.when(
          data: (groups) {
            final groupedFavorites = _groupFavoritesByFolder(
              favorites: favorites,
              groups: groups,
              type: FavoriteType.world,
            );

            return ListView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              itemCount: groupedFavorites.length,
              itemBuilder: (context, index) {
                final folderName = groupedFavorites.keys.elementAt(index);
                final folderFavorites = groupedFavorites[folderName]!;
                final folderColor = _getFolderColor(folderName, isDarkMode);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StylishFolderHeader(
                      folderName: folderName,
                      color: folderColor,
                      isDarkMode: isDarkMode,
                      itemCount: folderFavorites.length,
                    ),
                    if (folderFavorites.isEmpty)
                      _buildEmptyFolderMessage(
                        context,
                        t.favorites.emptyWorlds,
                        Icons.public,
                        isDarkMode,
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: StaggeredGrid.count(
                          crossAxisCount: _favoriteGridCrossAxisCount(context),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: List.generate(folderFavorites.length, (
                            itemIndex,
                          ) {
                            final favorite = folderFavorites[itemIndex];
                            final worldAsync = ref.watch(
                              worldDetailProvider(favorite.favoriteId),
                            );

                            return StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: worldAsync.when(
                                data: (world) => _buildEnhancedWorldItem(
                                  context,
                                  world,
                                  favorite.id,
                                  ref,
                                  isDarkMode,
                                ),
                                loading: () =>
                                    _buildWorldLoadingItem(isDarkMode),
                                error: (_, _) => _buildWorldErrorItem(
                                  favorite.favoriteId,
                                  isDarkMode,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            );
          },
          loading: () => LoadingIndicator(message: t.favorites.loadingFolder),
          error: (_, _) => ErrorContainer(
            message: t.favorites.errorFolder,
            onRetry: () {
              ref.invalidate(myFavoriteGroupsProvider);
              ref.invalidate(favoriteWorldsProvider);
            },
          ),
        );
      },
      loading: () => LoadingIndicator(message: t.favorites.loading),
      error: (error, stack) => ErrorContainer(
        message: t.favorites.error(error: error.toString()),
        onRetry: () => ref.refresh(favoriteWorldsProvider),
      ),
    );
  }
}

// アバターお気に入りタブ
class _FavoriteAvatarsTab extends ConsumerWidget {
  const _FavoriteAvatarsTab({required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAvatarsAsync = ref.watch(favoriteAvatarsProvider);
    final favoriteGroupsAsync = ref.watch(myFavoriteGroupsProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return favoriteAvatarsAsync.when(
      data: (favorites) {
        if (favorites.isEmpty) {
          return _buildEmptyState(
            context,
            t.favorites.emptyAvatarsTabTitle,
            t.favorites.emptyAvatarsTabDescription,
            Icons.face,
            isDarkMode,
          );
        }

        return favoriteGroupsAsync.when(
          data: (groups) {
            final groupedFavorites = _groupFavoritesByFolder(
              favorites: favorites,
              groups: groups,
              type: FavoriteType.avatar,
            );

            return ListView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              itemCount: groupedFavorites.length,
              itemBuilder: (context, index) {
                final folderName = groupedFavorites.keys.elementAt(index);
                final folderFavorites = groupedFavorites[folderName]!;
                final folderColor = _getFolderColor(folderName, isDarkMode);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StylishFolderHeader(
                      folderName: folderName,
                      color: folderColor,
                      isDarkMode: isDarkMode,
                      itemCount: folderFavorites.length,
                    ),
                    if (folderFavorites.isEmpty)
                      _buildEmptyFolderMessage(
                        context,
                        t.favorites.emptyAvatars,
                        Icons.face,
                        isDarkMode,
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: StaggeredGrid.count(
                          crossAxisCount: _favoriteGridCrossAxisCount(context),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: List.generate(folderFavorites.length, (
                            itemIndex,
                          ) {
                            final favorite = folderFavorites[itemIndex];
                            final avatarAsync = ref.watch(
                              avatarDetailProvider(favorite.favoriteId),
                            );

                            return StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: avatarAsync.when(
                                data: (avatar) => _buildEnhancedAvatarItem(
                                  context,
                                  avatar,
                                  favorite.id,
                                  ref,
                                  isDarkMode,
                                ),
                                loading: () =>
                                    _buildAvatarLoadingItem(isDarkMode),
                                error: (_, _) => _buildAvatarErrorItem(
                                  favorite.favoriteId,
                                  isDarkMode,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            );
          },
          loading: () => LoadingIndicator(message: t.favorites.loadingFolder),
          error: (_, _) => ErrorContainer(
            message: t.favorites.errorFolder,
            onRetry: () {
              ref.invalidate(myFavoriteGroupsProvider);
              ref.invalidate(favoriteAvatarsProvider);
            },
          ),
        );
      },
      loading: () => LoadingIndicator(message: t.favorites.loading),
      error: (error, stack) => ErrorContainer(
        message: t.favorites.error(error: error.toString()),
        onRetry: () => ref.refresh(favoriteAvatarsProvider),
      ),
    );
  }
}

// スタイリッシュなフォルダヘッダー
class _StylishFolderHeader extends StatelessWidget {
  const _StylishFolderHeader({
    required this.folderName,
    required this.color,
    required this.isDarkMode,
    required this.itemCount,
  });
  final String folderName;
  final Color color;
  final bool isDarkMode;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDarkMode ? 0.24 : 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.folder_rounded, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              folderName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              t.favorites.itemsCount(count: itemCount.toString()),
              style: GoogleFonts.notoSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int _favoriteGridCrossAxisCount(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width >= 840) return 4;
  if (width >= 560) return 3;
  return 2;
}

// 強化されたフレンドアイテム
Widget _buildEnhancedFriendItem(
  BuildContext context,
  User friend,
  String favoriteId,
  WidgetRef ref,
  bool isDarkMode,
) {
  final vrchatApi = ref.watch(vrchatProvider).value;
  final headers = <String, String>{
    'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN',
  };

  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: isDarkMode ? const Color(0xFF222222) : Colors.white,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => context.push('/user/${friend.id}'),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: friend.userIcon.isNotEmpty
                        ? CachedNetworkImageProvider(
                            friend.userIcon,
                            headers: headers,
                            cacheManager: JsonCacheManager(),
                          )
                        : (friend.currentAvatarThumbnailImageUrl.isNotEmpty
                              ? CachedNetworkImageProvider(
                                  friend.currentAvatarThumbnailImageUrl,
                                  headers: headers,
                                  cacheManager: JsonCacheManager(),
                                )
                              : null),
                    backgroundColor:
                        (friend.userIcon.isEmpty) &&
                            friend.currentAvatarThumbnailImageUrl.isEmpty
                        ? Colors.grey[300]
                        : null,
                    child:
                        (friend.userIcon.isEmpty) &&
                            friend.currentAvatarThumbnailImageUrl.isEmpty
                        ? const Icon(Icons.person, color: Colors.grey)
                        : null,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            // ユーザー情報（レイアウト改善）
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.displayName,
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (friend.statusDescription.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      friend.statusDescription,
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // 追加情報エリア
                  if (friend.location != null &&
                      friend.location != 'offline') ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.blue[400],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'オンライン',
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              color: Colors.blue[400],
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // お気に入り解除ボタン
            SizedBox(
              width: 36,
              height: 36,
              child: Material(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _removeFavorite(
                    context,
                    ref,
                    favoriteId,
                    friend.displayName,
                  ),
                  child: Icon(Icons.favorite, color: Colors.red[400], size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// 強化されたワールドアイテム
Widget _buildEnhancedWorldItem(
  BuildContext context,
  World world,
  String favoriteId,
  WidgetRef ref,
  bool isDarkMode,
) {
  final vrchatApi = ref.watch(vrchatProvider).value;
  final headers = <String, String>{
    'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN',
  };

  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: () => context.push('/world/${world.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ワールド画像
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: world.imageUrl,
                  fit: BoxFit.cover,
                  httpHeaders: headers,
                  cacheManager: JsonCacheManager(),
                  placeholder: (context, url) => Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),

              // グラデーションオーバーレイ
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withAlpha(179)],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // ワールド名（イメージの上に表示）
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Text(
                  world.name,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withAlpha(204),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // お気に入り解除ボタン
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.black.withAlpha(128),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _removeFavorite(
                      context,
                      ref,
                      favoriteId,
                      world.name,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red[400],
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ワールド情報
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    world.authorName,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // ワールド統計
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    const SizedBox(width: 2),
                    Text(
                      _formatNumber(world.favorites ?? 0),
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
  );
}

// 強化されたアバターアイテム
Widget _buildEnhancedAvatarItem(
  BuildContext context,
  Avatar avatar,
  String favoriteId,
  WidgetRef ref,
  bool isDarkMode,
) {
  final vrchatApi = ref.watch(vrchatProvider).value;
  final headers = <String, String>{
    'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN',
  };

  // リリースステータスに応じた色を取得
  Color statusColor = Colors.green;
  switch (avatar.releaseStatus) {
    case ReleaseStatus.private:
      statusColor = Colors.orange;
    case ReleaseStatus.hidden:
      statusColor = Colors.red;
    default:
      statusColor = Colors.green;
  }

  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: () => context.push('/avatar/${avatar.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // アバター画像
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: avatar.imageUrl,
                  fit: BoxFit.cover,
                  httpHeaders: headers,
                  cacheManager: JsonCacheManager(),
                  placeholder: (context, url) => Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),

              // グラデーションオーバーレイ
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withAlpha(179)],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // リリースステータスバッジ
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(204),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _getReleaseStatusText(avatar.releaseStatus),
                    style: GoogleFonts.notoSans(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // お気に入り解除ボタン
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: Colors.black.withAlpha(128),
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _removeFavorite(
                      context,
                      ref,
                      favoriteId,
                      avatar.name,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red[400],
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // アバター情報
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  avatar.name,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        avatar.authorName,
                        style: GoogleFonts.notoSans(
                          fontSize: 12,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 追加情報（バージョンなど）
                    Text(
                      'v${avatar.version}',
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
  );
}

// 空のフォルダメッセージ
Widget _buildEmptyFolderMessage(
  BuildContext context,
  String message,
  IconData icon,
  bool isDarkMode,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    padding: const EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.grey[850]!.withAlpha(128) : Colors.grey[100]!,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

// ローディング中のアイテム表示（フレンド）
Widget _buildLoadingItem(bool isDarkMode) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: isDarkMode ? const Color(0xFF222222) : Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // アバターのプレースホルダー
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            ),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),

          const SizedBox(width: 16),

          // テキストのプレースホルダー
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 80,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// エラー表示のアイテム（フレンド）
Widget _buildErrorItem(
  String favoriteId,
  String favoriteItemId,
  WidgetRef ref,
  BuildContext context,
  bool isDarkMode,
) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: isDarkMode ? const Color(0xFF222222) : Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // エラーアイコン
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode
                  ? Colors.red[900]!.withAlpha(51)
                  : Colors.red[50],
              border: Border.all(
                color: Colors.red[300]!.withAlpha(128),
                width: 2,
              ),
            ),
            child: Icon(Icons.error_outline, color: Colors.red[300], size: 30),
          ),

          const SizedBox(width: 16),

          // エラーテキスト
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.favorites.loadingError,
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[300],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: $favoriteId',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // 削除ボタン
          SizedBox(
            width: 36,
            height: 36,
            child: Material(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _removeFavorite(
                  context,
                  ref,
                  favoriteItemId,
                  'エラーアイテム',
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red[400],
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ワールド用のローディングアイテム
Widget _buildWorldLoadingItem(bool isDarkMode) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 画像プレースホルダー
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),

        // テキストプレースホルダー
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: isDarkMode
                    ? Colors.grey[700]
                    : Colors.grey[400],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: isDarkMode ? Colors.grey[700] : Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// アバター用のローディングアイテム
Widget _buildAvatarLoadingItem(bool isDarkMode) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 画像プレースホルダー
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),

        // テキストプレースホルダー
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isDarkMode ? Colors.grey[700] : Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 70,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: isDarkMode ? Colors.grey[700] : Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ワールド用のエラーアイテム
Widget _buildWorldErrorItem(String favoriteId, bool isDarkMode) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        // エラー画像プレースホルダー
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: isDarkMode ? Colors.red[900]!.withAlpha(51) : Colors.red[50],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red[300], size: 30),
                  const SizedBox(height: 8),
                  Text(
                    t.favorites.loadingError,
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[300],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // エラーテキスト
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'ID: $favoriteId',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// アバター用のエラーアイテム
Widget _buildAvatarErrorItem(String favoriteId, bool isDarkMode) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        // エラー画像プレースホルダー
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: isDarkMode ? Colors.red[900]!.withAlpha(51) : Colors.red[50],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red[300], size: 30),
                  const SizedBox(height: 8),
                  Text(
                    t.favorites.loadingError,
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[300],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // エラーテキスト
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'ID: $favoriteId',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// 数値をフォーマットする関数
String _formatNumber(int number) {
  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)}K';
  }
  return number.toString();
}

// リリースステータスのテキストを取得
String _getReleaseStatusText(ReleaseStatus status) {
  switch (status) {
    case ReleaseStatus.public:
      return t.favorites.public;
    case ReleaseStatus.private:
      return t.favorites.private;
    case ReleaseStatus.hidden:
      return t.favorites.hidden;
    default:
      return t.favorites.unknown;
  }
}

// お気に入りをフォルダ別にグループ化する関数
Map<String, List<Favorite>> _groupFavoritesByFolder({
  required List<Favorite> favorites,
  required List<FavoriteGroup> groups,
  required FavoriteType type,
}) {
  // タイプでフィルタリングしたグループを取得
  final typeGroups = groups
      .where((group) => group.type.toString() == type.value)
      .toList();

  // 結果を格納するMap（キー：表示名、値：お気に入りリスト）
  final result = <String, List<Favorite>>{};

  final groupTagToNameMap = <String, String>{};

  // まずすべてのフォルダを初期化する
  for (final group in typeGroups) {
    // displayNameがある場合はそれを使い、なければnameを使用
    final displayName = group.displayName;

    // 空のリストでフォルダ初期化
    result[displayName] = [];

    // 名前 → 表示名のマッピングも作成（タグとの照合用）
    groupTagToNameMap[group.name] = displayName;
  }

  // 各お気に入りを適切なフォルダに振り分け
  for (final favorite in favorites) {
    for (final tag in favorite.tags) {
      if (groupTagToNameMap.containsKey(tag)) {
        final displayName = groupTagToNameMap[tag]!;
        result[displayName]!.add(favorite);
        break;
      }
    }
  }

  return result;
}

Widget _buildEmptyState(
  BuildContext context,
  String title,
  String subtitle,
  IconData icon,
  bool isDarkMode,
) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 70,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.notoSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

// お気に入り削除処理
Future<void> _removeFavorite(
  BuildContext context,
  WidgetRef ref,
  String favoriteId,
  String name,
) async {
  try {
    await ref.read(favoriteActionProvider.notifier).removeFavorite(favoriteId);
    ref.invalidate(favoriteFriendsProvider);
    ref.invalidate(favoriteWorldsProvider);
    ref.invalidate(favoriteAvatarsProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.favorites.removeSuccess(name: name))),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.favorites.removeFailed(error: e.toString()))),
      );
    }
  }
}

// フォルダ名に基づいて色を取得する関数
Color _getFolderColor(String folderName, bool isDarkMode) {
  // ハッシュコードを使用して一貫した色を生成
  final hash = folderName.hashCode.abs();

  // 定義済みの色リスト
  final colors = <MaterialColor>[
    Colors.blue,
    Colors.purple,
    Colors.teal,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
    Colors.amber,
    Colors.deepOrange,
  ];

  // ハッシュコードを使用して色を選択
  final baseColor = colors[hash % colors.length];

  // ダークモードの場合は明るい色合いを、ライトモードの場合は濃い色合いを返す
  return isDarkMode ? baseColor[400]! : baseColor[600]!;
}
