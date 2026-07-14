import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/inventory_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class InventoryItemTab extends ConsumerWidget {
  const InventoryItemTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(inventoryItemsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(inventoryItemsProvider);
        await ref.read(inventoryItemsProvider.future);
      },
      child: itemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const _EmptyInventoryItems();
          }

          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            itemBuilder: (context, index) => _InventoryItemTile(
              item: items[index],
            ),
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemCount: items.length,
          );
        },
        loading: () =>
            LoadingIndicator(message: t.inventory.tabs.inventoryItem.loading),
        error: (error, _) => ErrorContainer(
          message: t.inventory.tabs.inventoryItem.error(
            error: error.toString(),
          ),
          onRetry: () => ref.invalidate(inventoryItemsProvider),
        ),
      ),
    );
  }
}

class _InventoryItemTile extends ConsumerWidget {
  const _InventoryItemTile({required this.item});

  final InventoryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final actions = ref.read(inventoryActionsProvider);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 64,
                height: 64,
                child: item.imageUrl.isEmpty
                    ? ColoredBox(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.inventory_2_outlined),
                      )
                    : CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        httpHeaders: headers,
                        cacheManager: JsonCacheManager(),
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) =>
                            const Icon(Icons.broken_image_outlined),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description.isNotEmpty
                        ? item.description
                        : item.itemTypeLabel,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _ItemChip(label: item.itemType.value),
                      if (item.equipSlot != null &&
                          item.equipSlot!.value.isNotEmpty)
                        _ItemChip(
                          label: t.inventory.tabs.inventoryItem.equipped(
                            slot: item.equipSlot!.value,
                          ),
                        ),
                      _IconAction(
                        tooltip: t.inventory.tabs.inventoryItem.spawn,
                        onPressed: () async {
                          await actions.spawnItem(item.id);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                t.inventory.tabs.inventoryItem.spawned(
                                  name: item.name,
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icons.play_arrow,
                      ),
                      if (item.equipSlot != null &&
                          item.equipSlot!.value.isNotEmpty)
                        _IconAction(
                          tooltip: t.inventory.tabs.inventoryItem.unequip,
                          onPressed: () async {
                            await actions.unequipSlot(item.equipSlot!);
                          },
                          icon: Icons.remove_circle_outline,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemChip extends StatelessWidget {
  const _ItemChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Text(
        label,
        style: GoogleFonts.notoSans(
          fontSize: 12,
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(icon, size: 18, color: AppTheme.primaryColor),
        ),
      ),
    );
  }
}

class _EmptyInventoryItems extends StatelessWidget {
  const _EmptyInventoryItems();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              t.inventory.tabs.inventoryItem.emptyTitle,
              style: GoogleFonts.notoSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
