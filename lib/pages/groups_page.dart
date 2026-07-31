import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/controllers/group_list_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class GroupsPage extends ConsumerWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? const Color(0xFF151515)
        : const Color(0xFFF5F5F5);

    // 現在のユーザー情報を取得
    final currentUserAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          t.groups.title,
          style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: currentUserAsync.when(
        data: (currentUser) =>
            _buildGroupsList(context, ref, currentUser.id, isDarkMode, t),
        loading: () => LoadingIndicator(message: t.groups.loadingUser),
        error: (error, _) => ErrorContainer(
          message: t.groups.errorUser(error: error.toString()),
          onRetry: () =>
              ref.read(groupListControllerProvider).refreshCurrentUser(),
        ),
      ),
    );
  }

  Widget _buildGroupsList(
    BuildContext context,
    WidgetRef ref,
    String userId,
    bool isDarkMode,
    Translations t,
  ) {
    // ユーザーのグループ一覧を取得
    final userGroupsAsync = ref.watch(userGroupsProvider(userId));

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(groupListControllerProvider).refreshUserGroups(userId),
      child: userGroupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return _buildEmptyState(context, isDarkMode, t);
          }

          return Column(
            children: [
              // ヘッダー部分
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.black12
                      : Colors.blue.withValues(alpha: 0.05),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
              ),

              // グループリスト
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 16, bottom: 20),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    // アニメーション付きでアイテムを表示
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (index * 30)),
                      curve: Curves.easeInOut,
                      transform: Matrix4.translationValues(0, 0, 0),
                      child: _buildGroupItemEnhanced(
                        context,
                        ref,
                        group,
                        isDarkMode,
                        index,
                        t,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => LoadingIndicator(message: t.groups.loadingGroups),
        error: (error, _) => ErrorContainer(
          message: t.groups.errorGroups(error: error.toString()),
          onRetry: () =>
              ref.read(groupListControllerProvider).refreshUserGroups(userId),
        ),
      ),
    );
  }

  Widget _buildGroupItemEnhanced(
    BuildContext context,
    WidgetRef ref,
    LimitedUserGroups group,
    bool isDarkMode,
    int index,
    Translations t,
  ) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    // グループの種類に応じた色を設定（ランダムだが一貫性あり）
    final colorSets = <List<Color>>[
      [Colors.blue.shade700, Colors.blue.shade500],
      [Colors.purple.shade700, Colors.purple.shade500],
      [Colors.teal.shade700, Colors.teal.shade500],
      [Colors.deepOrange.shade700, Colors.deepOrange.shade500],
      [Colors.indigo.shade700, Colors.indigo.shade500],
    ];
    final colorSet = colorSets[index % colorSets.length];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shadowColor: isDarkMode ? Colors.black38 : Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push('/group/${group.groupId}'),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDarkMode
                    ? [Colors.grey.shade900, Colors.grey.shade800]
                    : [Colors.white, Colors.grey.shade50],
              ),
            ),
            child: Column(
              children: [
                // ヘッダー部分（バナー画像、アイコン、名前、ショートコード）
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: group.bannerUrl != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                              group.bannerUrl!,
                              headers: headers,
                              cacheManager: JsonCacheManager(),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                    gradient: group.bannerUrl == null
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDarkMode
                                ? [
                                    colorSet[0].withValues(alpha: 0.7),
                                    colorSet[1].withValues(alpha: 0.5),
                                  ]
                                : [
                                    colorSet[0].withValues(alpha: 0.2),
                                    colorSet[1].withValues(alpha: 0.1),
                                  ],
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      if (group.bannerUrl != null)
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withValues(alpha: 0.6),
                                  Colors.black.withValues(alpha: 0.3),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: group.iconUrl != null
                                        ? CachedNetworkImage(
                                            imageUrl: group.iconUrl!,
                                            fit: BoxFit.cover,
                                            httpHeaders: headers,
                                            cacheManager: JsonCacheManager(),
                                            placeholder: (context, url) =>
                                                ColoredBox(
                                                  color: isDarkMode
                                                      ? colorSet[0].withValues(
                                                          alpha: 0.3,
                                                        )
                                                      : colorSet[0].withValues(
                                                          alpha: 0.1,
                                                        ),
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                            errorWidget:
                                                (
                                                  context,
                                                  url,
                                                  error,
                                                ) => ColoredBox(
                                                  color: isDarkMode
                                                      ? colorSet[0].withValues(
                                                          alpha: 0.3,
                                                        )
                                                      : colorSet[0].withValues(
                                                          alpha: 0.1,
                                                        ),
                                                  child: Icon(
                                                    Icons.group,
                                                    color: colorSet[0]
                                                        .withValues(
                                                          alpha: 0.6,
                                                        ),
                                                  ),
                                                ),
                                          )
                                        : ColoredBox(
                                            color: isDarkMode
                                                ? colorSet[0].withValues(
                                                    alpha: 0.3,
                                                  )
                                                : colorSet[0].withValues(
                                                    alpha: 0.1,
                                                  ),
                                            child: Icon(
                                              Icons.group,
                                              color: colorSet[0].withValues(
                                                alpha: 0.6,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group.name ?? t.groups.unknownName,
                                        style: GoogleFonts.notoSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: group.bannerUrl != null
                                              ? Colors.white
                                              : isDarkMode
                                              ? Colors.white
                                              : Colors.black87,
                                          shadows: group.bannerUrl != null
                                              ? [
                                                  Shadow(
                                                    offset: const Offset(
                                                      0,
                                                      1,
                                                    ),
                                                    blurRadius: 3,
                                                    color: Colors.black
                                                        .withValues(
                                                          alpha: 0.7,
                                                        ),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (group.shortCode != null)
                                        Text(
                                          '@${group.shortCode}',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: group.bannerUrl != null
                                                ? Colors.grey[300]
                                                : isDarkMode
                                                ? Colors.grey[300]
                                                : Colors.grey[700],
                                            shadows: group.bannerUrl != null
                                                ? [
                                                    Shadow(
                                                      offset: const Offset(
                                                        0,
                                                        1,
                                                      ),
                                                      blurRadius: 2,
                                                      color: Colors.black
                                                          .withValues(
                                                            alpha: 0.5,
                                                          ),
                                                    ),
                                                  ]
                                                : null,
                                          ),
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

                // 詳細情報部分
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // メンバー数と役割
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // メンバー数
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.people,
                                  size: 16,
                                  color: isDarkMode ? colorSet[1] : colorSet[0],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                t.groups.members(
                                  count: (group.memberCount ?? '?').toString(),
                                ),
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: isDarkMode
                                      ? Colors.grey[300]
                                      : Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 詳細ボタン
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => context.push('/group/${group.groupId}'),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.groups.showDetails,
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: colorSet[0],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: colorSet[0],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool isDarkMode,
    Translations t,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.blueGrey.shade800.withValues(alpha: 0.3)
                  : Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.group_rounded,
              size: 60,
              color: Colors.blue.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            t.groups.emptyTitle,
            style: GoogleFonts.notoSans(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              t.groups.emptyDescription,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            icon: const Icon(Icons.search),
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text(
                t.groups.searchGroups,
                style: GoogleFonts.notoSans(fontSize: 16),
              ),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue.shade500,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => context.push('/search?tab=groups'),
          ),
        ],
      ),
    );
  }
}
