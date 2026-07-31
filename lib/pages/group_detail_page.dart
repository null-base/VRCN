import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/controllers/group_detail_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/group_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/info_card.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class GroupDetailPage extends ConsumerWidget {
  const GroupDetailPage({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupDetailAsync = ref.watch(
      groupDetailProvider(
        GroupDetailParams(groupId: groupId, includeRoles: true),
      ),
    );
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: groupDetailAsync.when(
        data: (group) => _buildGroupDetail(context, group, ref, isDarkMode),
        loading: () => LoadingIndicator(message: t.groupDetail.loading),
        error: (error, stackTrace) => ErrorContainer(
          message: t.groupDetail.error(error: error.toString()),
          onRetry: () =>
              ref.read(groupDetailControllerProvider).refresh(groupId),
        ),
      ),
    );
  }

  Widget _buildGroupDetail(
    BuildContext context,
    Group group,
    WidgetRef ref,
    bool isDarkMode,
  ) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return RefreshIndicator(
      onRefresh: () => ref.read(groupDetailControllerProvider).refresh(groupId),
      color: Colors.indigo,
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // ヘッダー
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            stretch: true,
            backgroundColor: isDarkMode
                ? Colors.indigo.withValues(alpha: .8)
                : Colors.indigo,
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                tooltip: t.groupDetail.share,
                onPressed: () =>
                    ref.read(groupDetailControllerProvider).shareGroup(group),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (group.bannerUrl != null)
                    CachedNetworkImage(
                      imageUrl: group.bannerUrl!,
                      fit: BoxFit.cover,
                      httpHeaders: headers,
                      cacheManager: JsonCacheManager(),
                      placeholder: (context, url) => const ColoredBox(
                        color: Colors.indigo,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const ColoredBox(
                        color: Colors.indigo,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Container(color: Colors.black.withValues(alpha: 0.3)),
                ],
              ),
              title: Text(
                group.name.toString(),
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    const Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
              centerTitle: false,
            ),
          ),

          // グループアイコンとメンバー数
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  // グループアイコン
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.grey[700]!
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: group.iconUrl != null
                          ? CachedNetworkImage(
                              imageUrl: group.iconUrl!,
                              fit: BoxFit.cover,
                              httpHeaders: headers,
                              cacheManager: JsonCacheManager(),
                              placeholder: (context, url) => Container(
                                color: isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                                child: const Icon(
                                  Icons.group,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                                child: const Icon(
                                  Icons.group,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ),
                            )
                          : Container(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              child: const Icon(
                                Icons.group,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // グループ情報（名前、メンバー数、タイプ）
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.name.toString(),
                          style: GoogleFonts.notoSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        if (group.shortCode != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            '@${group.shortCode}',
                            style: GoogleFonts.notoSans(
                              fontSize: 16,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                        ],

                        // メンバー数
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: _getGroupPrivacyColor(
                                  group.privacy.toString(),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _getGroupPrivacyText(group.privacy.toString()),
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.people,
                              size: 16,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              t.groupDetail.memberCount(
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
                  ),
                ],
              ),
            ),
          ),

          // グループ説明
          if (group.description != null && group.description!.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: InfoCard(
                  title: t.groupDetail.description,
                  icon: Icons.description_outlined,
                  isDarkMode: isDarkMode,
                  customColor: Colors.indigo,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        group.description!,
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: isDarkMode
                              ? Colors.grey[300]
                              : Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // グループロール情報
          if (group.roles != null && group.roles!.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: InfoCard(
                  title: t.groupDetail.roles,
                  icon: Icons.badge_outlined,
                  isDarkMode: isDarkMode,
                  customColor: Colors.orange,
                  children: [
                    ...group.roles!.map(
                      (role) => _buildRoleItem(role, isDarkMode),
                    ),
                  ],
                ),
              ),
            ),

          // グループ情報
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
              child: InfoCard(
                title: t.groupDetail.basicInfo,
                icon: Icons.info_outline,
                isDarkMode: isDarkMode,
                children: [
                  // 作成日時
                  _buildInfoRow(
                    icon: Icons.calendar_today,
                    label: t.groupDetail.createdAt,
                    value: _formatDate(group.createdAt),
                    isDarkMode: isDarkMode,
                  ),

                  // オーナー
                  if (group.ownerId != null)
                    _buildInfoRow(
                      icon: Icons.person,
                      label: t.groupDetail.owner,
                      value: group.ownerId!,
                      isDarkMode: isDarkMode,
                    ),

                  // ルールなど
                  if (group.rules != null && group.rules!.isNotEmpty)
                    _buildInfoRow(
                      icon: Icons.gavel,
                      label: t.groupDetail.rules,
                      value: group.rules!,
                      isDarkMode: isDarkMode,
                    ),

                  // 言語
                  if (group.languages != null && group.languages!.isNotEmpty)
                    _buildInfoRow(
                      icon: Icons.language,
                      label: t.groupDetail.languages,
                      value: group.languages!.join(', '),
                      isDarkMode: isDarkMode,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ロールアイテムウィジェット
  Widget _buildRoleItem(GroupRole role, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: _getRoleColor(role.id),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  role.name ?? t.groupDetail.role.unknown,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (role.isManagementRole == true)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    t.groupDetail.role.admin,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          if (role.description != null && role.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              role.description!,
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 情報行アイテム
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isDarkMode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
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
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // グループタイプに応じたテキストを返す
  String _getGroupPrivacyText(String? privacy) {
    switch (privacy?.toLowerCase()) {
      case 'default':
        return t.groupDetail.privacy.public;
      case 'private':
        return t.groupDetail.privacy.private;
      case 'friends':
        return t.groupDetail.privacy.friends;
      case 'invite':
      case 'invite+':
        return t.groupDetail.privacy.invite;
      default:
        return t.groupDetail.privacy.unknown;
    }
  }

  // グループタイプに応じた色を返す
  Color _getGroupPrivacyColor(String? privacy) {
    switch (privacy?.toLowerCase()) {
      case 'default':
        return Colors.green[600]!;
      case 'private':
        return Colors.red[600]!;
      case 'friends':
        return Colors.blue[600]!;
      case 'invite':
      case 'invite+':
        return Colors.orange[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  // ロールに応じた色を返す
  Color _getRoleColor(String? roleId) {
    switch (roleId) {
      case 'admin':
        return Colors.red[600]!;
      case 'moderator':
        return Colors.orange[600]!;
      case 'member':
        return Colors.teal[600]!;
      default:
        return Colors.blue[600]!;
    }
  }

  // 日付フォーマット
  String _formatDate(DateTime? date) {
    if (date == null) return t.groupDetail.privacy.unknown;

    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year年$month月$day日';
  }
}
