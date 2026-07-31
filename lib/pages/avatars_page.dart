import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/controllers/avatar_list_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/avatar_provider.dart';
import 'package:vrchat/provider/local_avatar_database_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/release_status_utils.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class AvatarsPage extends ConsumerStatefulWidget {
  const AvatarsPage({super.key});

  @override
  ConsumerState<AvatarsPage> createState() => _AvatarsPageState();
}

class _AvatarsPageState extends ConsumerState<AvatarsPage> {
  final _scrollController = ScrollController();
  var _currentOffset = 0;
  final _pageSize = 100;
  var _isLoadingMore = false;

  // 検索関連の状態変数
  final _searchController = TextEditingController();
  var _isSearching = false;
  var _searchQuery = '';

  AvatarViewMode _viewMode = AvatarViewMode.grid;
  var _showLocalDatabase = false;

  SortOption _sortOption = SortOption.updated;
  final OrderOption _orderOption = OrderOption.descending;
  var _sortByName = false;

  List<Avatar> _avatarList = [];
  var _isInitialized = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // 検索コントローラーのリスナー設定
    _searchController.addListener(_onSearchChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshAvatars();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_showLocalDatabase) return;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMoreAvatars();
    }
  }

  Future<void> _loadMoreAvatars() async {
    if (_isLoadingMore || _showLocalDatabase) return;

    setState(() {
      _isLoadingMore = true;
      _currentOffset += _pageSize;
    });

    try {
      var newAvatars = await ref
          .read(avatarListControllerProvider)
          .fetch(
            AvatarListRequest(params: _getSearchParams(), sortByName: false),
          );

      if (_sortByName) {
        final allAvatars = [..._avatarList, ...newAvatars];
        final sortedAvatars = ref
            .read(avatarListControllerProvider)
            .sortByName(allAvatars);

        newAvatars = sortedAvatars.sublist(_avatarList.length);
      }

      if (mounted) {
        setState(() {
          _avatarList.addAll(newAvatars);
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  AvatarSearchParams _getSearchParams() {
    return AvatarSearchParams(
      n: _pageSize,
      offset: _currentOffset,
      sort: _sortOption,
      order: _orderOption,
      user: 'me',
    );
  }

  // リストを更新
  Future<void> _refreshAvatars() async {
    if (_showLocalDatabase) {
      setState(() {
        _isInitialized = true;
        _loadError = null;
      });
      return;
    }

    setState(() {
      _currentOffset = 0;
      _avatarList = [];
      _isInitialized = false;
      _loadError = null;
    });

    try {
      final avatars = await ref
          .read(avatarListControllerProvider)
          .fetch(
            AvatarListRequest(
              params: _getSearchParams(),
              sortByName: _sortByName,
            ),
          );

      if (mounted) {
        setState(() {
          _avatarList = avatars;
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _loadError = e.toString();
        });
      }
    }
  }

  // 検索クエリが変わったときの処理
  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  List<Avatar> get _displayAvatarList {
    if (!_isSearching) return _avatarList;
    if (_searchQuery.isEmpty) {
      return _avatarList;
    }

    return _avatarList.where((avatar) {
      return avatar.name.toLowerCase().contains(_searchQuery) ||
          avatar.authorName.toLowerCase().contains(_searchQuery) ||
          (avatar.description.toLowerCase().contains(_searchQuery));
    }).toList();
  }

  List<LocalAvatarRecord> _displayLocalAvatarList(
    List<LocalAvatarRecord> avatars,
  ) {
    if (!_isSearching || _searchQuery.isEmpty) return avatars;

    return avatars.where((avatar) {
      return avatar.name.toLowerCase().contains(_searchQuery) ||
          avatar.authorName.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  // 検索モードの切り替え
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      } else {
        // 検索モードに入ったらフォーカスする
        FocusScope.of(context).requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? const Color(0xFF121212)
        : const Color(0xFFF8F8F8);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final localAvatars = ref.watch(localAvatarDatabaseProvider);

    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isDarkMode, t),
      body: SafeArea(
        child: Column(
          children: [
            // 検索バーを追加
            if (_isSearching) _buildSearchBar(isDarkMode, t),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshAvatars,
                child: Builder(
                  builder: (context) {
                    if (!_showLocalDatabase && !_isInitialized) {
                      return LoadingIndicator(message: t.avatars.loading);
                    }

                    if (!_showLocalDatabase) {
                      if (_loadError case final error?
                          when _avatarList.isEmpty) {
                        return ErrorContainer(
                          message: t.avatars.error(error: error),
                          onRetry: _refreshAvatars,
                        );
                      }
                    }

                    if (_showLocalDatabase) {
                      final displayList = _displayLocalAvatarList(
                        localAvatars,
                      );

                      if (displayList.isEmpty) {
                        return _buildLocalEmptyState(isDarkMode);
                      }

                      return _viewMode == AvatarViewMode.grid
                          ? _buildLocalMasonryGrid(
                              isDarkMode,
                              headers,
                              t,
                              displayList,
                            )
                          : _buildLocalListView(
                              isDarkMode,
                              headers,
                              t,
                              displayList,
                            );
                    }

                    final displayList = _displayAvatarList;

                    if (displayList.isEmpty) {
                      return _isSearching
                          ? _buildSearchEmptyState(isDarkMode, t)
                          : _buildEmptyState(isDarkMode, t);
                    }

                    return _viewMode == AvatarViewMode.grid
                        ? _buildMasonryGrid(isDarkMode, headers, t, displayList)
                        : _buildListView(isDarkMode, headers, t, displayList);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 検索バーウィジェット
  Widget _buildSearchBar(bool isDarkMode, Translations t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black12 : Colors.black.withAlpha(13),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: t.avatars.searchHint,
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
            onPressed: _searchController.clear,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  // 検索結果が空の場合の表示
  Widget _buildSearchEmptyState(bool isDarkMode, Translations t) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            t.avatars.searchEmptyTitle,
            style: GoogleFonts.notoSans(
              fontSize: 18,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.avatars.searchEmptyDescription,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDarkMode, Translations t) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: isDarkMode ? Colors.white : Colors.black87,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.black.withAlpha(128)
                  : Colors.white.withAlpha(153),
              border: Border(
                bottom: BorderSide(
                  color: isDarkMode
                      ? Colors.white.withAlpha(25)
                      : Colors.black.withAlpha(13),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Text(
        t.avatars.title,
        style: GoogleFonts.notoSans(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            _showLocalDatabase
                ? Icons.cloud_queue_rounded
                : Icons.storage_rounded,
            color: AppTheme.primaryColor,
          ),
          onPressed: () {
            setState(() {
              _showLocalDatabase = !_showLocalDatabase;
              _isInitialized = true;
              _isLoadingMore = false;
            });
          },
          tooltip: _showLocalDatabase ? 'VRChat avatars' : 'Local avatar DB',
        ),
        // 検索アイコンを追加
        IconButton(
          icon: Icon(
            _isSearching ? Icons.search_off : Icons.search,
            color: AppTheme.primaryColor,
          ),
          onPressed: _toggleSearch,
          tooltip: t.avatars.searchTooltip,
        ),
        IconButton(
          icon: Icon(
            _viewMode == AvatarViewMode.grid
                ? Icons.view_list_rounded
                : Icons.grid_view_rounded,
            color: AppTheme.primaryColor,
          ),
          onPressed: () {
            setState(() {
              _viewMode = _viewMode == AvatarViewMode.grid
                  ? AvatarViewMode.list
                  : AvatarViewMode.grid;
            });
          },
          tooltip: t.avatars.viewModeTooltip,
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.sort, color: AppTheme.primaryColor),
          tooltip: t.avatars.sortTooltip,
          onSelected: (value) {
            setState(() {
              switch (value) {
                case 'updated':
                  _sortOption = SortOption.updated;
                  _sortByName = false;
                case 'name':
                  _sortOption = SortOption.updated;
                  _sortByName = true;
              }
            });
            _refreshAvatars();
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'updated',
              child: Text(t.avatars.sortUpdated),
            ),
            PopupMenuItem(value: 'name', child: Text(t.avatars.sortName)),
          ],
        ),
      ],
    );
  }

  Widget _buildLocalEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.storage_rounded,
            size: 80,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            'No local avatars',
            style: GoogleFonts.notoSans(
              fontSize: 18,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Viewed and searched avatars will appear here.',
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLocalMasonryGrid(
    bool isDarkMode,
    Map<String, String> headers,
    Translations t,
    List<LocalAvatarRecord> avatars,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MasonryGridView.count(
        controller: _scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          final avatar = avatars[index];
          final heightFactor = 0.9 + ((avatar.id.hashCode % 30) / 100);

          return _buildLocalAvatarCard(
            avatar: avatar,
            isDarkMode: isDarkMode,
            headers: headers,
            heightFactor: heightFactor,
            t: t,
          );
        },
      ),
    );
  }

  Widget _buildLocalListView(
    bool isDarkMode,
    Map<String, String> headers,
    Translations t,
    List<LocalAvatarRecord> avatars,
  ) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: avatars.length,
      itemBuilder: (context, index) {
        return _buildLocalListItem(avatars[index], isDarkMode, headers, t);
      },
    );
  }

  // グリッドビュー
  Widget _buildMasonryGrid(
    bool isDarkMode,
    Map<String, String> headers,
    Translations t, [
    List<Avatar>? displayList,
  ]) {
    final avatars = displayList ?? _avatarList;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MasonryGridView.count(
        controller: _scrollController,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: avatars.length + (_isLoadingMore && !_isSearching ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == avatars.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final avatar = avatars[index];

          final heightFactor = 0.9 + ((avatar.id.hashCode % 30) / 100);

          return _buildAvatarCard(
            avatar: avatar,
            isDarkMode: isDarkMode,
            headers: headers,
            heightFactor: heightFactor,
            t: t,
          );
        },
      ),
    );
  }

  // リストビュー
  Widget _buildListView(
    bool isDarkMode,
    Map<String, String> headers,
    Translations t, [
    List<Avatar>? displayList,
  ]) {
    final avatars = displayList ?? _avatarList;

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: avatars.length + (_isLoadingMore && !_isSearching ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == avatars.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final avatar = avatars[index];

        return _buildListItem(avatar, isDarkMode, headers, t);
      },
    );
  }

  Widget _buildAvatarCard({
    required Avatar avatar,
    required bool isDarkMode,
    required Map<String, String> headers,
    required double heightFactor,
    required Translations t,
  }) {
    return GestureDetector(
      onTap: () => context.push('/avatar/${avatar.id}'),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black26 : Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ColoredBox(
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.0 * heightFactor,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: avatar.thumbnailImageUrl,
                        httpHeaders: headers,
                        cacheManager: JsonCacheManager(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: isDarkMode
                              ? Colors.grey[850]
                              : Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: isDarkMode
                              ? Colors.grey[850]
                              : Colors.grey[200],
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(179),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (avatar.tags.contains('currentAvatar'))
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 4),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  t.avatars.current,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ReleaseStatusUtils.color(
                              avatar.releaseStatus,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 4),
                            ],
                          ),
                          child: Text(
                            _getReleaseStatusText(avatar.releaseStatus, t),
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              avatar.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    avatar.authorName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.notoSans(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      shadows: [
                                        const Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
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
          ),
        ),
      ),
    );
  }

  Widget _buildLocalAvatarCard({
    required LocalAvatarRecord avatar,
    required bool isDarkMode,
    required Map<String, String> headers,
    required double heightFactor,
    required Translations t,
  }) {
    return GestureDetector(
      onTap: () => context.push('/avatar/${avatar.id}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ColoredBox(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          child: AspectRatio(
            aspectRatio: 1.0 * heightFactor,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: avatar.thumbnailImageUrl,
                  httpHeaders: headers,
                  cacheManager: JsonCacheManager(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(179),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: _buildReleaseBadge(avatar.releaseStatus, t),
                ),
                Positioned(
                  bottom: 8,
                  left: 10,
                  right: 10,
                  child: _buildLocalAvatarText(avatar),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocalAvatarText(LocalAvatarRecord avatar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          avatar.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            shadows: const [Shadow(offset: Offset(0, 1), blurRadius: 3)],
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            const Icon(Icons.person, color: Colors.white70, size: 12),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                avatar.authorName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.notoSans(
                  color: Colors.white70,
                  fontSize: 12,
                  shadows: const [Shadow(offset: Offset(0, 1), blurRadius: 2)],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReleaseBadge(ReleaseStatus status, Translations t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: ReleaseStatusUtils.color(status),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Text(
        _getReleaseStatusText(status, t),
        style: GoogleFonts.notoSans(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListItem(
    Avatar avatar,
    bool isDarkMode,
    Map<String, String> headers,
    Translations t,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: isDarkMode ? Colors.black : Colors.black26,
      child: InkWell(
        onTap: () => context.push('/avatar/${avatar.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: 'avatar-list-${avatar.id}',
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(51),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: avatar.thumbnailImageUrl,
                          httpHeaders: headers,
                          cacheManager: JsonCacheManager(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: isDarkMode
                                ? Colors.grey[850]
                                : Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: isDarkMode
                                ? Colors.grey[850]
                                : Colors.grey[200],
                            child: const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                      if (avatar.tags.contains('currentAvatar'))
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      avatar.name,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 14,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            avatar.authorName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ReleaseStatusUtils.color(
                              avatar.releaseStatus,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getReleaseStatusText(avatar.releaseStatus, t),
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocalListItem(
    LocalAvatarRecord avatar,
    bool isDarkMode,
    Map<String, String> headers,
    Translations t,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: isDarkMode ? Colors.black : Colors.black26,
      child: InkWell(
        onTap: () => context.push('/avatar/${avatar.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: avatar.thumbnailImageUrl,
                  httpHeaders: headers,
                  cacheManager: JsonCacheManager(),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      avatar.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      avatar.authorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildReleaseBadge(avatar.releaseStatus, t),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getReleaseStatusText(ReleaseStatus status, Translations t) {
    switch (status) {
      case ReleaseStatus.public:
        return t.avatars.public;
      case ReleaseStatus.private:
        return t.avatars.private;
      case ReleaseStatus.hidden:
        return t.avatars.hidden;
      default:
        return status.toString();
    }
  }

  // アバターリストが空の場合の表示
  Widget _buildEmptyState(bool isDarkMode, Translations t) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            size: 80,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            t.avatars.emptyTitle,
            style: GoogleFonts.notoSans(
              fontSize: 18,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.avatars.emptyDescription,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _refreshAvatars,
            icon: const Icon(Icons.refresh),
            label: Text(t.avatars.refresh),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum AvatarViewMode { grid, list }
