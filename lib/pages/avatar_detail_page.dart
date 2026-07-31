import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/controllers/avatar_detail_controller.dart';
import 'package:vrchat/controllers/favorite_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/avatar_provider.dart';
import 'package:vrchat/provider/favorite_provider.dart' as favorites;
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/release_status_utils.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class AvatarDetailPage extends ConsumerStatefulWidget {
  const AvatarDetailPage({super.key, required this.avatarId});
  final String avatarId;

  @override
  ConsumerState<AvatarDetailPage> createState() => _AvatarDetailPageState();
}

class _AvatarDetailPageState extends ConsumerState<AvatarDetailPage> {
  var _isLoading = false;
  var _isFavoriteLoading = false;

  @override
  Widget build(BuildContext context) {
    final avatarDetailAsync = ref.watch(avatarDetailProvider(widget.avatarId));
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: avatarDetailAsync.when(
        data: (avatar) => _buildAvatarDetail(context, avatar, isDarkMode),
        loading: () => LoadingIndicator(message: t.avatarDetail.loading),
        error: (error, stackTrace) => ErrorContainer(
          message: t.avatarDetail.error(error: error.toString()),
          onRetry: () =>
              ref.read(avatarDetailControllerProvider).refresh(widget.avatarId),
        ),
      ),
    );
  }

  Widget _buildAvatarDetail(
    BuildContext context,
    Avatar avatar,
    bool isDarkMode,
  ) {
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(avatarDetailControllerProvider).refresh(widget.avatarId);
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _buildAppBar(context, avatar, isDarkMode, headers),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatarInfo(context, avatar, isDarkMode),
                  const SizedBox(height: 24),
                  _buildAvatarDescription(context, avatar, isDarkMode),
                  const SizedBox(height: 24),
                  _buildAvatarTags(context, avatar, isDarkMode),
                  const SizedBox(height: 24),
                  _buildActionButtons(context, avatar, isDarkMode),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(
    BuildContext context,
    Avatar avatar,
    bool isDarkMode,
    Map<String, String> headers,
  ) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      leading: const AppBackButton(),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.black26,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            color: Colors.white,
            onPressed: () => ref
                .read(avatarDetailControllerProvider)
                .shareAvatarProfile(avatar),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'avatar-${avatar.id}',
              child: CachedNetworkImage(
                imageUrl: avatar.imageUrl,
                fit: BoxFit.cover,
                httpHeaders: headers,
                cacheManager: JsonCacheManager(),
                placeholder: (context, url) => Container(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withAlpha(179)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ],
        ),
        title: Text(
          avatar.name,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withAlpha(204),
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarInfo(
    BuildContext context,
    Avatar avatar,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${t.avatarDetail.creator}: ',
              style: GoogleFonts.notoSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            Text(
              avatar.authorName,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 14,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              '${t.avatarDetail.created}: ${_formatDate(avatar.createdAt)}',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.update,
              size: 14,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              '${t.avatarDetail.updated}: ${_formatDate(avatar.updatedAt)}',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: ReleaseStatusUtils.color(avatar.releaseStatus),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _getReleaseStatusText(avatar.releaseStatus),
            style: GoogleFonts.notoSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarDescription(
    BuildContext context,
    Avatar avatar,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.avatarDetail.description,
          style: GoogleFonts.notoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
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
          child: Text(
            avatar.description.isNotEmpty
                ? avatar.description
                : t.avatarDetail.noDescription,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarTags(
    BuildContext context,
    Avatar avatar,
    bool isDarkMode,
  ) {
    if (avatar.tags.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.avatarDetail.tags,
          style: GoogleFonts.notoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: avatar.tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                ),
              ),
              child: Text(
                tag,
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    Avatar avatar,
    bool isDarkMode,
  ) {
    final isCurrentAvatar = avatar.tags.contains('currentAvatar');
    final favoriteAvatarsAsync = ref.watch(favorites.favoriteAvatarsProvider);
    final isFavorited =
        favoriteAvatarsAsync.value?.any(
          (favorite) => favorite.favoriteId == avatar.id,
        ) ??
        false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCurrentAvatar)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading
                  ? null
                  : () async {
                      try {
                        setState(() {
                          _isLoading = true;
                        });

                        await ref
                            .read(avatarDetailControllerProvider)
                            .selectAvatar(avatar.id);

                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                t.avatarDetail.changeSuccess(
                                  name: avatar.name,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                t.avatarDetail.changeFailed(
                                  error: e.toString(),
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : const Icon(Icons.person),
              label: Text(
                _isLoading
                    ? t.avatarDetail.changing
                    : t.avatarDetail.useThisAvatar,
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _isFavoriteLoading || isFavorited
                ? null
                : () => _addAvatarToFavorites(context, avatar),
            icon: _isFavoriteLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
            label: Text(
              isFavorited
                  ? t.worldDetail.favoriteAdded
                  : t.avatarDetail.addToFavorites,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: isFavorited ? Colors.red : AppTheme.primaryColor,
              side: BorderSide(
                color: isFavorited ? Colors.red : AppTheme.primaryColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addAvatarToFavorites(
    BuildContext context,
    Avatar avatar,
  ) async {
    setState(() {
      _isFavoriteLoading = true;
    });

    try {
      await ref
          .read(avatarDetailControllerProvider)
          .addAvatarToFavorites(avatar.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.worldDetail.favoriteAdded)),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error is FavoriteFolderMissingException
                  ? t.favorites.emptyFolderDescription
                  : t.favorites.removeFailed(error: error.toString()),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isFavoriteLoading = false;
        });
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  String _getReleaseStatusText(ReleaseStatus status) {
    switch (status) {
      case ReleaseStatus.public:
        return t.avatarDetail.public;
      case ReleaseStatus.private:
        return t.avatarDetail.private;
      case ReleaseStatus.hidden:
        return t.avatarDetail.hidden;
      default:
        return t.avatarDetail.unknown;
    }
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
