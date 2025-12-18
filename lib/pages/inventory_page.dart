import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/tabs/inventory/emoji_inventory_tab.dart';
import 'package:vrchat/pages/tabs/inventory/gallery_inventory_tab.dart';
import 'package:vrchat/pages/tabs/inventory/icon_inventory_tab.dart';
import 'package:vrchat/pages/tabs/inventory/print_inventory_tab.dart';
import 'package:vrchat/pages/tabs/inventory/sticker_inventory_tab.dart';
import 'package:vrchat/provider/files_provider.dart';
import 'package:vrchat/theme/app_theme.dart';

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key});

  @override
  ConsumerState<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<InventoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // 現在のタブに応じたアップロード処理
  Future<void> _handleUpload() async {
    final currentIndex = _tabController.index;

    switch (currentIndex) {
      case 0: // ギャラリー
        await _uploadGallery();
      case 1: // アイコン
        await _uploadIcon();
      case 2: // 絵文字
        await _uploadEmoji();
      case 3: // ステッカー
        await _uploadSticker();
      case 4: // プリント
        await _uploadPrint();
    }
  }

  // ギャラリー画像をアップロード
  Future<void> _uploadGallery() async {
    final file = await _pickImage();
    if (file == null) return;

    await _showUploadDialog(
      title: t.inventory.uploadGallery,
      future: () async {
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.name,
          contentType: MediaType.parse('image/png'),
        );
        final params = UploadImageParams(file: multipartFile, tag: 'gallery');
        return ref.read(uploadImageProvider(params).future);
      },
    );
  }

  // アイコンをアップロード
  Future<void> _uploadIcon() async {
    final file = await _pickImage();
    if (file == null) return;

    await _showUploadDialog(
      title: t.inventory.uploadIcon,
      future: () async {
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.name,
          contentType: MediaType.parse('image/png'),
        );
        final params = UploadImageParams(file: multipartFile, tag: 'icon');
        return ref.read(uploadImageProvider(params).future);
      },
    );
  }

  // 絵文字をアップロード
  Future<void> _uploadEmoji() async {
    final file = await _pickImage();
    if (file == null) return;

    await _showUploadDialog(
      title: t.inventory.uploadEmoji,
      future: () async {
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.name,
          contentType: MediaType.parse('image/png'),
        );
        final params = UploadImageParams(file: multipartFile, tag: 'emoji');
        return ref.read(uploadImageProvider(params).future);
      },
    );
  }

  // ステッカーをアップロード
  Future<void> _uploadSticker() async {
    final file = await _pickImage();
    if (file == null) return;

    await _showUploadDialog(
      title: t.inventory.uploadSticker,
      future: () async {
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.name,
          contentType: MediaType.parse('image/png'),
        );
        final params = UploadImageParams(file: multipartFile, tag: 'sticker');
        return ref.read(uploadImageProvider(params).future);
      },
    );
  }

  // プリント画像をアップロード
  Future<void> _uploadPrint() async {
    final file = await _pickImage();
    if (file == null) return;

    await _showUploadDialog(
      title: t.inventory.uploadPrint,
      future: () async {
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.name,
          contentType: MediaType.parse('image/png'),
        );
        final params = UploadImageParams(file: multipartFile, tag: 'print');
        return ref.read(uploadImageProvider(params).future);
      },
    );
  }

  // 画像選択
  Future<XFile?> _pickImage() async {
    final picker = ImagePicker();

    // 画像選択方法を選択するダイアログ
    final source = await showDialog<ImageSource>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              t.inventory.selectImage,
              style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(
                    t.inventory.selectFromGallery,
                    style: GoogleFonts.notoSans(),
                  ),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(
                    t.inventory.takePhoto,
                    style: GoogleFonts.notoSans(),
                  ),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
              ],
            ),
          ),
    );

    if (source == null) return null;

    try {
      return await picker.pickImage(source: source);
    } catch (e) {
      _showErrorSnackBar(t.inventory.pickImageFailed(error: e.toString()));
      return null;
    }
  }

  // アップロード進行ダイアログ
  Future<void> _showUploadDialog({
    required String title,
    required Future<dynamic> Function() future,
  }) async {
    // プログレスダイアログを表示
    unawaited(
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(title, style: GoogleFonts.notoSans()),
                ],
              ),
            ),
      ),
    );

    try {
      // アップロード処理を実行
      await future();

      if (mounted) {
        Navigator.pop(context); // プログレスダイアログを閉じる
        _showSuccessSnackBar(Translations.of(context).inventory.uploadSuccess);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // プログレスダイアログを閉じる

        var errorMessage = t.inventory.uploadFailed;
        if (e is DioException) {
          if (e.response?.statusCode == 400) {
            errorMessage = t.inventory.uploadFailedFormat;
          } else if (e.response?.statusCode == 401) {
            errorMessage = t.inventory.uploadFailedAuth;
          } else if (e.response?.statusCode == 413) {
            errorMessage = t.inventory.uploadFailedSize;
          } else {
            errorMessage = t.inventory.uploadFailedServer(
              code: int.parse(e.response!.statusCode.toString()),
            );
          }
        }
        _showErrorSnackBar(errorMessage);
      }
    }
  }

  // 成功メッセージ
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message, style: GoogleFonts.notoSans()),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // エラーメッセージ
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: GoogleFonts.notoSans())),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 5), // エラーメッセージは長めに表示
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF151515) : Colors.grey[50],
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 100,
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                backgroundColor:
                    isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
                title: Text(
                  t.inventory.title,
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:
                            isDarkMode
                                ? [
                                  Colors.deepPurple.withValues(alpha: 0.3),
                                  Colors.indigo.withValues(alpha: 0.2),
                                ]
                                : [
                                  Colors.deepPurple.withValues(alpha: 0.1),
                                  Colors.indigo.withValues(alpha: 0.05),
                                ],
                      ),
                    ),
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  labelStyle: GoogleFonts.notoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  unselectedLabelStyle: GoogleFonts.notoSans(fontSize: 12),
                  indicatorColor: AppTheme.primaryColor,
                  indicatorWeight: 3,
                  labelColor: isDarkMode ? Colors.white : Colors.black87,
                  unselectedLabelColor:
                      isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.photo_library, size: 18),
                          const SizedBox(width: 4),
                          Text(t.inventory.gallery),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.account_circle, size: 18),
                          const SizedBox(width: 4),
                          Text(t.inventory.icon),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.emoji_emotions, size: 18),
                          const SizedBox(width: 4),
                          Text(t.inventory.emoji),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.sticky_note_2, size: 18),
                          const SizedBox(width: 4),
                          Text(t.inventory.sticker),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.print, size: 18),
                          const SizedBox(width: 4),
                          Text(t.inventory.print),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
        body: TabBarView(
          controller: _tabController,
          children: const [
            GalleryInventoryTab(),
            IconInventoryTab(),
            EmojiInventoryTab(),
            StickerInventoryTab(),
            PrintInventoryTab(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleUpload,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        tooltip: t.inventory.upload,
        child: const Icon(Icons.add),
      ),
    );
  }
}
