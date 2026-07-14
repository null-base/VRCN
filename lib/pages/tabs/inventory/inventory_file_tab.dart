import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/provider/files_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/utils/download_utils.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class InventoryFileTab extends ConsumerStatefulWidget {
  const InventoryFileTab({
    super.key,
    required this.tag,
    required this.loadingMessage,
    required this.errorMessage,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.zoomHint,
    required this.emptyIcon,
    this.errorIcon = Icons.broken_image,
    required this.crossAxisCount,
    this.cardImageFit = BoxFit.cover,
    this.showCardDate = false,
    this.showViewerDate = false,
    this.decorateImageBackground = false,
    this.viewerMaxScale = 4,
    this.doubleTapScale = 2.5,
  });
  final String tag;
  final String loadingMessage;
  final String Function(String error) errorMessage;
  final String emptyTitle;
  final String emptyDescription;
  final String zoomHint;
  final IconData emptyIcon;
  final IconData errorIcon;
  final int crossAxisCount;
  final BoxFit cardImageFit;
  final bool showCardDate;
  final bool showViewerDate;
  final bool decorateImageBackground;
  final double viewerMaxScale;
  final double doubleTapScale;

  @override
  ConsumerState<InventoryFileTab> createState() => _InventoryFileTabState();
}

class _InventoryFileTabState extends ConsumerState<InventoryFileTab>
    with AutomaticKeepAliveClientMixin {
  static final _dateFormat = DateFormat('yyyy/MM/dd HH:mm');

  @override
  bool get wantKeepAlive => true;

  Future<void> _refreshFiles() async {
    ref.invalidate(getFilesByTagProvider(widget.tag));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final filesAsync = ref.watch(getFilesByTagProvider(widget.tag));
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return RefreshIndicator(
      onRefresh: _refreshFiles,
      child: filesAsync.when(
        data: (files) {
          if (files.isEmpty) {
            return _buildEmptyState(isDarkMode);
          }

          return _buildFilesGrid(files, headers, isDarkMode);
        },
        loading: () => LoadingIndicator(message: widget.loadingMessage),
        error: (error, stackTrace) => ErrorContainer(
          message: widget.errorMessage(error.toString()),
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
                widget.emptyIcon,
                size: 60,
                color: AppTheme.primaryColor.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              widget.emptyTitle,
              style: GoogleFonts.notoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.emptyDescription,
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
    final visibleFiles = [
      for (final file in files)
        if (_fileUrl(file) case final url?) (file: file, url: url),
    ];

    if (visibleFiles.isEmpty) {
      return _buildEmptyState(isDarkMode);
    }

    return MasonryGridView.count(
      crossAxisCount: widget.crossAxisCount,
      padding: const EdgeInsets.all(16),
      itemCount: visibleFiles.length,
      itemBuilder: (context, index) {
        final (:file, :url) = visibleFiles[index];
        return _InventoryFileCard(
          file: file,
          url: url,
          headers: headers,
          imageFit: widget.cardImageFit,
          errorIcon: widget.errorIcon,
          decorateImageBackground: widget.decorateImageBackground,
          showDate: widget.showCardDate,
          dateFormat: _dateFormat,
          onTap: () => _showFullScreenImage(
            file: file,
            headers: headers,
            url: url,
          ),
        );
      },
    );
  }

  void _showFullScreenImage({
    required File file,
    required Map<String, String> headers,
    required String url,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (context, animation, secondaryAnimation) =>
            InventoryFullScreenFileViewer(
              file: file,
              url: url,
              headers: headers,
              zoomHint: widget.zoomHint,
              errorIcon: widget.errorIcon,
              maxScale: widget.viewerMaxScale,
              doubleTapScale: widget.doubleTapScale,
              showDate: widget.showViewerDate,
              decorateImageBackground: widget.decorateImageBackground,
              dateFormat: _dateFormat,
            ),
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

  String? _fileUrl(File file) {
    if (file.versions.isEmpty) {
      return null;
    }

    final url = file.versions.last.file?.url;
    if (url == null || url.isEmpty) {
      return null;
    }

    return url;
  }
}

class _InventoryFileCard extends StatelessWidget {
  const _InventoryFileCard({
    required this.file,
    required this.url,
    required this.headers,
    required this.imageFit,
    required this.errorIcon,
    required this.decorateImageBackground,
    required this.showDate,
    required this.dateFormat,
    required this.onTap,
  });
  final File file;
  final String url;
  final Map<String, String> headers;
  final BoxFit imageFit;
  final IconData errorIcon;
  final bool decorateImageBackground;
  final bool showDate;
  final DateFormat dateFormat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              onTap: onTap,
              child: _ImageBackground(
                enabled: decorateImageBackground,
                isDarkMode: isDarkMode,
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: imageFit,
                  width: double.infinity,
                  height: double.infinity,
                  httpHeaders: headers,
                  cacheManager: JsonCacheManager(),
                  placeholder: (context, url) => Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: Icon(errorIcon),
                  ),
                ),
              ),
            ),
          ),
          if (showDate) _InventoryFileDate(file: file, dateFormat: dateFormat),
        ],
      ),
    );
  }
}

