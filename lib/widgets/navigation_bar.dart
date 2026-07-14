import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/search_page.dart';
import 'package:vrchat/provider/navigation_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/provider/search_providers.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/widgets/app_bar.dart';
import 'package:vrchat/widgets/app_drawer.dart';
import 'package:vrchat/widgets/friend_sort_dialog.dart';

class Navigation extends ConsumerWidget {
  Navigation({super.key, required this.child, required this.currentIndex});
  final Widget child;
  final int currentIndex;

  // 検索ページへのアクセス用のキー
  final searchPageKey = GlobalKey<SearchPageState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final scaffoldKey = ref.watch(scaffoldKeyProvider);
    ref.watch(friendOnlineWatcherProvider);

    return Scaffold(
      key: scaffoldKey,
      appBar: _buildAppBarForPage(context, scaffoldKey, ref),
      drawer: const AppDrawer(),
      body: SafeArea(bottom: false, child: child),
      bottomNavigationBar: _buildTwitterStyleNavBar(context, isDarkMode, ref),
    );
  }

  PreferredSizeWidget _buildAppBarForPage(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
    WidgetRef ref,
  ) {
    switch (currentIndex) {
      case 0:
        return CustomAppBar(
          onAvatarPressed: () => scaffoldKey.currentState?.openDrawer(),
          actions: [
            IconButton(
              icon: const Icon(Icons.sort),
              tooltip: '並び替え',
              onPressed: () {
                showFriendSortOptions(context, ref);
              },
            ),
          ],
        );
      case 1:
        // SearchPageのコントローラーを取得
        final searchController = TextEditingController();
        final searchPageController = SearchPage.of(context);

        // 検索ページの初回表示時にコントローラーに現在の検索クエリをセット
        searchController.text = ref.read(searchQueryProvider);

        return CustomAppBar(
          showSearchBar: true,
          searchController:
              searchPageController?.searchController ?? searchController,
          onSearchChanged: (query) {
            if (searchPageController != null) {
              searchPageController.onSearchChanged(query);
            } else {
              // すべてのタブのオフセットをリセット
              ref.read(userSearchOffsetProvider.notifier).state = 0;
              ref.read(worldSearchOffsetProvider.notifier).state = 0;
              ref.read(groupSearchOffsetProvider.notifier).state = 0;
              // 検索クエリを更新
              ref.read(searchQueryProvider.notifier).state = query;
            }
          },
          onAvatarPressed: () => scaffoldKey.currentState?.openDrawer(),
          actions: const [
            // IconButton(
            //   icon: const Icon(Icons.filter_list),
            //   tooltip: 'フィルター',
            //   onPressed: () {
            //     // フィルター機能
            //   },
            // ),
          ],
        );
      case 2:
        return CustomAppBar(
          title: t.notifications.title,
          onAvatarPressed: () => scaffoldKey.currentState?.openDrawer(),
          actions: [
            IconButton(
              icon: const Icon(Icons.done_all),
              tooltip: t.notifications.markAllRead,
              onPressed: () async {
                await ref.read(notificationActionsProvider).markAllAsRead();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.notifications.markAllReadDone),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      default:
        return CustomAppBar(
          title: 'VRCN',
          onAvatarPressed: () => scaffoldKey.currentState?.openDrawer(),
        );
    }
  }

  Widget _buildTwitterStyleNavBar(
    BuildContext context,
    bool isDarkMode,
    WidgetRef ref,
  ) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;
    final borderColor = theme.colorScheme.outlineVariant;
    final allowNsfw = ref.watch(settingsProvider).allowNsfw;

    // 表示するタブのインデックスと設定
    final tabs = <NavigationTabInfo>[
      const NavigationTabInfo(
        index: 0,
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
      ),
      // 不快なコンテンツの同意がある場合のみ検索タブを含める
      if (allowNsfw)
        const NavigationTabInfo(
          index: 1,
          icon: Icons.search_outlined,
          activeIcon: Icons.search,
        ),
      const NavigationTabInfo(
        index: 2,
        icon: Icons.notifications_none_outlined,
        activeIcon: Icons.notifications,
      ),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: borderColor, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabs
                .map(
                  (tab) => _buildNavItem(
                    context,
                    tab.index,
                    tab.icon,
                    tab.activeIcon,
                    isDarkMode,
                    ref,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    IconData activeIcon,
    bool isDarkMode,
    WidgetRef ref,
  ) {
    final isActive = currentIndex == index;

    final theme = Theme.of(context);
    const activeColor = AppTheme.primaryColor;
    final inactiveColor = theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (currentIndex == index) return;

        // インデックスを更新
        ref.read(navigationIndexProvider.notifier).state = index;

        final router = GoRouter.of(context);

        // 遷移先の設定
        final String destination;
        switch (index) {
          case 0:
            destination = '/';
          case 1:
            destination = '/search';
          case 2:
            destination = '/notifications';
          default:
            destination = '/';
        }

        router.go(destination);
      },
      child: SizedBox(
        width: 70,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 44,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive
                  ? activeColor.withValues(alpha: isDarkMode ? 0.18 : 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isActive ? activeIcon : icon,
              color: isActive ? activeColor : inactiveColor,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

// NavigationTabInfoクラスを追加
@immutable
class NavigationTabInfo {
  const NavigationTabInfo({
    required this.index,
    required this.icon,
    required this.activeIcon,
  });
  final int index;
  final IconData icon;
  final IconData activeIcon;
}
