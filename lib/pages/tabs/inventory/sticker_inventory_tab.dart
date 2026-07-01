import 'package:flutter/material.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/tabs/inventory/inventory_file_tab.dart';

class StickerInventoryTab extends StatelessWidget {
  const StickerInventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryFileTab(
      tag: 'sticker',
      loadingMessage: t.inventory.tabs.stickerInventory.loading,
      errorMessage: (error) =>
          t.inventory.tabs.stickerInventory.error(error: error),
      emptyTitle: t.inventory.tabs.stickerInventory.emptyTitle,
      emptyDescription: t.inventory.tabs.stickerInventory.emptyDescription,
      zoomHint: t.inventory.tabs.stickerInventory.zoomHint,
      emptyIcon: Icons.sticky_note_2_outlined,
      crossAxisCount: 3,
      cardImageFit: BoxFit.contain,
      decorateImageBackground: true,
    );
  }
}