class _InventoryFileDate extends StatelessWidget {
  const _InventoryFileDate({required this.file, required this.dateFormat});
  final File file;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            size: 14,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            dateFormat.format(file.versions.last.createdAt),
            style: GoogleFonts.notoSans(
              fontSize: 12,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class InventoryFullScreenFileViewer extends StatefulWidget {
  const InventoryFullScreenFileViewer({
    super.key,
    required this.file,
    required this.url,
    required this.headers,
    required this.zoomHint,
    required this.errorIcon,
    required this.maxScale,
    required this.doubleTapScale,
    required this.showDate,
    required this.decorateImageBackground,
    required this.dateFormat,
  });
  final File file;
  final String url;
  final Map<String, String> headers;
  final String zoomHint;
  final IconData errorIcon;
  final double maxScale;
  final double doubleTapScale;
  final bool showDate;
  final bool decorateImageBackground;
  final DateFormat dateFormat;

  @override
  State<InventoryFullScreenFileViewer> createState() =>
      _InventoryFullScreenFileViewerState();
}

class _InventoryFullScreenFileViewerState
    extends State<InventoryFullScreenFileViewer>
    with SingleTickerProviderStateMixin {
  late final TransformationController _transformationController;
  late final AnimationController _animationController;
  Animation<Matrix4>? _animation;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.addListener(() {
      final animation = _animation;
      if (animation != null) {
        _transformationController.value = animation.value;
      }
    });
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
    if (!_transformationController.value.isIdentity()) {
      _animateTo(Matrix4.identity());
      return;
    }

    final position = _doubleTapDetails?.localPosition;
    if (position == null) {
      return;
    }

    final scale = widget.doubleTapScale;
    final zoomed = Matrix4.identity()
      ..translate(-position.dx * (scale - 1), -position.dy * (scale - 1))
      ..scale(scale);
    _animateTo(zoomed);
  }

  void _animateTo(Matrix4 target) {
    _animation =
        Matrix4Tween(
          begin: _transformationController.value,
          end: target,
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController
      ..reset()
      ..forward();
  }

  void _shareFile() {
    final extension = DownloadUtils.getFileExtension(widget.url);
    final fileName = '${widget.file.name}$extension';

    DownloadUtils.shareFile(
      context: context,
      url: widget.url,
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
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
          Center(
            child: _ImageBackground(
              enabled: widget.decorateImageBackground,
              isDarkMode: true,
              child: GestureDetector(
                onDoubleTapDown: _handleDoubleTapDown,
                onDoubleTap: _handleDoubleTap,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: 0.5,
                  maxScale: widget.maxScale,
                  child: CachedNetworkImage(
                    imageUrl: widget.url,
                    httpHeaders: widget.headers,
                    cacheManager: JsonCacheManager(),
                    fit: BoxFit.contain,
                    placeholder: (context, url) => _ViewerPlaceholder(
                      icon: null,
                      size: widget.maxScale > 4 ? 150 : 200,
                    ),
                    errorWidget: (context, url, error) => _ViewerPlaceholder(
                      icon: widget.errorIcon,
                      size: widget.maxScale > 4 ? 150 : 200,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ViewerActionButton(
                  icon: Icons.close,
                  onTap: () => Navigator.of(context).pop(),
                ),
                _ViewerActionButton(icon: Icons.share, onTap: _shareFile),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ViewerPill(child: Text(widget.zoomHint)),
                if (widget.showDate) ...[
                  const SizedBox(height: 12),
                  _ViewerPill(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.dateFormat.format(
                            widget.file.versions.last.createdAt,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageBackground extends StatelessWidget {
  const _ImageBackground({
    required this.enabled,
    required this.isDarkMode,
    required this.child,
  });
  final bool enabled;
  final bool isDarkMode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [Colors.grey[800]!, Colors.grey[900]!]
              : [Colors.grey[100]!, Colors.grey[200]!],
        ),
      ),
      child: child,
    );
  }
}

class _ViewerPlaceholder extends StatelessWidget {
  const _ViewerPlaceholder({required this.icon, required this.size});
  final IconData? icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: icon == null
            ? const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Icon(icon, color: Colors.white, size: size * 0.32),
      ),
    );
  }
}

class _ViewerActionButton extends StatelessWidget {
  const _ViewerActionButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.black.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

class _ViewerPill extends StatelessWidget {
  const _ViewerPill({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.borderRadius = 20,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.notoSans(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    return DefaultTextStyle.merge(
      style: textStyle,
      child: IconTheme.merge(
        data: const IconThemeData(color: Colors.white),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
