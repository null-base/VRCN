import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/inventory_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class PrintInventoryTab extends ConsumerWidget {
  const PrintInventoryTab({super.key});

  static final _dateFormat = DateFormat('yyyy/MM/dd HH:mm');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final printsAsync = ref.watch(ownPrintsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(inventoryActionsProvider).refreshPrints();
      },
      child: printsAsync.when(
        data: (prints) {
          if (prints.isEmpty) {
            return _EmptyPrints();
          }

          return MasonryGridView.count(
            physics: const AlwaysScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.sizeOf(context).width >= 560 ? 3 : 2,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: prints.length,
            itemBuilder: (context, index) => _PrintCard(
              print: prints[index],
              dateFormat: _dateFormat,
            ),
          );
        },
        loading: () =>
            LoadingIndicator(message: t.inventory.tabs.printInventory.loading),
        error: (error, _) => ErrorContainer(
          message: t.inventory.tabs.printInventory.error(
            error: error.toString(),
          ),
          onRetry: () => ref.read(inventoryActionsProvider).refreshPrints(),
        ),
      ),
    );
  }
}

class _PrintCard extends ConsumerWidget {
  const _PrintCard({required this.print, required this.dateFormat});

  final Print print;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};
    final image = print.files.image;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: image == null || image.isEmpty
            ? null
            : () {
                showDialog<void>(
                  context: context,
                  builder: (context) => Dialog.fullscreen(
                    backgroundColor: Colors.black,
                    child: Stack(
                      children: [
                        Center(
                          child: InteractiveViewer(
                            maxScale: 4,
                            child: CachedNetworkImage(
                              imageUrl: image,
                              httpHeaders: headers,
                              cacheManager: JsonCacheManager(),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton.filledTonal(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: image == null || image.isEmpty
                  ? ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.print_outlined),
                    )
                  : CachedNetworkImage(
                      imageUrl: image,
                      httpHeaders: headers,
                      cacheManager: JsonCacheManager(),
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) =>
                          const Icon(Icons.broken_image_outlined),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    print.worldName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    print.note.isNotEmpty ? print.note : print.authorName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dateFormat.format(print.timestamp),
                    style: GoogleFonts.notoSans(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
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

class _EmptyPrints extends StatelessWidget {
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
              Icons.print_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              t.inventory.tabs.printInventory.emptyTitle,
              style: GoogleFonts.notoSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.inventory.tabs.printInventory.emptyDescription,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
