import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/group_provider.dart' as gp;
import 'package:vrchat/provider/search_providers.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/search_widgets.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class GroupSearchTab extends ConsumerStatefulWidget {
  const GroupSearchTab({super.key});

  @override
  ConsumerState<GroupSearchTab> createState() => _GroupSearchTabState();
}

class _GroupSearchTabState extends ConsumerState<GroupSearchTab>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  var _isGridView = false; // グリッドビューとリストビューの切り替えフラグ

  @override
  bool get wantKeepAlive => true; // タブ切り替え時に状態を保持

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
    advanceSearchOffset(ref, groupSearchOffsetProvider);
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
    final offset = ref.watch(groupSearchOffsetProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isMobileSize = size.width < 600;

    // レスポンシブデザイン：モバイルでは常にリストビュー
    final effectiveIsGridView = !isMobileSize && _isGridView;

    // 検索機能に関連するプロバイダーなので、search_providersからのものを使用
    final cachedResults = ref.watch(groupSearchResultsProvider);

    final searchProvider = gp.groupSearchProvider(
      gp.GroupSearchParams(query: query, offset: offset),
    );
    final searchState = ref.watch(searchProvider);

    // searchStateが変化したときの処理
    ref.listen<AsyncValue<List<LimitedGroup>>>(
      searchProvider,
      (previous, current) {
        handlePagedSearchResults(
          ref: ref,
          state: current,
          offset: offset,
          cachedResults: cachedResults,
          resultsProvider: groupSearchResultsProvider,
          idOf: (group) => group.id,
        );
      },
    );

    if (query.isEmpty) {
      return _buildEmptySearchPrompt(isDarkMode);
    }

    // 検索クエリが変わった場合、ローディング状態を優先表示
    if (searchState.isLoading && offset == 0) {
      return Center(
        child: LoadingIndicator(message: t.search.tabs.groupSearch.searching),
      );
    }

    // エラー状態の処理
    if (searchState.hasError && cachedResults.isEmpty) {
      return buildErrorState(
        t.search.tabs.groupSearch.error(error: searchState.error.toString()),
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
                  ? t.search.tabs.groupSearch.listView
                  : t.search.tabs.groupSearch.gridView,
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
        Column(
          children: [
            // 検索結果表示エリア
            Expanded(
              child: effectiveIsGridView
                  ? _buildGroupGrid(
                      cachedResults,
                      searchState.isLoading,
                      isDarkMode,
                    )
                  : _buildGroupList(
                      cachedResults,
                      searchState.isLoading,
                      isDarkMode,
                    ),
            ),
          ],
        ),
        viewToggleButton,
      ],
    );
  }

  // グリッドビュー
  Widget _buildGroupGrid(
    List<LimitedGroup> groups,
    bool isLoading,
    bool isDarkMode,
  ) {
    return MasonryGridView.count(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: groups.length + 1,
      itemBuilder: (context, index) {
        if (index == groups.length) {
          // 最後の項目の場合、ローディングインジケータを表示
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox(height: 40),
            ),
          );
        }

        final group = groups[index];
        return _buildGroupGridItem(context, group, isDarkMode);
      },
    );
  }

  // リストビュー
  Widget _buildGroupList(
    List<LimitedGroup> groups,
    bool isLoading,
    bool isDarkMode,
  ) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: groups.length + 1,
      itemBuilder: (context, index) {
        if (index == groups.length) {
          // 最後の項目の場合、ローディングインジケータを表示
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox(height: 40),
            ),
          );
        }

        final group = groups[index];
        return _buildGroupListItem(group, isDarkMode);
      },
    );
  }

  // グリッドアイテム
  Widget _buildGroupGridItem(
    BuildContext context,
    LimitedGroup group,
    bool isDarkMode,
  ) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push('/group/${group.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: group.iconUrl != null && group.iconUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: group.iconUrl!,
                            fit: BoxFit.cover,
                            httpHeaders: headers,
                            cacheManager: JsonCacheManager(),
                            placeholder: (context, url) => Container(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              child: const Icon(Icons.group, size: 60),
                            ),
                          )
                        : Container(
                            color: isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[300],
                            child: Center(
                              child: Icon(
                                Icons.group,
                                size: 60,
                                color: isDarkMode
                                    ? Colors.grey[600]
                                    : Colors.grey[500],
                              ),
                            ),
                          ),
                  ),
                  // グラデーションオーバーレイ
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // メンバー数
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.people,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            t.search.tabs.groupSearch.memberCount(
                              count: '${group.memberCount ?? "?"}',
                            ),
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

              // グループ情報
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name.toString(),
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (group.shortCode != null) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.tag,
                            size: 14,
                            color: isDarkMode
                                ? Colors.indigo.shade300
                                : Colors.indigo.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            group.shortCode!,
                            style: GoogleFonts.notoSans(
                              fontSize: 13,
                              color: isDarkMode
                                  ? Colors.indigo.shade300
                                  : Colors.indigo.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // グループリストアイテムのウィジェット
  Widget _buildGroupListItem(LimitedGroup group, bool isDarkMode) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shadowColor: isDarkMode ? Colors.black38 : Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/group/${group.id}'),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // グループアイコン
              Hero(
                tag: 'group-${group.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: group.iconUrl != null && group.iconUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: group.iconUrl!,
                            fit: BoxFit.cover,
                            httpHeaders: headers,
                            cacheManager: JsonCacheManager(),
                            placeholder: (context, url) => Container(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              child: const Icon(Icons.group, size: 30),
                            ),
                          )
                        : Container(
                            color: isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[300],
                            child: Icon(
                              Icons.group,
                              size: 30,
                              color: isDarkMode
                                  ? Colors.grey[600]
                                  : Colors.grey[500],
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // グループ情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // グループ名
                    Text(
                      group.name.toString(),
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // グループコード
                    if (group.shortCode != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.tag,
                            size: 14,
                            color: isDarkMode
                                ? Colors.indigo.shade300
                                : Colors.indigo.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            group.shortCode!,
                            style: GoogleFonts.notoSans(
                              fontSize: 13,
                              color: isDarkMode
                                  ? Colors.indigo.shade300
                                  : Colors.indigo.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                    ],

                    // メンバー数
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 14,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          t.search.tabs.groupSearch.memberCount(
                            count: '${group.memberCount ?? "?"}',
                          ),
                          style: GoogleFonts.notoSans(
                            fontSize: 13,
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 矢印アイコン
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

  // 空の検索状態
  Widget _buildEmptySearchPrompt(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.groups,
            size: 100,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            t.search.tabs.groupSearch.emptyTitle,
            style: GoogleFonts.notoSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.search.tabs.groupSearch.emptyDescription,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // 検索結果なし
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
            t.search.tabs.groupSearch.noResultsWithQuery(query: query),
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.search.tabs.groupSearch.noResultsHint,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
