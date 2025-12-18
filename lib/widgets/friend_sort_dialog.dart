import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/friend_sort_provider.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/theme/app_theme.dart';

/// フレンドリスト並び替え・フィルターダイアログ
void showFriendSortOptions(BuildContext context, WidgetRef ref) {
  // ローカル変数を用意して即時の状態更新を可能にする
  var localSortType = ref.read(friendSortTypeProvider);
  var localDirection = ref.read(friendSortDirectionProvider);
  var localFilter = ref.read(friendFilterProvider);

  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        t.friend.sortFilter,
                        style: GoogleFonts.notoSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.filter_list_rounded,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                t.friend.filter,
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // フィルターオプション
                        _buildFilterOption(
                          context: context,
                          icon: Icons.people_alt_rounded,
                          title: t.friend.filterAll,
                          isSelected: localFilter == FriendFilter.all,
                          isDarkMode: isDarkMode,
                          onTap: () {
                            setState(() {
                              localFilter = FriendFilter.all;
                            });
                            ref.read(friendFilterProvider.notifier).state =
                                FriendFilter.all;
                          },
                        ),

                        _buildFilterOption(
                          context: context,
                          icon: Icons.wifi_rounded,
                          title: t.friend.filterOnline,
                          isSelected: localFilter == FriendFilter.online,
                          isDarkMode: isDarkMode,
                          onTap: () {
                            setState(() {
                              localFilter = FriendFilter.online;
                            });
                            ref.read(friendFilterProvider.notifier).state =
                                FriendFilter.online;
                          },
                        ),

                        _buildFilterOption(
                          context: context,
                          icon: Icons.wifi_off_rounded,
                          title: t.friend.filterOffline,
                          isSelected: localFilter == FriendFilter.offline,
                          isDarkMode: isDarkMode,
                          onTap: () {
                            setState(() {
                              localFilter = FriendFilter.offline;
                            });
                            ref.read(friendFilterProvider.notifier).state =
                                FriendFilter.offline;
                          },
                        ),
                        _buildFilterOption(
                          context: context,
                          icon: Icons.favorite_rounded,
                          title: t.friend.filterFavorite,
                          isSelected: localFilter == FriendFilter.favorite,
                          isDarkMode: isDarkMode,
                          onTap: () {
                            setState(() {
                              localFilter = FriendFilter.favorite;
                            });
                            ref.read(friendFilterProvider.notifier).state =
                                FriendFilter.favorite;
                          },
                        ),
                        const Divider(height: 32, thickness: 1),
                        // 並び替えセクションのヘッダー
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.sort,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                t.friend.sort,
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 並び替え種類
                        ListTile(
                          leading: const Icon(Icons.circle),
                          title: Text(
                            t.friend.sortStatus,
                            style: GoogleFonts.notoSans(),
                          ),
                          trailing:
                              localSortType == FriendSortType.status
                                  ? const Icon(Icons.check)
                                  : null,
                          onTap: () {
                            // プロバイダーを更新
                            ref
                                .read(friendSortTypeProvider.notifier)
                                .setSortType(FriendSortType.status);
                            // ローカル変数も更新
                            setState(() {
                              localSortType = FriendSortType.status;
                            });
                          },
                        ),

                        ListTile(
                          leading: const Icon(Icons.sort_by_alpha),
                          title: Text(
                            t.friend.sortName,
                            style: GoogleFonts.notoSans(),
                          ),
                          trailing:
                              localSortType == FriendSortType.name
                                  ? const Icon(Icons.check)
                                  : null,
                          onTap: () {
                            ref
                                .read(friendSortTypeProvider.notifier)
                                .setSortType(FriendSortType.name);
                            setState(() {
                              localSortType = FriendSortType.name;
                            });
                          },
                        ),

                        ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text(
                            t.friend.sortLastLogin,
                            style: GoogleFonts.notoSans(),
                          ),
                          trailing:
                              localSortType == FriendSortType.lastLogin
                                  ? const Icon(Icons.check)
                                  : null,
                          onTap: () {
                            ref
                                .read(friendSortTypeProvider.notifier)
                                .setSortType(FriendSortType.lastLogin);
                            setState(() {
                              localSortType = FriendSortType.lastLogin;
                            });
                          },
                        ),

                        const Divider(),

                        // 並び替え方向
                        ListTile(
                          leading: Icon(
                            localDirection == SortDirection.ascending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                          ),
                          title: Text(
                            localDirection == SortDirection.ascending
                                ? t.friend.sortAsc
                                : t.friend.sortDesc,
                            style: GoogleFonts.notoSans(),
                          ),
                          onTap: () {
                            final newDirection =
                                localDirection == SortDirection.ascending
                                    ? SortDirection.descending
                                    : SortDirection.ascending;
                            ref
                                .read(friendSortDirectionProvider.notifier)
                                .setDirection(newDirection);
                            setState(() {
                              localDirection = newDirection;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// フィルターオプション（app_drawerから移植）
Widget _buildFilterOption({
  required BuildContext context,
  required IconData icon,
  required String title,
  required bool isSelected,
  required bool isDarkMode,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppTheme.primaryColor.withAlpha(25)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? AppTheme.primaryColor
                    : isDarkMode
                    ? Colors.grey[700]!
                    : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  isSelected
                      ? AppTheme.primaryColor
                      : isDarkMode
                      ? Colors.grey[400]
                      : Colors.grey[600],
              size: 18,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color:
                    isSelected
                        ? AppTheme.primaryColor
                        : isDarkMode
                        ? Colors.white
                        : Colors.black87,
              ),
            ),
            const Spacer(),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected
                          ? AppTheme.primaryColor
                          : isDarkMode
                          ? Colors.grey[600]!
                          : Colors.grey[400]!,
                  width: 1.5,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      : null,
            ),
          ],
        ),
      ),
    ),
  );
}
