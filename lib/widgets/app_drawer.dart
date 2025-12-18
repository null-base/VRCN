import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart'; // 多言語化パッケージ
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                isDarkMode
                    ? [const Color(0xFF141E30), const Color(0xFF243B55)]
                    : [Colors.white, const Color(0xFFF5F7FA)],
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(5, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            // ユーザー情報ヘッダー
            currentUserAsync.when(
              data:
                  (user) => _buildEnhancedHeader(
                    context,
                    user,
                    headers,
                    isDarkMode,
                    t,
                  ),
              loading: () => _buildStylishLoadingHeader(context, isDarkMode, t),
              error:
                  (_, _) =>
                      _buildEnhancedErrorHeader(context, ref, isDarkMode, t),
            ),

            // メニュー項目
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color:
                      isDarkMode
                          ? const Color(0xFF1A1F2C).withValues(alpha: 0.9)
                          : Colors.white.withValues(alpha: 0.9),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                  ),
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
                                    icon: Icons.home_rounded,
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
                                    icon: Icons.person_rounded,
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
                                    icon: Icons.favorite_rounded,
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
                                    icon: Icons.rss_feed,
                                    title: 'フレンドログ',
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/notifications'),
                                    onTap: () {
                                      context.push('/notifications');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: Icons.calendar_month,
                                    title: t.drawer.eventCalendar,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/event_calendar'),
                                    onTap: () {
                                      context.push('/event_calendar');
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),

                              // コンテンツセクション
                              _buildSectionHeader(
                                t.drawer.section.content,
                                isDarkMode,
                              ),
                              _buildNavigationSection(
                                context: context,
                                isDarkMode: isDarkMode,
                                items: [
                                  _MenuItem(
                                    icon: Icons.face_rounded,
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
                                    icon: Icons.group_rounded,
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
                                    icon: Icons.inventory,
                                    title: t.drawer.inventory,
                                    isSelected: GoRouterState.of(
                                      context,
                                    ).uri.path.startsWith('/inventory'),
                                    onTap: () {
                                      context.push('/inventory');
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),

                              // 設定セクション
                              _buildSectionHeader(
                                t.drawer.section.other,
                                isDarkMode,
                              ),
                              _buildNavigationSection(
                                context: context,
                                isDarkMode: isDarkMode,
                                items: [
                                  _MenuItem(
                                    imagePath: Assets.images.logo.path,
                                    title: t.drawer.vrcnsync,
                                    isSelected:
                                        GoRouterState.of(context).uri.path ==
                                        '/vrcnsync',
                                    onTap: () {
                                      context.push('/vrcnsync');
                                      Navigator.pop(context);
                                    },
                                  ),
                                  _MenuItem(
                                    icon: Icons.star_outlined,
                                    title: t.drawer.review,
                                    isSelected: false,
                                    onTap: () {
                                      Navigator.pop(context);
                                      inAppReview.requestReview();
                                    },
                                  ),
                                  _MenuItem(
                                    icon: Icons.feedback_outlined,
                                    title: t.drawer.feedback,
                                    isSelected: false,
                                    onTap: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder:
                                            (context) => const FeedbackDialog(),
                                      );
                                    },
                                  ),
                                  _MenuItem(
                                    icon: Icons.settings_rounded,
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
                              _buildFooterSection(isDarkMode),
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
  Widget _buildSectionHeader(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.notoSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 1,
              color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  // アニメーション付きメニュー項目
  Widget _buildAnimatedMenuItem({
    required BuildContext context,
    required IconData? icon,
    String? imagePath,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    const selectedColor = AppTheme.primaryColor;
    final unselectedIconColor =
        isDarkMode ? Colors.grey[400] : Colors.grey[700];
    final unselectedTextColor =
        isDarkMode ? Colors.grey[300] : Colors.grey[800];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            isSelected
                ? selectedColor.withValues(alpha: isDarkMode ? 0.15 : 0.1)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: selectedColor.withValues(alpha: 0.1),
          highlightColor: selectedColor.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                // アイコンまたは画像
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? selectedColor
                            : isDarkMode
                            ? const Color(0xFF2A3142)
                            : const Color(0xFFF0F3F6),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: selectedColor.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                            : null,
                  ),
                  child:
                      imagePath != null
                          ? Image.asset(
                            imagePath,
                            width: 22,
                            height: 22,
                            color:
                                isSelected ? Colors.white : unselectedIconColor,
                          )
                          : Icon(
                            icon!,
                            color:
                                isSelected ? Colors.white : unselectedIconColor,
                            size: 22,
                          ),
                ),

                const SizedBox(width: 10),

                // タイトル
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.notoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? selectedColor : unselectedTextColor,
                    ),
                  ),
                ),

                // 選択インジケーター
                if (isSelected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: selectedColor.withValues(alpha: 0.3),
                          blurRadius: 6,
                          spreadRadius: 1,
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

  // ナビゲーションセクション
  Widget _buildNavigationSection({
    required BuildContext context,
    required bool isDarkMode,
    required List<_MenuItem> items,
  }) {
    return Column(
      children:
          items
              .map(
                (item) => _buildAnimatedMenuItem(
                  context: context,
                  icon: item.icon,
                  imagePath: item.imagePath,
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              isDarkMode
                  ? [const Color(0xFF2A3F54), const Color(0xFF1F2A40)]
                  : [
                    const Color(0xFF5C6BC0).withValues(alpha: 0.15),
                    const Color(0xFF9FA8DA).withValues(alpha: 0.1),
                  ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ユーザーアバター
            Center(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withValues(alpha: 0.7),
                          AppTheme.primaryColor.withValues(alpha: 0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor:
                          isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      backgroundImage:
                          user.userIcon.isNotEmpty
                              ? CachedNetworkImageProvider(
                                user.userIcon,
                                headers: headers,
                                cacheManager: JsonCacheManager(),
                              )
                              : user.currentAvatarThumbnailImageUrl.isNotEmpty
                              ? CachedNetworkImageProvider(
                                user.currentAvatarThumbnailImageUrl,
                                headers: headers,
                                cacheManager: JsonCacheManager(),
                              )
                              : AssetImage(Assets.icons.vrcn.path)
                                  as ImageProvider,
                      child:
                          user.currentAvatarThumbnailImageUrl.isEmpty &&
                                  user.userIcon.isEmpty
                              ? Icon(
                                Icons.person,
                                size: 36,
                                color:
                                    isDarkMode
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                              )
                              : null,
                    ),
                  ),

                  // ステータスインジケーター
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color:
                            isDarkMode ? const Color(0xFF1F2A40) : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 3),

            // ユーザー情報
            Column(
              children: [
                // 表示名
                Text(
                  user.displayName,
                  style: GoogleFonts.notoSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 2),

                // 代名詞
                Text(
                  user.pronouns,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  // ユーザーID
                  // ignore: deprecated_member_use
                  '@${user.username}',
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),

                // ステータスメッセージ
                if (user.statusDescription.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isDarkMode
                              ? Colors.black.withValues(alpha: 0.2)
                              : Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      user.statusDescription,
                      style: GoogleFonts.notoSans(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
              isDarkMode
                  ? [const Color(0xFF2A3F54), const Color(0xFF1F2A40)]
                  : [
                    AppTheme.primaryColor.withValues(alpha: 0.15),
                    AppTheme.primaryColor.withValues(alpha: 0.05),
                  ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // カスタムローディングアニメーション
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode ? Colors.black12 : Colors.white38,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDarkMode ? Colors.white70 : AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                t.drawer.userLoading,
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red[400]!, Colors.red[700]!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // エラーアイコン（アニメーション風）
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                t.drawer.userError,
                style: GoogleFonts.notoSans(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // スタイリッシュなリトライボタン
              ElevatedButton.icon(
                onPressed: () {
                  final refreshedUser = ref.refresh(currentUserProvider);
                  refreshedUser.whenData((_) => {});
                },
                icon: const Icon(Icons.refresh_rounded),
                label: Text(t.drawer.retry, style: GoogleFonts.notoSans()),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red[700],
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // フッターセクションを修正
  Widget _buildFooterSection(bool isDarkMode) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.data?.version ?? '1.0.0';
        final buildNumber = snapshot.data?.buildNumber ?? '1';

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color:
                    isDarkMode
                        ? Colors.grey[800]!.withValues(alpha: .5)
                        : Colors.grey[300]!.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Image.asset(
                  Assets.images.sheIsWatchingYou.path,
                  width: 75,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            isDarkMode
                                ? Colors.grey[800]!.withValues(alpha: 0.3)
                                : Colors.grey[300]!.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 20,
                        color: isDarkMode ? Colors.grey[600] : Colors.grey[500],
                      ),
                    );
                  },
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          Assets.images.icon.path,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Center(
                      child: Text(
                        'Powered by null_base',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 14,
                          color:
                              isDarkMode ? Colors.grey[500] : Colors.grey[500],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'v$version ($buildNumber)',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode
                                    ? Colors.grey[500]
                                    : Colors.grey[500],
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// メニュー項目データクラス
@immutable
class _MenuItem {
  final IconData? icon;
  final String? imagePath;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _MenuItem({
    this.icon,
    this.imagePath,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
}
