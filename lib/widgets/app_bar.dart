import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.showAvatar = true,
    this.onAvatarPressed,
    this.showSearchBar = false,
    this.onSearchChanged,
    this.searchController,
  });
  final String? title;
  final List<Widget>? actions;
  final bool showAvatar;
  final VoidCallback? onAvatarPressed;
  final bool showSearchBar;
  final ValueChanged<String>? onSearchChanged;
  final TextEditingController? searchController;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    void openDrawer() {
      final scaffold = Scaffold.maybeOf(context);
      if (scaffold != null && scaffold.hasDrawer) {
        scaffold.openDrawer();
      }
    }

    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      centerTitle: true,
      title: showSearchBar
          ? _buildSearchField(context, isDarkMode)
          : (title != null
                ? Text(
                    title!,
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: theme.colorScheme.onSurface,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: AssetImage(Assets.icons.icon.path),
                    backgroundColor: theme.colorScheme.surface,
                  )),
      iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      actions: actions,
      leadingWidth: 56,
      leading: showAvatar
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: currentUserAsync.when(
                data: (currentUser) => GestureDetector(
                  onTap: onAvatarPressed ?? openDrawer,
                  child: _HeaderAvatar(
                    imageProvider: currentUser.userIcon.isNotEmpty
                        ? CachedNetworkImageProvider(
                            currentUser.userIcon,
                            headers: headers,
                            cacheManager: JsonCacheManager(),
                          )
                        : currentUser.currentAvatarThumbnailImageUrl.isNotEmpty
                        ? CachedNetworkImageProvider(
                            currentUser.currentAvatarThumbnailImageUrl,
                            headers: headers,
                            cacheManager: JsonCacheManager(),
                          )
                        : AssetImage(Assets.icons.icon.path),
                  ),
                ),
                loading: () => GestureDetector(
                  onTap: onAvatarPressed ?? openDrawer,
                  child: Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                    child: const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
                error: (_, _) => GestureDetector(
                  onTap: onAvatarPressed ?? openDrawer,
                  child: _HeaderAvatar(
                    imageProvider: AssetImage(Assets.icons.icon.path),
                  ),
                ),
              ),
            )
          : null,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(
          height: 0.5,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, bool isDarkMode) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: t.common.search,
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
          suffixIcon: searchController?.text.isNotEmpty ?? false
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    size: 18,
                  ),
                  onPressed: () {
                    searchController?.clear();
                    if (onSearchChanged != null) {
                      onSearchChanged!('');
                    }
                  },
                )
              : null,
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerLow,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppTheme.primaryColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
        ),
        style: GoogleFonts.notoSans(fontSize: 16),
        onChanged: onSearchChanged,
        textInputAction: TextInputAction.search,
        onSubmitted: onSearchChanged,
      ),
    );
  }
}

class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({required this.imageProvider});

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    );
  }
}
