import 'package:flutter/material.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/tabs/inventory/inventory_file_tab.dart';

class IconInventoryTab extends StatelessWidget {
  const IconInventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryFileTab(
      tag: 'icon',
      loadingMessage: t.inventory.tabs.iconInventory.loading,
      errorMessage: (error) =>
          t.inventory.tabs.iconInventory.error(error: error),
      emptyTitle: t.inventory.tabs.iconInventory.emptyTitle,
      emptyDescription: t.inventory.tabs.iconInventory.emptyDescription,
      zoomHint: t.inventory.tabs.iconInventory.zoomHint,
      emptyIcon: Icons.account_circle_outlined,
      crossAxisCount: 3,
    );
  }
}
