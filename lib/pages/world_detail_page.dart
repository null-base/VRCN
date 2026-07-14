import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/favorite_provider.dart' as favorites;
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/share_utils.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';
import 'package:vrchat/widgets/error_view.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class WorldDetailPage extends ConsumerWidget {
  const WorldDetailPage({super.key, required this.worldId});
  final String worldId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final worldDetailAsync = ref.watch(worldDetailProvider(worldId));
    final vrchatApi = ref.watch(vrchatProvider).value;

    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Scaffold(
      body: worldDetailAsync.when(
        data: (world) =>
            _buildWorldDetailView(context, world, isDarkMode, headers, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          message: t.worldDetail.error(error: error.toString()),
        ),
      ),
    );
  }

  Widget _buildWorldDetailView(
    BuildContext context,
    World world,
    bool isDarkMode,
    Map<String, String> headers,
    WidgetRef ref,
  ) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, world, isDarkMode, headers),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWorldInfo(context, world, isDarkMode),
                const SizedBox(height: 24),
                _buildWorldStats(context, world, isDarkMode),
                const SizedBox(height: 24),
                _buildDescription(context, world, isDarkMode),
                const SizedBox(height: 24),
                _buildTags(context, world, isDarkMode),
                const SizedBox(height: 32),
                _buildActionButtons(context, world, isDarkMode, ref),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    World world,
    bool isDarkMode,
    Map<String, String> headers,
  ) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      leading: Container(
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
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // ワールド画像
            CachedNetworkImage(
              imageUrl: world.imageUrl,
              fit: BoxFit.cover,
              httpHeaders: headers,
              cacheManager: JsonCacheManager(),
              placeholder: (context, url) => Container(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
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
          ],
        ),
      ),
      actions: [
        // 共有ボタン
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          tooltip: t.worldDetail.share,
          onPressed: () => _shareWorld(world),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onSelected: (value) {
            switch (value) {
              case 'website':
                _launchVRChatWebsite(world.id);
              case 'report':
                _launchVRChatWebsite(world.id);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'website',
              child: Row(
                children: [
                  const Icon(Icons.public, size: 20),
                  const SizedBox(width: 12),
                  Text(t.worldDetail.openInVRChat),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'report',
              child: Row(
                children: [
                  const Icon(Icons.report_problem, size: 20),
                  const SizedBox(width: 12),
                  Text(t.worldDetail.report),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorldInfo(BuildContext context, World world, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              world.name,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),

        // 作成者情報
        Row(
          children: [
            Text(
              '${t.worldDetail.creator}: ',
              style: GoogleFonts.notoSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            Text(
              world.authorName,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // 作成日と更新日
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 8),
            Text(
              '${t.worldDetail.created}: ${_formatDate(world.createdAt)}',
              style: GoogleFonts.notoSans(fontSize: 14),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.update, size: 16),
            const SizedBox(width: 8),
            Text(
              '${t.worldDetail.updated}: ${_formatDate(world.updatedAt)}',
              style: GoogleFonts.notoSans(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorldStats(BuildContext context, World world, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.grey[850]!.withValues(alpha: .5)
            : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            Icons.favorite,
            _formatNumber(world.favorites),
            t.worldDetail.favorites,
            Colors.red,
          ),
          _buildStatItem(
            context,
            Icons.visibility,
            _formatNumber(world.visits),
            t.worldDetail.visits,
            Colors.blue,
          ),
          _buildStatItem(
            context,
            Icons.public,
            _formatNumber(world.occupants),
            t.worldDetail.occupants,
            Colors.green,
          ),
          _buildStatItem(
            context,
            Icons.favorite,
            world.popularity.toString(),
            t.worldDetail.popularity,
            Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          label,
          style: GoogleFonts.notoSans(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, World world, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.worldDetail.description,
          style: GoogleFonts.notoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.grey[850]!.withValues(alpha: 0.5)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            ),
          ),
          child: Text(
            world.description.isNotEmpty
                ? world.description
                : t.worldDetail.noDescription,
            style: GoogleFonts.notoSans(fontSize: 14, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildTags(BuildContext context, World world, bool isDarkMode) {
    if (world.tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.worldDetail.tags,
          style: GoogleFonts.notoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: world.tags
              .map((tag) => _buildTagChip(tag, isDarkMode))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTagChip(String tag, bool isDarkMode) {
    return Chip(
      label: Text(
        tag.replaceAll('author_tag_', ''),
        style: GoogleFonts.notoSans(
          fontSize: 12,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    World world,
    bool isDarkMode,
    WidgetRef ref,
  ) {
    final favoriteWorldsAsync = ref.watch(favorites.favoriteWorldsProvider);
    final favoriteAction = ref.watch(favorites.favoriteActionProvider);
    final isFavorited =
        favoriteWorldsAsync.value?.any(
          (favorite) => favorite.favoriteId == world.id,
        ) ??
        false;
    final isFavoriteLoading = favoriteAction.isLoading;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _launchVRChatWebsite(world.id),
            icon: const Icon(Icons.public),
            label: Text(
              t.worldDetail.openInVRChat,
              style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: isFavorited || isFavoriteLoading
              ? null
              : () => _addWorldToFavorites(context, world, ref),
          icon: isFavoriteLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
          style: IconButton.styleFrom(
            backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
            foregroundColor: Colors.red,
            disabledForegroundColor: Colors.red.withValues(alpha: 0.7),
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.red.withValues(alpha: 0.5)),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addWorldToFavorites(
    BuildContext context,
    World world,
    WidgetRef ref,
  ) async {
    try {
      final favoriteGroups = await ref.read(
        favorites
            .typedFavoriteGroupsProvider(favorites.FavoriteType.world)
            .future,
      );
      if (favoriteGroups.isEmpty) {
        throw Exception(t.favorites.emptyFolderDescription);
      }

      await ref
          .read(favorites.favoriteActionProvider.notifier)
          .addFavorite(
            favoriteId: world.id,
            type: favorites.FavoriteType.world,
            tags: [favoriteGroups.first.name],
          );

      ref
        ..invalidate(favorites.favoriteWorldsProvider)
        ..invalidate(
          favorites.allFavoritesProvider(favorites.FavoriteType.world),
        );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.worldDetail.favoriteAdded)),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.favorites.removeFailed(error: error.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return t.worldDetail.unknown;
    return DateFormat('yyyy/MM/dd').format(date);
  }

  String _formatNumber(int? number) {
    if (number == null) return '0';
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

// ブラウザでVRChatウェブサイトを開くメソッド
Future<void> _launchVRChatWebsite(String worldId) async {
  await UrlLauncherUtils.launchExternalURL(
    'https://vrchat.com/home/world/$worldId',
  );
}

// ワールド情報を共有するメソッド
Future<void> _shareWorld(World world) async {
  await ShareUtils.shareUrl(
    'https://vrchat.com/home/world/${world.id}',
    subject: world.name,
  );
}
