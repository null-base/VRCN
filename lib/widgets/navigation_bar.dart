import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vrchat/controllers/notification_controller.dart';
import 'package:vrchat/controllers/search_state_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/navigation_provider.dart';
import 'package:vrchat/provider/friend_sort_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/provider/search_providers.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/utils/app_icons.dart';
import 'package:vrchat/widgets/app_bar.dart';
import 'package:vrchat/widgets/app_drawer.dart';
import 'package:vrchat/widgets/friend_sort_dialog.dart';

class Navigation extends ConsumerStatefulWidget {
  const Navigation({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  final Widget child;
  final int currentIndex;

  @override
  ConsumerState<Navigation> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(friendOnlineWatcherProvider);
    ref.listen(searchQueryProvider, (_, query) {
      if (_searchController.text != query) {
        _searchController.text = query;
      }
    });

    final theme = Theme.of(context);
    final scaffoldKey = ref.watch(scaffoldKeyProvider);
    final allowSearch = ref.watch(settingsProvider).allowNsfw;
    final isIOS = PlatformInfo.isIOS;
    final visibleIndices = [0, if (allowSearch) 1, 2];
    final destinations = <AdaptiveNavigationDestination>[
      AdaptiveNavigationDestination(
        icon: isIOS ? 'house' : AppIcons.home_outlined,
        selectedIcon: isIOS ? 'house.fill' : AppIcons.home,
        label: t.drawer.home,
      ),
      if (allowSearch)
        AdaptiveNavigationDestination(
          icon: isIOS ? 'magnifyingglass' : AppIcons.search_outlined,
          label: t.common.search,
        ),
      AdaptiveNavigationDestination(
        icon: isIOS ? 'bell' : AppIcons.notifications_outlined,
        selectedIcon: isIOS ? 'bell.fill' : AppIcons.notifications,
        label: t.notifications.title,
      ),
    ];
    final selectedIndex = visibleIndices.indexOf(widget.currentIndex);

    return AdaptiveScaffold(
      scaffoldKey: scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AdaptiveAppBar(
        useNativeToolbar: false,
        cupertinoNavigationBar: _buildCupertinoAppBar(context, scaffoldKey),
        appBar: _buildMaterialAppBar(context, scaffoldKey),
      ),
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        items: destinations,
        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurfaceVariant,
        onTap: (tabIndex) {
          final index = visibleIndices[tabIndex];
          if (widget.currentIndex == index) return;
          ref.read(navigationActionsProvider).setIndex(index);
          context.go(switch (index) {
            1 => '/search',
            2 => '/notifications',
            _ => '/',
          });
        },
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: isIOS && widget.currentIndex == 1
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                    child: CupertinoSearchTextField(
                      controller: _searchController,
                      placeholder: t.common.search,
                      onChanged: _updateSearch,
                      onSubmitted: _updateSearch,
                    ),
                  ),
                  Expanded(child: widget.child),
                ],
              )
            : widget.child,
      ),
    );
  }

  void _updateSearch(String query) {
    ref.read(searchStateControllerProvider).updateQuery(query);
  }

  PreferredSizeWidget _buildMaterialAppBar(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    void openDrawer() => scaffoldKey.currentState?.openDrawer();
    return switch (widget.currentIndex) {
      0 => CustomAppBar(
        onAvatarPressed: openDrawer,
        actions: [
          IconButton(
            icon: const Icon(AppIcons.sort),
            tooltip: t.friend.sortFilter,
            onPressed: () => showFriendSortOptions(context, ref),
          ),
          IconButton(
            icon: const Icon(AppIcons.search),
            tooltip: t.friend.searchTitle,
            onPressed: () => showFriendSearchDialog(context, ref),
          ),
        ],
      ),
      1 => CustomAppBar(
        showSearchBar: true,
        searchController: _searchController,
        onSearchChanged: _updateSearch,
        onAvatarPressed: openDrawer,
      ),
      2 => CustomAppBar(
        title: t.notifications.title,
        onAvatarPressed: openDrawer,
        actions: [
          IconButton(
            icon: const Icon(AppIcons.done_all),
            tooltip: t.notifications.markAllRead,
            onPressed: () => _markAllRead(context),
          ),
        ],
      ),
      _ => CustomAppBar(title: 'VRCN', onAvatarPressed: openDrawer),
    };
  }

  CupertinoNavigationBar _buildCupertinoAppBar(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final title = switch (widget.currentIndex) {
      1 => t.common.search,
      2 => t.notifications.title,
      _ => 'VRCN',
    };
    return CupertinoNavigationBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
      middle: widget.currentIndex == 0
          ? const AppHeaderLogo()
          : Text(title, style: TextStyle(color: scheme.onSurface)),
      leading: Tooltip(
        message: MaterialLocalizations.of(context).openAppDrawerTooltip,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
          child: Icon(AppIcons.menu, color: scheme.onSurface),
        ),
      ),
      trailing: switch (widget.currentIndex) {
        0 => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _cupertinoAction(
              icon: AppIcons.sort,
              tooltip: t.friend.sortFilter,
              onPressed: () => showFriendSortOptions(context, ref),
            ),
            _cupertinoAction(
              icon: AppIcons.search,
              tooltip: t.friend.searchTitle,
              onPressed: () => showFriendSearchDialog(context, ref),
            ),
          ],
        ),
        2 => _cupertinoAction(
          icon: AppIcons.done_all,
          tooltip: t.notifications.markAllRead,
          onPressed: () => _markAllRead(context),
        ),
        _ => null,
      },
    );
  }

  Widget _cupertinoAction({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        onPressed: onPressed,
        child: Icon(
          icon,
          size: 21,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Future<void> _markAllRead(BuildContext context) async {
    await ref.read(notificationControllerProvider).markAllApiAsRead();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.notifications.markAllReadDone),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
