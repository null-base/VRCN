import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart' show ImageSource, XFile;
import 'package:vrchat/controllers/inventory_upload_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/tabs/inventory/emoji_inventory_tab.dart';
import 'package:vrchat/pages/tabs/inventory/gallery_inventory_tab.dart';
import 'package:vrchat/pages/tabs/inventory/icon_inventory_tab.dart';
import 'package:vrchat/pages/tabs/inventory/inventory_item_tab.dart';
import 'package:vrchat/pages/tabs/inventory/print_inventory_tab.dart';
import 'package:vrchat/pages/tabs/inventory/sticker_inventory_tab.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/snack_bar_utils.dart';

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key});

  @override
  ConsumerState<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<InventoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 現在のタブに応じたアップロード処理
  Future<void> _handleUpload() async {
    final uploadController = ref.read(inventoryUploadControllerProvider);
    final target = uploadController.targetForTab(
      _tabController.index,
      Translations.of(context),
    );
    if (target == null) return;

    final file = await _pickImage();
    if (file == null) return;

    await _showUploadDialog(
      title: target.title,
      future: () => uploadController.uploadImage(file: file, tag: target.tag),
    );
  }

  // 画像選択
  Future<XFile?> _pickImage() async {
    // 画像選択方法を選択するダイアログ
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
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
      return await ref
          .read(inventoryUploadControllerProvider)
          .pickImage(source);
    } catch (e) {
      SnackBarUtils.showError(
        context,
        t.inventory.pickImageFailed(error: e.toString()),
      );
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
        builder: (context) => AlertDialog(
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
        SnackBarUtils.showSuccess(
          context,
          Translations.of(context).inventory.uploadSuccess,
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // プログレスダイアログを閉じる

        SnackBarUtils.showError(
          context,
          ref
              .read(inventoryUploadControllerProvider)
              .uploadErrorMessage(e, Translations.of(context)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final canUpload = _tabController.index < 5;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF151515) : Colors.grey[50],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            backgroundColor: isDarkMode
                ? const Color(0xFF1A1A1A)
                : Colors.white,
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
                    colors: isDarkMode
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
              unselectedLabelColor: isDarkMode
                  ? Colors.grey[400]
                  : Colors.grey[600],
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
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.inventory_2, size: 18),
                      const SizedBox(width: 4),
                      Text(t.inventory.item),
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
            InventoryItemTab(),
          ],
        ),
      ),
      floatingActionButton: canUpload
          ? FloatingActionButton(
              onPressed: _handleUpload,
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              tooltip: t.inventory.upload,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
