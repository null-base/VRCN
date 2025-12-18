import 'package:cached_network_image/cached_network_image.dart';
import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/playermoderation_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/date_formatter.dart';
import 'package:vrchat/utils/status_helpers.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';
import 'package:vrchat/utils/user_type_helpers.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/info_card.dart';
import 'package:vrchat/widgets/info_row.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat/widgets/location_info_card.dart';
import 'package:vrchat/widgets/user_badges_view.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class FriendDetailPage extends ConsumerWidget {
  final String userId;

  const FriendDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendDetailAsync = ref.watch(userDetailProvider(userId));
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: friendDetailAsync.when(
        data: (user) => _buildUserDetail(context, user, ref, isDarkMode),
        loading: () => LoadingIndicator(message: t.friendDetail.loading),
        error:
            (error, stackTrace) => ErrorContainer(
              message: t.friendDetail.error(error: error.toString()),
              onRetry: () => ref.refresh(userDetailProvider(userId)),
            ),
      ),
    );
  }

  Widget _buildUserDetail(
    BuildContext context,
    User user,
    WidgetRef ref,
    bool isDarkMode,
  ) {
    // locationがオフラインの場合はグレー系のカラーを使用
    final Color statusColor;
    if (user.location == 'offline') {
      statusColor = isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400;
    } else {
      statusColor = StatusHelper.getStatusColor(user.status);
    }

    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    final userRepresentedGroupAsync = ref.watch(
      userRepresentedGroupProvider(user.id),
    );

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userDetailProvider(userId));
        if (user.worldId != null) {
          ref.invalidate(worldDetailProvider(user.worldId!));
        }
        if (user.worldId != null && user.instanceId != null) {
          ref.invalidate(
            instanceDetailWithParamsProvider(
              InstanceParams(
                worldId: user.worldId!,
                instanceId: user.instanceId!,
              ),
            ),
          );
        }
        ref.invalidate(userRepresentedGroupProvider(user.id));
      },
      color: statusColor,
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      strokeWidth: 2.5,
      displacement: 40,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor:
                isDarkMode
                    ? AppTheme.primaryColor.withValues(alpha: .8)
                    : AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  userRepresentedGroupAsync.when(
                    data: (group) {
                      if (group != null && group.bannerUrl != null) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: group.bannerUrl!,
                              fit: BoxFit.cover,
                              httpHeaders: headers,
                              cacheManager: JsonCacheManager(),
                              placeholder:
                                  (context, url) =>
                                      Container(color: AppTheme.primaryColor),
                              errorWidget:
                                  (context, url, error) =>
                                      Container(color: AppTheme.primaryColor),
                            ),
                            Container(
                              color: Colors.black.withValues(alpha: 0.2),
                            ),
                            Positioned(
                              left: 16,
                              bottom: 16,
                              child: _buildUserTypeContainer(user, isDarkMode),
                            ),
                            if (user.badges != null && user.badges!.isNotEmpty)
                              Positioned(
                                right: 16,
                                bottom: 16,
                                child: UserBadgesView(
                                  user: user,
                                  isDarkMode: isDarkMode,
                                ),
                              ),
                          ],
                        );
                      } else {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            _buildGradientBackground(statusColor),
                            Positioned(
                              left: 16,
                              bottom: 16,
                              child: _buildUserTypeContainer(user, isDarkMode),
                            ),
                            if (user.badges != null && user.badges!.isNotEmpty)
                              Positioned(
                                right: 16,
                                bottom: 16,
                                child: UserBadgesView(
                                  user: user,
                                  isDarkMode: isDarkMode,
                                ),
                              ),
                          ],
                        );
                      }
                    },
                    loading:
                        () => Stack(
                          fit: StackFit.expand,
                          children: [
                            _buildGradientBackground(statusColor),
                            Positioned(
                              left: 16,
                              bottom: 16,
                              child: _buildUserTypeContainer(user, isDarkMode),
                            ),
                          ],
                        ),
                    error:
                        (_, _) => Stack(
                          fit: StackFit.expand,
                          children: [
                            _buildGradientBackground(statusColor),
                            Positioned(
                              left: 16,
                              bottom: 16,
                              child: _buildUserTypeContainer(user, isDarkMode),
                            ),
                          ],
                        ),
                  ),
                  _buildUserHeader(user, statusColor, ref),
                ],
              ),
            ),
            actions: [_buildModerationMenu(context, ref, user, isDarkMode)],
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  if (user.location != 'offline' && user.location != null)
                    InfoCard(
                      title: t.friendDetail.currentLocation,
                      icon: Icons.location_on_outlined,
                      isDarkMode: isDarkMode,
                      customColor: Colors.green,
                      children: [
                        LocationInfoCard(user: user, isDarkMode: isDarkMode),
                      ],
                    ),
                  const SizedBox(height: 24),
                  InfoCard(
                    title: t.friendDetail.basicInfo,
                    icon: Icons.person_outline,
                    isDarkMode: isDarkMode,
                    children: [
                      InfoRow(
                        icon: Icons.badge,
                        label: t.friendDetail.userId,
                        value: user.id,
                        isDarkMode: isDarkMode,
                      ),
                      InfoRow(
                        icon: Icons.calendar_today,
                        label: t.friendDetail.dateJoined,
                        value:
                            user.dateJoined !=
                                    DateTime.fromMillisecondsSinceEpoch(0)
                                ? DateFormatter.formatDate(user.dateJoined)
                                : t.friendDetail.unknownGroup,
                        isDarkMode: isDarkMode,
                      ),
                      InfoRow(
                        icon: Icons.timer,
                        label: t.friendDetail.lastLogin,
                        value: DateFormatter.formatDate(user.lastLogin),
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildUserBioCard(user, isDarkMode),
                  const SizedBox(height: 16),
                  if (user.bioLinks.isNotEmpty)
                    _buildBioLinksCard(context, user.bioLinks, isDarkMode),
                  const SizedBox(height: 16),
                  _buildUserGroupCard(
                    context,
                    user,
                    userRepresentedGroupAsync,
                    headers,
                    isDarkMode,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTypeContainer(User user, bool isDarkMode) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ユーザータイプを表示
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: UserTypeHelper.getUserTypeColor(user.tags),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                UserTypeHelper.getUserTypeText(user.tags),
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        // プラットフォーム表示
        if (_getUserPlatform(user.lastPlatform) != null)
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _getPlatformColor(_getUserPlatform(user.lastPlatform)),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 2),
                Text(
                  _getUserPlatform(user.lastPlatform).toString(),
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

        // 18+
        if (user.ageVerified)
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF596bdb), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 2),
                Text(
                  '18+',
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // プラットフォーム情報取得
  String? _getUserPlatform(String? lastPlatform) {
    if (lastPlatform == null) return null;

    switch (lastPlatform) {
      case 'standalonewindows':
        return 'PC';
      case 'android':
        return 'Android';
      case 'ios':
        return 'iOS';
      default:
        return null;
    }
  }

  // プラットフォームに対応する色を取得
  Color _getPlatformColor(String? platform) {
    switch (platform) {
      case 'PC':
        return Colors.blue;
      case 'Android':
        return Colors.green;
      case 'iOS':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Widget _buildUserHeader(User user, Color statusColor, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: statusColor, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipOval(child: _buildUserAvatar(user, ref)),
        ),
        const SizedBox(height: 16),
        Text(
          user.displayName,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              const Shadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        // Pronouns表示を追加
        if (user.pronouns.isNotEmpty) ...[
          const SizedBox(height: 8),
          _buildPronouns(user.pronouns, statusColor),
        ],
        const SizedBox(height: 8),
        if (user.statusDescription.isNotEmpty)
          _buildStatusDescription(user, statusColor),
      ],
    );
  }

  Widget _buildUserAvatar(User user, WidgetRef ref) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    if (user.userIcon.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: user.userIcon,
        fit: BoxFit.cover,
        httpHeaders: headers,
        cacheManager: JsonCacheManager(),
        placeholder: (context, url) => Container(color: Colors.grey[300]),
        errorWidget:
            (context, url, error) =>
                const Icon(Icons.person, size: 80, color: Colors.white70),
      );
    } else if (user.currentAvatarThumbnailImageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: user.currentAvatarThumbnailImageUrl,
        fit: BoxFit.cover,
        httpHeaders: headers,
        cacheManager: JsonCacheManager(),
        placeholder: (context, url) => Container(color: Colors.grey[300]),
        errorWidget:
            (context, url, error) =>
                const Icon(Icons.person, size: 80, color: Colors.white70),
      );
    } else {
      return Container(
        color: Colors.grey[800],
        child: const Icon(Icons.person, size: 80, color: Colors.white70),
      );
    }
  }

  Widget _buildStatusDescription(User user, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            user.statusDescription,
            style: GoogleFonts.notoSans(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserBioCard(User user, bool isDarkMode) {
    if (user.bio.isEmpty) return const SizedBox.shrink();

    return InfoCard(
      title: t.friendDetail.bio,
      icon: Icons.info_outline,
      isDarkMode: isDarkMode,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            ),
          ),
          child: SelectionArea(
            child: Text(
              user.bio,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
              ),
            ),
          ),
        ),
      ],
    );
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
          title: t.friendDetail.links,
          icon: Icons.link,
          isDarkMode: isDarkMode,
          customColor: Colors.teal,
          children:
              linkData.isEmpty
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
              child:
                  faviconUrl != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          faviconUrl,
                          width: 16,
                          height: 16,
                          errorBuilder:
                              (context, error, stackTrace) => Icon(
                                Icons.language,
                                size: 16,
                                color:
                                    isDarkMode
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
            t.friendDetail.loadingLinks,
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
    var processedUrl = url.replaceAll(RegExp(r'https?://'), '');
    processedUrl = processedUrl.split('/')[0];
    processedUrl = processedUrl.split('?')[0].split('#')[0];
    return processedUrl;
  }

  String _truncateUrl(String url) {
    const maxLength = 40;
    return url.length > maxLength ? '${url.substring(0, maxLength)}...' : url;
  }

  Widget _buildUserGroupCard(
    BuildContext context,
    User user,
    AsyncValue<RepresentedGroup?> userGroupAsync,
    Map<String, String> headers,
    bool isDarkMode,
  ) {
    return userGroupAsync.when(
      data: (group) {
        if (group?.groupId != null) {
          return InfoCard(
            title: t.friendDetail.group,
            icon: Icons.group_outlined,
            isDarkMode: isDarkMode,
            customColor: Colors.indigo,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (group?.iconUrl != null)
                    Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isDarkMode
                                  ? Colors.grey[700]!
                                  : Colors.grey[300]!,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: group!.iconUrl!,
                          httpHeaders: headers,
                          cacheManager: JsonCacheManager(),
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Container(
                                color:
                                    isDarkMode
                                        ? Colors.grey[800]
                                        : Colors.grey[200],
                                child: Icon(
                                  Icons.group,
                                  color:
                                      isDarkMode
                                          ? Colors.grey[600]
                                          : Colors.grey[400],
                                  size: 30,
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color:
                                    isDarkMode
                                        ? Colors.grey[800]
                                        : Colors.grey[200],
                                child: Icon(
                                  Icons.group,
                                  color:
                                      isDarkMode
                                          ? Colors.grey[600]
                                          : Colors.grey[400],
                                  size: 30,
                                ),
                              ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group?.name ?? t.friendDetail.unknownGroup,
                          style: GoogleFonts.notoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (group?.shortCode != null) ...[
                          Text(
                            t.friendDetail.groupCode(code: group!.shortCode!),
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color:
                                  isDarkMode
                                      ? Colors.grey[300]
                                      : Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                        if (group?.memberCount != null)
                          Text(
                            t.friendDetail.memberCount(
                              count: group!.memberCount.toString(),
                            ),
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color:
                                  isDarkMode
                                      ? Colors.grey[300]
                                      : Colors.grey[700],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  context.push('/group/${group?.groupId}');
                },
                icon: const Icon(Icons.visibility_outlined),
                label: Text(
                  t.friendDetail.groupDetail,
                  style: GoogleFonts.notoSans(),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  side: const BorderSide(color: Colors.indigo),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      loading:
          () => const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildGradientBackground(Color statusColor) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            statusColor.withValues(alpha: 0.7),
            AppTheme.primaryColor.withValues(alpha: 0.9),
          ],
        ),
      ),
    );
  }

  Widget _buildModerationMenu(
    BuildContext context,
    WidgetRef ref,
    User user,
    bool isDarkMode,
  ) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      onSelected: (value) async {
        switch (value) {
          case 'block':
            _showModerationConfirmDialog(
              context,
              ref,
              t.friendDetail.confirmBlockTitle(name: user.displayName),
              t.friendDetail.confirmBlockMessage,
              () => _moderateUser(
                ref,
                PlayerModerationUtil.blockUser(user.id),
                t.friendDetail.blockSuccess,
              ),
              isDarkMode,
            );
          case 'mute':
            _showModerationConfirmDialog(
              context,
              ref,
              t.friendDetail.confirmMuteTitle(name: user.displayName),
              t.friendDetail.confirmMuteMessage,
              () => _moderateUser(
                ref,
                PlayerModerationUtil.muteUser(user.id),
                t.friendDetail.muteSuccess,
              ),
              isDarkMode,
            );
          case 'website':
            await _openUserWebsite(user.id);
          case 'share':
            await _shareUserProfile(user);
        }
      },
      itemBuilder:
          (context) => [
            _buildPopupMenuItem(
              'block',
              t.friendDetail.block,
              Icons.block,
              isDarkMode,
            ),
            _buildPopupMenuItem(
              'mute',
              t.friendDetail.mute,
              Icons.volume_off,
              isDarkMode,
            ),
            _buildPopupMenuItem(
              'website',
              t.friendDetail.openWebsite,
              Icons.public,
              isDarkMode,
            ),
            _buildPopupMenuItem(
              'share',
              t.friendDetail.shareProfile,
              Icons.share_outlined,
              isDarkMode,
            ),
          ],
    );
  }

  // ポップアップメニュー項目を構築するヘルパーメソッド
  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    String text,
    IconData icon,
    bool isDarkMode,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.notoSans(
              color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  // モデレーション確認ダイアログを表示するメソッド
  void _showModerationConfirmDialog(
    BuildContext context,
    WidgetRef ref,
    String title,
    String message,
    Function() onConfirm,
    bool isDarkMode,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title, style: GoogleFonts.notoSans()),
            content: Text(message, style: GoogleFonts.notoSans()),
            backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  t.common.cancel,
                  style: GoogleFonts.notoSans(
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(t.common.confirm, style: GoogleFonts.notoSans()),
              ),
            ],
          ),
    );
  }

  // ユーザーモデレーションを実行するメソッド
  Future<void> _moderateUser(
    WidgetRef ref,
    ModerateUserRequest request,
    String successMessage,
  ) async {
    try {
      await ref.read(moderateUserProvider(request).future);
      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text(successMessage),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green[700],
          ),
        );
      }
    } catch (e) {
      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text(t.friendDetail.operationFailed(error: e.toString())),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red[700],
          ),
        );
      }
    }
  }

  // ユーザーのVRChatウェブサイトページを開くメソッド
  Future<void> _openUserWebsite(String userId) async {
    final url = Uri.parse('https://vrchat.com/home/user/$userId');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('URLを開けませんでした: $url');
      // refコンテキストの代わりに現在のBuildContextを使用
    }
  }

  // ユーザーのプロフィールを共有するメソッド
  Future<void> _shareUserProfile(User user) async {
    final url = 'https://vrchat.com/home/user/${user.id}';

    try {
      await SharePlus.instance.share(
        ShareParams(uri: Uri.parse(url), title: user.displayName),
      );
    } catch (e) {
      debugPrint('共有に失敗しました: $e');
    }
  }
}

// Pronouns表示用のウィジェット
Widget _buildPronouns(String pronouns, Color statusColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.black26,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.purple.shade300, width: 1.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          pronouns,
          style: GoogleFonts.notoSans(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
