import 'package:cached_network_image/cached_network_image.dart';
import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/avatar_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/status_helpers.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';
import 'package:vrchat/utils/user_type_helpers.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/info_card.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/profile_edit_sheet.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with SingleTickerProviderStateMixin {
  Key _refreshKey = UniqueKey();
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _refreshProfile() async {
    setState(() {
      _refreshKey = UniqueKey();
    });

    // プロバイダの再取得を実行
    ref.invalidate(currentUserProvider);

    // アニメーションをリセットして再生
    _animationController.reset();
    await _animationController.forward();

    // 明示的に新しいデータを待機
    await ref.read(currentUserProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Scaffold(
      key: _refreshKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_2_outlined),
            onPressed: () => context.push('/engage_card'),
            tooltip: t.profile.engageCard,
          ),
          currentUserAsync.when(
            data: (user) => IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () async {
                ref.invalidate(currentUserProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.profile.loading),
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                }
                final updatedUser = await ref.read(
                  currentUserProvider.future,
                );
                if (!context.mounted) return;
                final result = await showModalBottomSheet<bool>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return ProfileEditSheet(user: updatedUser);
                  },
                );
                if (result == true && context.mounted) {
                  await _refreshProfile();
                }
              },
              tooltip: t.profile.edit,
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: currentUserAsync.when(
        data: (user) => FadeTransition(
          opacity: _fadeInAnimation,
          child: _buildProfileContent(
            context,
            ref,
            user,
            headers,
            isDarkMode,
          ),
        ),
        loading: () => LoadingIndicator(message: t.profile.loading),
        error: (error, stackTrace) => ErrorContainer(
          message: t.profile.error.replaceFirst(
            '{error}',
            error.toString(),
          ),
          onRetry: _refreshProfile,
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    WidgetRef ref,
    CurrentUser user,
    Map<String, String> headers,
    bool isDarkMode,
  ) {
    final statusColor = StatusHelper.getStatusColor(user.status);
    final userRepresentedGroupAsync = ref.watch(
      userRepresentedGroupProvider(user.id),
    );

    // 現在使用中のアバター情報
    final ownAvatarAsync = ref.watch(ownAvatarProvider(user.id));

    // アクセントカラーの設定
    const accentColor = AppTheme.primaryColor;
    final secondaryColor = isDarkMode
        ? HSLColor.fromColor(accentColor).withLightness(0.4).toColor()
        : HSLColor.fromColor(accentColor).withLightness(0.6).toColor();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ヘッダー部分
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // ヘッダー背景
              Container(
                height: 260,
                decoration: BoxDecoration(
                  gradient: userRepresentedGroupAsync.value?.bannerUrl == null
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [accentColor, secondaryColor],
                        )
                      : null,
                ),
                child: Stack(
                  children: [
                    if (userRepresentedGroupAsync.value?.bannerUrl != null)
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: userRepresentedGroupAsync.value!.bannerUrl!,
                          httpHeaders: headers,
                          cacheManager: JsonCacheManager(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [accentColor, secondaryColor],
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [accentColor, secondaryColor],
                              ),
                            ),
                          ),
                        ),
                      ),

                    // オーバーレイグラデーション
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.1),
                              Colors.black.withValues(alpha: 0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // プロフィールカード
              Positioned(
                bottom: -60,
                left: 20,
                right: 20,
                child: Container(
                  height: 125,
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 120),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.displayName,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.2,
                                  height: 1.1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                // ignore: deprecated_member_use
                                '@${user.username}',
                                style: GoogleFonts.notoSans(
                                  fontSize: 14,
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          statusColor.withValues(alpha: 0.2),
                                          statusColor.withValues(alpha: 0.1),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: statusColor.withValues(
                                            alpha: 0.2,
                                          ),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: statusColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: statusColor.withValues(
                                                  alpha: 0.5,
                                                ),
                                                blurRadius: 6,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          StatusHelper.getStatusText(
                                            user.status,
                                          ),
                                          style: GoogleFonts.notoSans(
                                            fontSize: 12,
                                            color: statusColor,
                                            fontWeight: FontWeight.w600,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // アバター画像
              Positioned(
                bottom: 0,
                left: 40,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  tween: Tween<double>(begin: 0.8, end: 1),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDarkMode
                                ? const Color(0xFF1E1E1E)
                                : Colors.white,
                            width: 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ownAvatarAsync.when(
                          data: (avatar) => GestureDetector(
                            onTap: () {
                              // アバター詳細ページに遷移
                              if (avatar.id.isNotEmpty) {
                                context.push('/avatar/${avatar.id}');
                              }
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: user.userIcon.isNotEmpty
                                  ? CachedNetworkImageProvider(
                                      user.userIcon,
                                      headers: headers,
                                      cacheManager: JsonCacheManager(),
                                    )
                                  : user
                                        .currentAvatarThumbnailImageUrl
                                        .isNotEmpty
                                  ? CachedNetworkImageProvider(
                                      user.currentAvatarThumbnailImageUrl,
                                      headers: headers,
                                      cacheManager: JsonCacheManager(),
                                    )
                                  : AssetImage(Assets.icons.icon.path)
                                        as ImageProvider,
                              child: user.currentAvatarThumbnailImageUrl.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Colors.white70,
                                    )
                                  : null,
                            ),
                          ),

                          loading: () => CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryColor,
                              ),
                            ),
                          ),
                          error: (_, _) => CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                                user.currentAvatarThumbnailImageUrl.isNotEmpty
                                ? CachedNetworkImageProvider(
                                    user.currentAvatarThumbnailImageUrl,
                                    headers: headers,
                                    cacheManager: JsonCacheManager(),
                                  )
                                : AssetImage(Assets.icons.icon.path)
                                      as ImageProvider,
                            child: user.currentAvatarThumbnailImageUrl.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.white70,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // プロフィール情報
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 統計情報カード
                _buildStatsCard(context, user, isDarkMode),

                const SizedBox(height: 24),

                // 基本情報セクション
                _buildModernInfoCard(
                  context: context,
                  title: t.profile.title,
                  icon: Icons.person_outline,
                  backgroundColor: isDarkMode
                      ? HSLColor.fromColor(
                          AppTheme.primaryColor,
                        ).withLightness(0.15).toColor()
                      : HSLColor.fromColor(
                          AppTheme.primaryColor,
                        ).withLightness(0.95).toColor(),
                  iconColor: AppTheme.primaryColor,
                  isDarkMode: isDarkMode,
                  children: [
                    _buildModernInfoRow(
                      icon: Icons.badge,
                      label: t.profile.userId,
                      value: user.id,
                      isDarkMode: isDarkMode,
                      iconColor: AppTheme.primaryColor,
                    ),
                    _buildModernInfoRow(
                      icon: Icons.calendar_today,
                      label: t.profile.dateJoined,
                      value:
                          user.dateJoined !=
                              DateTime.fromMillisecondsSinceEpoch(0)
                          ? _formatDate(user.dateJoined)
                          : t.profile.unknown,
                      isDarkMode: isDarkMode,
                      iconColor: AppTheme.primaryColor,
                    ),
                    _buildModernInfoRow(
                      icon: Icons.verified_user,
                      label: t.profile.userType,
                      value: UserTypeHelper.getUserTypeText(user.tags),
                      isDarkMode: isDarkMode,
                      iconColor: AppTheme.primaryColor,
                      isLast: true,
                    ),
                  ],
                ),

                // 現在のアバター
                const SizedBox(height: 24),
                ownAvatarAsync.when(
                  data: (avatar) => _buildAvatarCard(
                    context: context,
                    avatar: avatar,
                    headers: headers,
                    isDarkMode: isDarkMode,
                    accentColor: Colors.purple,
                  ),
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  error: (_, _) => const SizedBox.shrink(),
                ),

                // ステータスメッセージ
                if (user.statusDescription.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildModernInfoCard(
                    context: context,
                    title: t.profile.statusMessage,
                    icon: Icons.message_outlined,
                    backgroundColor: isDarkMode
                        ? HSLColor.fromColor(
                            Colors.teal,
                          ).withLightness(0.15).toColor()
                        : HSLColor.fromColor(
                            Colors.teal,
                          ).withLightness(0.95).toColor(),
                    iconColor: Colors.teal,
                    isDarkMode: isDarkMode,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.teal.withValues(alpha: 0.1)
                              : Colors.teal.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.teal.withValues(
                              alpha: isDarkMode ? 0.2 : 0.1,
                            ),
                          ),
                        ),
                        child: Text(
                          user.statusDescription,
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                            height: 1.5,
                            color: isDarkMode
                                ? Colors.teal.withValues(alpha: 0.9)
                                : Colors.teal.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                // 自己紹介（存在する場合）
                if (user.bio.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildModernInfoCard(
                    context: context,
                    title: t.profile.bio,
                    icon: Icons.info_outline,
                    backgroundColor: isDarkMode
                        ? HSLColor.fromColor(
                            Colors.blue,
                          ).withLightness(0.15).toColor()
                        : HSLColor.fromColor(
                            Colors.blue,
                          ).withLightness(0.95).toColor(),
                    iconColor: Colors.blue,
                    isDarkMode: isDarkMode,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.blue.withValues(alpha: 0.1)
                              : Colors.blue.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.blue.withValues(
                              alpha: isDarkMode ? 0.2 : 0.1,
                            ),
                          ),
                        ),
                        child: Text(
                          user.bio,
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                            height: 1.5,
                            color: isDarkMode
                                ? Colors.blue.withValues(alpha: 0.9)
                                : Colors.blue.withValues(alpha: .8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                // リンク
                if (user.bioLinks.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildBioLinksCard(context, user.bioLinks, isDarkMode),
                ],

                // グループ情報
                userRepresentedGroupAsync.when(
                  data: (group) {
                    if (group != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          _buildModernGroupCard(
                            context,
                            group,
                            headers,
                            isDarkMode,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  error: (_, _) => const SizedBox.shrink(),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernGroupCard(
    BuildContext context,
    RepresentedGroup group,
    Map<String, String> headers,
    bool isDarkMode,
  ) {
    const accentColor = Colors.indigo;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: accentColor.withValues(alpha: isDarkMode ? 0.2 : 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          // ヘッダー
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accentColor.withValues(alpha: isDarkMode ? 0.15 : 0.1),
                  accentColor.withValues(alpha: isDarkMode ? 0.05 : 0.05),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.group_outlined,
                    color: accentColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    t.profile.group,
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // コンテンツ
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // グループアイコン（ある場合）
                if (group.iconUrl != null)
                  Container(
                    width: 70,
                    height: 70,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: group.iconUrl!,
                        httpHeaders: headers,
                        cacheManager: JsonCacheManager(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.group,
                              color: isDarkMode
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                              size: 30,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.group,
                              color: isDarkMode
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // グループ詳細情報
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // グループ名
                      Text(
                        group.name ?? t.groups.unknownName,
                        style: GoogleFonts.notoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // グループコード（短縮コード）
                      if (group.shortCode != null) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.tag,
                              size: 14,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              group.shortCode!,
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[700],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],

                      // メンバー数（APIが提供していれば）
                      if (group.memberCount != null)
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 14,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              t.groups.members(
                                count: group.memberCount.toString(),
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
                ),
              ],
            ),
          ),

          // グループ詳細ボタン
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton.icon(
              onPressed: () {
                context.push('/group/${group.groupId}');
              },
              icon: const Icon(Icons.visibility_outlined, size: 18),
              label: Text(t.profile.groupDetail),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: accentColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                shadowColor: accentColor.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarCard({
    required BuildContext context,
    required Avatar avatar,
    required Map<String, String> headers,
    required bool isDarkMode,
    required Color accentColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: accentColor.withValues(alpha: isDarkMode ? 0.2 : 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          // ヘッダー
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accentColor.withValues(alpha: isDarkMode ? 0.15 : 0.1),
                  accentColor.withValues(alpha: isDarkMode ? 0.05 : 0.05),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(Icons.face, color: accentColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    t.profile.avatar,
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // コンテンツ
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // アバターサムネイル
                Container(
                  width: 90,
                  height: 90,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: avatar.imageUrl,
                      httpHeaders: headers,
                      cacheManager: JsonCacheManager(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        child: Icon(
                          Icons.broken_image,
                          color: isDarkMode
                              ? Colors.grey[600]
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),

                // アバター情報
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        avatar.name,
                        style: GoogleFonts.notoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 14,
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            avatar.authorName,
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: isDarkMode
                                  ? Colors.grey[300]
                                  : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getReleaseStatusColor(avatar.releaseStatus),
                              _getReleaseStatusColor(
                                avatar.releaseStatus,
                              ).withValues(alpha: 0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getReleaseStatusText(avatar.releaseStatus),
                          style: GoogleFonts.notoSans(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // アバター詳細ボタン
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton.icon(
              onPressed: () {
                context.push('/avatar/${avatar.id}');
              },
              icon: const Icon(Icons.visibility_outlined, size: 18),
              label: Text(t.profile.avatarDetail),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: accentColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                shadowColor: accentColor.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 統計情報カード
  Widget _buildStatsCard(
    BuildContext context,
    CurrentUser user,
    bool isDarkMode,
  ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0.95, end: 1),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: AppTheme.primaryColor.withValues(
                  alpha: isDarkMode ? 0.2 : 0.1,
                ),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.people_alt_rounded,
                  value: user.friends.length.toString(),
                  label: t.profile.frined,
                  isDarkMode: isDarkMode,
                ),
                // 追加の統計情報をここに追加可能
              ],
            ),
          ),
        );
      },
    );
  }

  // 統計アイテム
  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required bool isDarkMode,
  }) {
    return TweenAnimationBuilder<int>(
      duration: const Duration(milliseconds: 1500),
      tween: IntTween(begin: 0, end: int.parse(value)),
      builder: (context, animatedValue, child) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor.withValues(alpha: 0.2),
                    AppTheme.primaryColor.withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.15),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(icon, color: AppTheme.primaryColor, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              animatedValue.toString(),
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.notoSans(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
          ],
        );
      },
    );
  }

  // モダンな情報カード
  Widget _buildModernInfoCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
    required bool isDarkMode,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: iconColor.withValues(alpha: isDarkMode ? 0.2 : 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // カードヘッダー
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withValues(alpha: 0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // カードコンテンツ
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  // モダンな情報行アイテム
  Widget _buildModernInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isDarkMode,
    required Color iconColor,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0.0 : 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 日付フォーマット
  String _formatDate(DateTime? date) {
    if (date == null) return '不明';
    return '${date.year}/${date.month}/${date.day}';
  }

  // リリースステータスの色
  Color _getReleaseStatusColor(ReleaseStatus status) {
    switch (status) {
      case ReleaseStatus.public:
        return Colors.green;
      case ReleaseStatus.private:
        return Colors.orange;
      case ReleaseStatus.hidden:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // リリースステータスのテキスト
  String _getReleaseStatusText(ReleaseStatus status) {
    switch (status) {
      case ReleaseStatus.public:
        return t.profile.public;
      case ReleaseStatus.private:
        return t.profile.private;
      case ReleaseStatus.hidden:
        return t.profile.hidden;
      default:
        return t.profile.unknown;
    }
  }

  Widget _buildBioLinksCard(
    BuildContext context,
    List<String> bioLinks,
    bool isDarkMode,
  ) {
    return FutureBuilder(
      future: Future.wait(
        bioLinks.map((link) async {
          try {
            final uri = Uri.parse(_ensureHttpPrefix(link));

            // ファビコン取得を強化
            Favicon? favicon;
            try {
              favicon = await FaviconFinder.getBest(link);
            } catch (e) {
              // ファビコンが取得できなくても代替手段があるので無視
            }

            String? faviconUrl;
            if (favicon != null && favicon.url.isNotEmpty) {
              faviconUrl = favicon.url;
            } else {
              faviconUrl = '${uri.scheme}://${uri.host}/favicon.ico';
            }

            return {'url': link, 'favicon': faviconUrl, 'domain': uri.host};
          } catch (e) {
            return {
              'url': link,
              'favicon': null,
              'domain': _extractDomain(link),
            };
          }
        }).toList(),
      ),
      builder: (context, snapshot) {
        final linkData = snapshot.data as List<Map<String, dynamic>>? ?? [];

        return InfoCard(
          title: t.profile.links,
          icon: Icons.link,
          isDarkMode: isDarkMode,
          customColor: Colors.teal,
          children: linkData.isEmpty
              ? [_buildLoadingLinksIndicator(isDarkMode)]
              : linkData
                    .map((data) => _buildLinkItem(context, data, isDarkMode))
                    .toList(),
        );
      },
    );
  }

  Widget _buildLinkItem(
    BuildContext context,
    Map<String, dynamic> linkData,
    bool isDarkMode,
  ) {
    final url = linkData['url'] as String;
    final faviconUrl = linkData['favicon'] as String?;
    final domain = linkData['domain'] as String;

    return InkWell(
      onTap: () => UrlLauncherUtils.launchURL(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: faviconUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: faviconUrl,
                        cacheManager: JsonCacheManager(),
                        width: 16,
                        height: 16,
                        fit: BoxFit.contain,
                        errorWidget: (context, error, stackTrace) => Icon(
                          Icons.language,
                          size: 16,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                      ),
                    )
                  : Icon(
                      Icons.language,
                      size: 16,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    domain,
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    _truncateUrl(url),
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              size: 18,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingLinksIndicator(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
            color: isDarkMode ? Colors.teal[300] : Colors.teal,
          ),
          const SizedBox(height: 12),
          Text(
            t.profile.loadingLinks,
            style: GoogleFonts.notoSans(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _ensureHttpPrefix(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    return 'https://$url';
  }

  String _extractDomain(String url) {
    var processedUrl = url.replaceAll(RegExp('https?://'), '');
    processedUrl = processedUrl.split('/')[0];
    processedUrl = processedUrl.split('?')[0].split('#')[0];
    return processedUrl;
  }

  String _truncateUrl(String url) {
    const maxLength = 40;
    return url.length > maxLength ? '${url.substring(0, maxLength)}...' : url;
  }
}
