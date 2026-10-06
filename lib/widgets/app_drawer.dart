import 'package:vrchat/utils/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:vrchat/controllers/profile_controller.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart'; // 多言語化パッケージ
import 'package:vrchat/provider/package_info_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/status_helpers.dart';
import 'package:vrchat/widgets/feedback_dialog.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    final inAppReview = InAppReview.instance;

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            right: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        child: Column(
          children: [
            // ユーザー情報ヘッダー
            currentUserAsync.when(
              data: (user) =>
                  _buildEnhancedHeader(context, user, headers, isDarkMode, t),
              loading: () => _buildStylishLoadingHeader(context, isDarkMode, t),
              error: (_, _) =>
                  _buildEnhancedErrorHeader(context, ref, isDarkMode, t),
            ),

            // メニュー項目
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Column(
                    children: [
                      // スクロール可能なメニュー部分
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 6),

                              // メインナビゲーション
                              _buildNavigationSection(
                                context: context,
                                isDarkMode: isDarkMode,
                                items: [
                                  _MenuItem(
                                    icon: AppIcons.home_rounded,
                                    title: t.drawer.home,
                                    isSelected:
                                        GoRouterState.of(context).uri.path ==
                                        '/',
                                    onTap: () {
                                      context.go('/');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.person_rounded,
                                    title: t.drawer.profile,
                                    isSelected:
                                        GoRouterState.of(context).uri.path ==
                                        '/profile',
                                    onTap: () {
                                      context.push('/profile');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.favorite_rounded,
                                    title: t.drawer.favorite,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/favorites'),
                                    onTap: () {
                                      context.push('/favorites');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.calendar_month,
                                    title: t.drawer.eventCalendar,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/event_calendar'),
                                    onTap: () {
                                      context.push('/event_calendar');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.notifications_rounded,
                                    title: t.notifications.title,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/notifications'),
                                    onTap: () {
                                      context.push('/notifications');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.bolt_outlined,
                                    title: t.drawer.activity,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/activity'),
                                    onTap: () {
                                      context.push('/activity');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.trending_up,
                                    title: t.drawer.insights,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/insights'),
                                    onTap: () {
                                      context.push('/insights');
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),

                              // コンテンツセクション
                              _buildSectionHeader(
                                context,
                                t.drawer.section.content,
                                isDarkMode,
                              ),
                              _buildNavigationSection(
                                context: context,
                                isDarkMode: isDarkMode,
                                items: [
                                  _MenuItem(
                                    icon: AppIcons.face_rounded,
                                    title: t.drawer.avatar,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/avatars'),
                                    onTap: () {
                                      context.push('/avatars');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.group_rounded,
                                    title: t.drawer.group,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/groups'),
                                    onTap: () {
                                      context.push('/groups');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.inventory,
                                    title: t.drawer.inventory,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/inventory'),
                                    onTap: () {
                                      context.push('/inventory');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.gavel_outlined,
                                    title: t.drawer.moderation,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/moderation'),
                                    onTap: () {
                                      context.push('/moderation');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.settings_rounded,
                                    title: t.drawer.tools,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/tools'),
                                    onTap: () {
                                      context.push('/tools');
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),

                              // 設定セクション
                              _buildSectionHeader(
                                context,
                                t.drawer.section.other,
                                isDarkMode,
                              ),
                              _buildNavigationSection(
                                context: context,
                                isDarkMode: isDarkMode,
                                items: [
                                  _MenuItem(
                                    icon: AppIcons.star_outlined,
                                    title: t.drawer.review,
                                    isSelected: false,
                                    onTap: () {
                                      Navigator.pop(context);
                                      inAppReview.requestReview();
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.feedback_outlined,
                                    title: t.drawer.feedback,
                                    isSelected: false,
                                    onTap: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const FeedbackDialog(),
                                      );
                                    },
                                  ),
                                  _MenuItem(
                                    icon: AppIcons.settings_rounded,
                                    title: t.drawer.settings,
                                    isSelected:
                                        GoRouterState.of(context).uri.path ==
                                        '/settings',
                                    onTap: () {
                                      context.push('/settings');
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),

                              // 下部のスペース
                              const SizedBox(height: 20),

                              // フッターセクション（固定）
                              _buildFooterSection(ref),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // セクションヘッダー
  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    bool isDarkMode,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  // アニメーション付きメニュー項目
  Widget _buildAnimatedMenuItem({
    required BuildContext context,
    required IconData? icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      minLeadingWidth: 24,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      selected: isSelected,
      selectedTileColor: theme.colorScheme.surfaceContainerLow,
      selectedColor: theme.colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: Icon(
        icon,
        size: 21,
        color: isSelected
            ? theme.colorScheme.onSurface
            : theme.colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      onTap: onTap,
    );
  }

  // ナビゲーションセクション
  Widget _buildNavigationSection({
    required BuildContext context,
    required bool isDarkMode,
    required List<_MenuItem> items,
  }) {
    return Column(
      children: items
          .map(
            (item) => _buildAnimatedMenuItem(
              context: context,
              icon: item.icon,
              title: item.title,
              isSelected: item.isSelected,
              onTap: item.onTap,
              isDarkMode: isDarkMode,
            ),
          )
          .toList(),
    );
  }

  // ヘッダー
  Widget _buildEnhancedHeader(
    BuildContext context,
    CurrentUser user,
    Map<String, String> headers,
    bool isDarkMode,
    Translations t, // 追加
  ) {
    final statusColor = StatusHelper.getStatusColor(user.status);
    final avatarUrl = (user.iconUrl ?? '').isNotEmpty
        ? user.iconUrl!
        : user.currentAvatarThumbnailImageUrl;
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: scheme.surfaceContainerHighest,
                  backgroundImage: avatarUrl.isNotEmpty
                      ? CachedNetworkImageProvider(
                          avatarUrl,
                          headers: headers,
                          cacheManager: JsonCacheManager(),
                        )
                      : AssetImage(Assets.icons.icon.path) as ImageProvider,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: scheme.surface,
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                  if (user.statusDescription.isNotEmpty)
                    Text(
                      user.statusDescription,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
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

  // ローディングヘッダー
  Widget _buildStylishLoadingHeader(
    BuildContext context,
    bool isDarkMode,
    Translations t,
  ) {
    return SafeArea(
      bottom: false,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        leading: const SizedBox(
          width: 54,
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        title: Text(t.drawer.userLoading),
      ),
    );
  }

  // エラーヘッダー
  Widget _buildEnhancedErrorHeader(
    BuildContext context,
    WidgetRef ref,
    bool isDarkMode,
    Translations t,
  ) {
    return SafeArea(
      bottom: false,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        leading: Icon(
          AppIcons.error_outline_rounded,
          color: Theme.of(context).colorScheme.error,
        ),
        title: Text(t.drawer.userError),
        trailing: IconButton(
          tooltip: t.drawer.retry,
          onPressed: () =>
              ref.read(profileControllerProvider).reloadCurrentUser(),
          icon: const Icon(AppIcons.refresh_rounded),
        ),
      ),
    );
  }

  // フッターセクションを修正
  Widget _buildFooterSection(WidgetRef ref) {
    final scheme = Theme.of(ref.context).colorScheme;
    final packageInfo = ref.watch(packageInfoProvider).value;
    final version = packageInfo?.version ?? '1.0.0';
    final buildNumber = packageInfo?.buildNumber ?? '1';

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              Assets.images.sheIsWatchingYou.path,
              width: 72,
              height: 300,
              fit: BoxFit.contain,
              alignment: Alignment.bottomLeft,
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(Assets.images.icon.path, width: 48, height: 48),
                const SizedBox(height: 8),
                Text(
                  'VRCN  $version ($buildNumber)',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// メニュー項目データクラス
@immutable
class _MenuItem {
  const _MenuItem({
    this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final IconData? icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
}
