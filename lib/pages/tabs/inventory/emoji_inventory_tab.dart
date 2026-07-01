import 'package:flutter/material.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/tabs/inventory/inventory_file_tab.dart';

class EmojiInventoryTab extends StatelessWidget {
  const EmojiInventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryFileTab(
      tag: 'emoji',
      loadingMessage: t.inventory.tabs.emojiInventory.loading,
      errorMessage: (error) =>
          t.inventory.tabs.emojiInventory.error(error: error),
      emptyTitle: t.inventory.tabs.emojiInventory.emptyTitle,
      emptyDescription: t.inventory.tabs.emojiInventory.emptyDescription,
      zoomHint: t.inventory.tabs.emojiInventory.zoomHint,
      emptyIcon: Icons.emoji_emotions_outlined,
      crossAxisCount: 4,
      viewerMaxScale: 6,
      doubleTapScale: 3,
    );
  }
}
