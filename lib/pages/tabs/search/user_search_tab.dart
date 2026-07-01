import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/search_providers.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/search_widgets.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class UserSearchTab extends ConsumerStatefulWidget {
  const UserSearchTab({super.key});

  @override
  ConsumerState<UserSearchTab> createState() => _UserSearchTabState();
}

class _UserSearchTabState extends ConsumerState<UserSearchTab> {
  final _scrollController = ScrollController();

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
    advanceSearchOffset(ref, userSearchOffsetProvider);
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final offset = ref.watch(userSearchOffsetProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // 累積された結果を取得
    final cachedResults = ref.watch(userSearchResultsProvider);

    final searchProvider = userSearchProvider(
      UserSearchParams(search: query, offset: offset),
    );
    final searchState = ref.watch(searchProvider);

    // 検索状態が変化したときのリスナー
    ref.listen<AsyncValue<List<LimitedUser>>>(
      searchProvider,
      (previous, current) {
        handlePagedSearchResults(
          ref: ref,
          state: current,
          offset: offset,
          cachedResults: cachedResults,
          resultsProvider: userSearchResultsProvider,
          idOf: (user) => user.id,
        );
      },
    );

    if (query.isEmpty) {
      return buildEmptySearchState(
        t.search.tabs.userSearch.emptyTitle,
        Icons.people,
        isDarkMode,
      );
    }

    if (searchState.isLoading && offset == 0) {
      return Center(
        child: LoadingIndicator(message: t.search.tabs.userSearch.searching),
      );
    }

    if (searchState.hasError && cachedResults.isEmpty) {
      return buildErrorState(
        t.search.tabs.userSearch.error(error: searchState.error.toString()),
        isDarkMode,
      );
    }

    if (cachedResults.isEmpty && !searchState.isLoading) {
      return buildNoResultsState(query, isDarkMode);
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: cachedResults.length + 1,
      itemBuilder: (context, index) {
        if (index == cachedResults.length) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: searchState.isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox(height: 40),
            ),
          );
        }

        final user = cachedResults[index];
        return _buildUserCard(user, isDarkMode);
      },
    );
  }

  Widget _buildUserCard(LimitedUser user, bool isDarkMode) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Card(
      elevation: 2,
      shadowColor: isDarkMode ? Colors.black26 : Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/user/${user.id}'),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage:
                      user.userIcon != null && user.userIcon!.isNotEmpty
                      ? CachedNetworkImageProvider(
                          user.userIcon!,
                          headers: headers,
                          cacheManager: JsonCacheManager(),
                        )
                      : (user.currentAvatarThumbnailImageUrl != null
                            ? CachedNetworkImageProvider(
                                user.currentAvatarThumbnailImageUrl!,
                                headers: headers,
                                cacheManager: JsonCacheManager(),
                              )
                            : null),
                  backgroundColor:
                      (user.userIcon == null || user.userIcon!.isEmpty) &&
                          user.currentAvatarThumbnailImageUrl == null
                      ? Colors.grey[300]
                      : null,
                  child:
                      (user.userIcon == null || user.userIcon!.isEmpty) &&
                          user.currentAvatarThumbnailImageUrl == null
                      ? const Icon(Icons.person, color: Colors.grey)
                      : null,
                ),
              ),

              const SizedBox(width: 16),
              // ユーザー情報（名前のみ）
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.displayName,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (user.statusDescription.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        user.statusDescription,
                        style: GoogleFonts.notoSans(
                          fontSize: 13,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // 右端のアイコン
              Icon(
                Icons.chevron_right,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
