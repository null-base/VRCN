import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/files_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/download_utils.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class GalleryInventoryTab extends ConsumerStatefulWidget {
  const GalleryInventoryTab({super.key});

  @override
  ConsumerState<GalleryInventoryTab> createState() =>
      _GalleryInventoryTabState();
}

class _GalleryInventoryTabState extends ConsumerState<GalleryInventoryTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> _refreshFiles() async {
    ref.invalidate(getFilesByTagProvider('gallery'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final galleryFilesAsync = ref.watch(getFilesByTagProvider('gallery'));
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return RefreshIndicator(
      onRefresh: _refreshFiles,
      child: galleryFilesAsync.when(
        data: (files) {
          if (files.isEmpty) {
            return _buildEmptyState(isDarkMode);
          }

          return _buildFilesGrid(files, headers, isDarkMode);
        },
        loading:
            () => LoadingIndicator(
              message: t.inventory.tabs.galleryInventory.loading,
            ),
        error:
            (error, stackTrace) => ErrorContainer(
              message: t.inventory.tabs.galleryInventory.error(
                error: error.toString(),
              ),
              onRetry: _refreshFiles,
            ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.photo_library_outlined,
                size: 60,
                color: AppTheme.primaryColor.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              t.inventory.tabs.galleryInventory.emptyTitle,
              style: GoogleFonts.notoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              t.inventory.tabs.galleryInventory.emptyDescription,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilesGrid(
    List<File> files,
    Map<String, String> headers,
    bool isDarkMode,
  ) {
    return AnimationLimiter(
      child: MasonryGridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: 2,
            child: SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(
                child: _buildGalleryCard(file, headers, isDarkMode),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGalleryCard(
    File file,
    Map<String, String> headers,
    bool isDarkMode,
  ) {
    // URLが空の場合はカードを表示しない
    if (file.versions.last.file!.url.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ファイル画像
          Stack(
            children: [
              GestureDetector(
                onTap: () => _showFullScreenImage(file, headers),
                child: CachedNetworkImage(
                  imageUrl: file.versions.last.file!.url.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  httpHeaders: headers,
                  cacheManager: JsonCacheManager(),
                  placeholder:
                      (context, url) => Container(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                        child: const Icon(Icons.broken_image),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // フルスクリーン画像表示
  void _showFullScreenImage(File file, Map<String, String> headers) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                _FullScreenFileViewer(file: file, headers: headers),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

// フルスクリーンファイルビューアー
class _FullScreenFileViewer extends StatefulWidget {
  final File file;
  final Map<String, String> headers;

  const _FullScreenFileViewer({required this.file, required this.headers});

  @override
  _FullScreenFileViewerState createState() => _FullScreenFileViewerState();
}

class _FullScreenFileViewerState extends State<_FullScreenFileViewer>
    with TickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  late Animation<Matrix4> _animation;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      // ズームアウト
      _animation = Matrix4Tween(
        begin: _transformationController.value,
        end: Matrix4.identity(),
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      );
    } else {
      // ズームイン
      final position = _doubleTapDetails!.localPosition;
      const scale = 2.5;
      final x = -position.dx * (scale - 1);
      final y = -position.dy * (scale - 1);
      final zoomed =
          Matrix4.identity()
            ..translate(x, y)
            ..scale(scale);

      _animation = Matrix4Tween(
        begin: _transformationController.value,
        end: zoomed,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      );
    }

    _animationController.reset();
    _animation.addListener(() {
      _transformationController.value = _animation.value;
    });
    _animationController.forward();
  }

  void _shareFile() {
    final url = widget.file.versions.last.file!.url.toString();
    final extension = DownloadUtils.getFileExtension(url);
    final fileName = '${widget.file.name}$extension';

    DownloadUtils.shareFile(
      context: context,
      url: url,
      fileName: fileName,
      headers: widget.headers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 背景タップで閉じる
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),

          // 画像ビューアー
          Center(
            child: GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,
              child: InteractiveViewer(
                transformationController: _transformationController,
                minScale: 0.5,
                maxScale: 4,
                child: CachedNetworkImage(
                  imageUrl: widget.file.versions.last.file!.url.toString(),
                  httpHeaders: widget.headers,
                  cacheManager: JsonCacheManager(),
                  fit: BoxFit.contain,
                  placeholder:
                      (context, url) => Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                ),
              ),
            ),
          ),

          // ヘッダー（閉じるボタンとアクションボタン）
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 閉じるボタン
                Material(
                  elevation: 4,
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(25),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () => Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.close, color: Colors.white, size: 24),
                    ),
                  ),
                ),

                // アクションボタン群
                Row(
                  children: [
                    // 共有ボタン
                    Material(
                      elevation: 4,
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(25),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: _shareFile,
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // フッター（ズームヒント）
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 16,
            right: 16,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  t.inventory.tabs.galleryInventory.zoomHint,
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
