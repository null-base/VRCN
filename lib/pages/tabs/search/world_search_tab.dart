import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/search_providers.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/search_utils.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/search_widgets.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class WorldSearchTab extends ConsumerStatefulWidget {
  const WorldSearchTab({super.key});

  @override
  ConsumerState<WorldSearchTab> createState() => _WorldSearchTabState();
}

class _WorldSearchTabState extends ConsumerState<WorldSearchTab>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  var _isGridView = false; // グリッドビューとリストビューの切り替えフラグ

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _loadMoreResults();
    }
  }

  void _loadMoreResults() {
    advanceSearchOffset(ref, worldSearchOffsetProvider);
  }

  void _toggleViewMode() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final query = ref.watch(searchQueryProvider);
    final offset = ref.watch(worldSearchOffsetProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isMobileSize = size.width < 600;

    // レスポンシブデザイン：モバイルでは常にリストビュー
    final effectiveIsGridView = !isMobileSize && _isGridView;

    // 累積された結果を取得
    final cachedResults = ref.watch(worldSearchResultsProvider);

    final searchProvider = worldSearchProvider(
      WorldSearchParams(search: query, offset: offset),
    );
    final searchState = ref.watch(searchProvider);

    if (query.isEmpty) {
      return _buildEmptySearchPrompt(isDarkMode);
    }

    // searchStateが変化したときの処理
    ref.listen<AsyncValue<List<LimitedWorld>>>(
      searchProvider,
      (previous, current) {
        handlePagedSearchResults(
          ref: ref,
          state: current,
          offset: offset,
          cachedResults: cachedResults,
          resultsProvider: worldSearchResultsProvider,
          idOf: (world) => world.id,
        );
      },
    );

    if (searchState.isLoading && offset == 0) {
      return Center(
        child: LoadingIndicator(message: t.search.tabs.worldSearch.searching),
      );
    }

    // エラー状態の処理
    if (searchState.hasError && cachedResults.isEmpty) {
      return buildErrorState(
        t.search.tabs.worldSearch.error(error: searchState.error.toString()),
        isDarkMode,
      );
    }

    // 空の検索結果
    if (cachedResults.isEmpty && !searchState.isLoading) {
      return _buildNoResultsView(query, isDarkMode);
    }

    // ビューモード切替ボタン
    final viewToggleButton = !isMobileSize
        ? Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton.small(
              onPressed: _toggleViewMode,
              tooltip: effectiveIsGridView
                  ? t.search.tabs.worldSearch.listView
                  : t.search.tabs.worldSearch.gridView,
              elevation: 2,
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
              foregroundColor: isDarkMode ? Colors.white : Colors.grey[800],
              child: Icon(
                effectiveIsGridView ? Icons.view_list : Icons.grid_view,
              ),
            ),
          )
        : const SizedBox.shrink();

    // キャッシュされた結果を表示
    return Stack(
      children: [
        if (effectiveIsGridView)
          _buildWorldGrid(cachedResults, searchState.isLoading, isDarkMode)
        else
          _buildWorldList(cachedResults, searchState.isLoading, isDarkMode),
        viewToggleButton,
      ],
    );
  }

  Widget _buildEmptySearchPrompt(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.travel_explore,
            size: 100,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            t.search.tabs.worldSearch.emptyTitle,
            style: GoogleFonts.notoSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.search.tabs.worldSearch.emptyDescription,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsView(String query, bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            t.search.tabs.worldSearch.noResultsWithQuery(query: query),
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.search.tabs.worldSearch.noResultsHint,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorldList(
    List<LimitedWorld> worlds,
    bool isLoading,
    bool isDarkMode,
  ) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 72),
      itemCount: worlds.length + 1,
      itemBuilder: (context, index) {
        if (index == worlds.length) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox(height: 40),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildWorldCard(worlds[index], isDarkMode, false),
        );
      },
    );
  }

  Widget _buildWorldGrid(
    List<LimitedWorld> worlds,
    bool isLoading,
    bool isDarkMode,
  ) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 72),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: worlds.length + 1,
      itemBuilder: (context, index) {
        if (index == worlds.length) {
          return Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : const SizedBox(),
          );
        }

        return _buildWorldCard(worlds[index], isDarkMode, true);
      },
    );
  }

  Widget _buildWorldCard(LimitedWorld world, bool isDarkMode, bool isGrid) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Card(
      elevation: 3,
      shadowColor: isDarkMode ? Colors.black38 : Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/world/${world.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // サムネイルイメージ
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: isGrid ? 16 / 12 : 16 / 9,
                  child: world.thumbnailImageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: world.thumbnailImageUrl,
                          fit: BoxFit.cover,
                          httpHeaders: headers,
                          placeholder: (context, url) => Container(
                            color: isDarkMode
                                ? const Color(0xFF262626)
                                : Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: isDarkMode
                                ? const Color(0xFF262626)
                                : Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              size: 40,
                            ),
                          ),
                          cacheManager: JsonCacheManager(),
                        )
                      : Container(
                          color: isDarkMode
                              ? const Color(0xFF262626)
                              : Colors.grey[200],
                          child: const Icon(Icons.image, size: 40),
                        ),
                ),
                // 人気度バッジ
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite, color: Colors.red[400], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          SearchUtils.formatNumber(world.popularity),
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // ワールド情報
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    world.name,
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (world.authorName.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      t.search.tabs.worldSearch.authorPrefix(
                        authorName: world.authorName,
                      ),
                      style: GoogleFonts.notoSans(
                        fontSize: 13,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (world.tags.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    _buildWorldTags(world.tags, isDarkMode),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorldTags(List<String> tags, bool isDarkMode) {
    final displayTags = tags
        .where((tag) => !tag.startsWith('author_'))
        .where((tag) => !tag.startsWith('hidden_'))
        .take(3)
        .toList();

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: displayTags.map((tag) {
        final tagColor = _getTagColor(tag, isDarkMode);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: tagColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: tagColor.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            SearchUtils.formatTag(tag),
            style: GoogleFonts.notoSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: tagColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getTagColor(String tag, bool isDarkMode) {
    if (tag.contains('game')) {
      return Colors.purple[isDarkMode ? 300 : 400]!;
    } else if (tag.contains('world')) {
      return Colors.blue[isDarkMode ? 300 : 400]!;
    } else if (tag.contains('avatar')) {
      return Colors.amber[isDarkMode ? 300 : 700]!;
    } else if (tag.contains('sdk3')) {
      return Colors.green[isDarkMode ? 300 : 600]!;
    } else if (tag.contains('featured') || tag.contains('system_approved')) {
      return Colors.red[isDarkMode ? 300 : 400]!;
    } else {
      return isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
    }
  }
}
