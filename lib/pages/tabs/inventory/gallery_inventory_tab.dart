import 'package:flutter/material.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/tabs/inventory/inventory_file_tab.dart';

class GalleryInventoryTab extends StatelessWidget {
  const GalleryInventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryFileTab(
      tag: 'gallery',
      loadingMessage: t.inventory.tabs.galleryInventory.loading,
      errorMessage: (error) =>
          t.inventory.tabs.galleryInventory.error(error: error),
      emptyTitle: t.inventory.tabs.galleryInventory.emptyTitle,
      emptyDescription: t.inventory.tabs.galleryInventory.emptyDescription,
      zoomHint: t.inventory.tabs.galleryInventory.zoomHint,
      emptyIcon: Icons.photo_library_outlined,
      crossAxisCount: 2,
    );
  }
}
