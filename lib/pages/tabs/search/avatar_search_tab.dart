import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/models/avtrdb_search_result.dart';
import 'package:vrchat/provider/avtrdb_provider.dart';
import 'package:vrchat/provider/search_providers.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/search_widgets.dart';

class AvatarSearchTab extends ConsumerWidget {
  const AvatarSearchTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (query.isEmpty) {
      return buildEmptySearchState(
        t.search.tabs.avatarSearch.avatar,
        Icons.person_outline,
        isDarkMode,
      );
    }

    final searchResultAsync = ref.watch(avtrDbSearchProvider(query));

    return searchResultAsync.when(
      data: (avatars) {
        if (avatars.isEmpty) {
          return _buildNoResultsFound(isDarkMode);
        }

        return _buildSearchResults(context, avatars, isDarkMode);
      },
      loading:
          () => LoadingIndicator(message: t.search.tabs.avatarSearch.searching),
      error:
          (error, stack) => ErrorContainer(
            message: error.toString(),
            onRetry: () => ref.refresh(avtrDbSearchProvider(query)),
          ),
    );
  }

  Widget _buildNoResultsFound(bool isDarkMode) {
    return Center(
      child: AnimationConfiguration.staggeredList(
        position: 0,
        duration: const Duration(milliseconds: 500),
        child: SlideAnimation(
          verticalOffset: 50,
          child: FadeInAnimation(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        isDarkMode
                            ? Colors.grey[800]!.withValues(alpha: 0.3)
                            : Colors.grey[200]!.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search_off_rounded,
                    size: 60,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  t.search.tabs.avatarSearch.noResults,
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  t.search.tabs.avatarSearch.noResultsHint,
                  style: GoogleFonts.notoSans(
                    fontSize: 15,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    List<AvtrDbSearchResult> avatars,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // アバター検索結果グリッド
        Expanded(
          child: AnimationLimiter(
            child: MasonryGridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                final avatar = avatars[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: _buildAvatarItem(context, avatar, isDarkMode),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarItem(
    BuildContext context,
    AvtrDbSearchResult avatar,
    bool isDarkMode,
  ) {
    // ランダムな要素を追加してデザインのバリエーションを増やす
    final cardHeight = 240.0 + (avatar.name.length % 3) * 10;

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
          onTap: () => context.push('/avatar/${avatar.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: cardHeight,
                    child: CachedNetworkImage(
                      imageUrl: avatar.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      cacheManager: JsonCacheManager(),
                      placeholder:
                          (context, url) => Container(
                            color:
                                isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Container(
                            color:
                                isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[300],
                            child: const Icon(Icons.broken_image),
                          ),
                    ),
                  ),
                  // 画像上にグラデーションオーバーレイを追加
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
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
                ],
              ),

              // アバター情報
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      avatar.name,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.grey[800],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 14,
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            avatar.authorName,
                            style: GoogleFonts.notoSans(
                              fontSize: 13,
                              color:
                                  isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
