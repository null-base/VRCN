import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/files_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/download_utils.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class PrintInventoryTab extends ConsumerStatefulWidget {
  const PrintInventoryTab({super.key});

  @override
  ConsumerState<PrintInventoryTab> createState() => _PrintInventoryTabState();
}

class _PrintInventoryTabState extends ConsumerState<PrintInventoryTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> _refreshFiles() async {
    ref.invalidate(getFilesByTagProvider('print'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final printFilesAsync = ref.watch(getPrintFilesProvider);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return RefreshIndicator(
      onRefresh: _refreshFiles,
      child: printFilesAsync.when(
        data: (files) {
          if (files.isEmpty) {
            return _buildEmptyState(isDarkMode);
          }
          return _buildFilesGrid(files, headers, isDarkMode);
        },
        loading:
            () => LoadingIndicator(
              message: t.inventory.tabs.printInventory.loading,
            ),
        error:
            (error, stackTrace) => ErrorContainer(
              message: t.inventory.tabs.printInventory.error(
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
                Icons.print_outlined,
                size: 60,
                color: AppTheme.primaryColor.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              t.inventory.tabs.printInventory.emptyTitle,
              style: GoogleFonts.notoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              t.inventory.tabs.printInventory.emptyDescription,
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
                child: _buildPrintCard(file, headers, isDarkMode),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPrintCard(
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
          // プリント画像
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GestureDetector(
                  onTap: () => _showFullScreenPrint(file, headers),
                  child: CachedNetworkImage(
                    imageUrl: file.versions.last.file!.url.toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    httpHeaders: headers,
                    cacheManager: JsonCacheManager(),
                    placeholder:
                        (context, url) => Container(
                          color:
                              isDarkMode ? Colors.grey[800] : Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          color:
                              isDarkMode ? Colors.grey[800] : Colors.grey[300],
                          child: const Icon(Icons.print),
                        ),
                  ),
                ),
              ),
            ],
          ),

          // ファイル情報
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(file.versions.last.createdAt),
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // フルスクリーンプリント表示
  void _showFullScreenPrint(File file, Map<String, String> headers) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                _FullScreenPrintViewer(file: file, headers: headers),
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

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd HH:mm').format(date);
  }
}

// フルスクリーンプリントビューアー
class _FullScreenPrintViewer extends StatefulWidget {
  final File file;
  final Map<String, String> headers;

  const _FullScreenPrintViewer({required this.file, required this.headers});

  @override
  _FullScreenPrintViewerState createState() => _FullScreenPrintViewerState();
}

class _FullScreenPrintViewerState extends State<_FullScreenPrintViewer>
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

          // プリントビューアー
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
                          Icons.print,
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

          // フッター（ズームヒントとファイル情報）
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ズームヒント
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    t.inventory.tabs.printInventory.zoomHint,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // ファイル情報
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat(
                              'yyyy/MM/dd HH:mm',
                            ).format(widget.file.versions.last.createdAt),
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: Colors.grey[300],
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
        ],
      ),
    );
  }
}
