import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/assets.gen.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/cache_manager.dart';

/// アプリ共通のカスタムAppBarウィジェット
class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showAvatar;
  final VoidCallback? onAvatarPressed;
  final bool showSearchBar; // 検索バーを表示するかどうか
  final ValueChanged<String>? onSearchChanged; // 検索テキスト変更時のコールバック

  final TextEditingController? searchController; // 検索コントローラー

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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final vrchatApi = ref.watch(vrchatProvider).value;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};

    // ドロワーを開くための関数
    void openDrawer() {
      final scaffold = Scaffold.maybeOf(context);
      if (scaffold != null && scaffold.hasDrawer) {
        scaffold.openDrawer();
      }
    }

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      centerTitle: true,
      title:
          showSearchBar
              ? _buildSearchField(context, isDarkMode)
              : (title != null
                  ? Text(
                    title!,
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  )
                  : CircleAvatar(
                    backgroundImage: AssetImage(Assets.icons.vrcn.path),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  )),
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      actions: actions,
      leadingWidth: 56,
      leading:
          showAvatar
              ? Padding(
                padding: const EdgeInsets.all(8),
                child: currentUserAsync.when(
                  data:
                      (currentUser) => GestureDetector(
                        onTap: onAvatarPressed ?? openDrawer,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              currentUser.userIcon.isNotEmpty
                                  ? CachedNetworkImageProvider(
                                    currentUser.userIcon,
                                    headers: headers,
                                    cacheManager: JsonCacheManager(),
                                  )
                                  : currentUser
                                      .currentAvatarThumbnailImageUrl
                                      .isNotEmpty
                                  ? CachedNetworkImageProvider(
                                    currentUser.currentAvatarThumbnailImageUrl,
                                    headers: headers,
                                    cacheManager: JsonCacheManager(),
                                  )
                                  : AssetImage(Assets.icons.vrcn.path),
                        ),
                      ),
                  loading:
                      () => GestureDetector(
                        onTap: onAvatarPressed ?? openDrawer,
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                  error:
                      (_, _) => GestureDetector(
                        onTap: onAvatarPressed ?? openDrawer,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage(Assets.icons.vrcn.path),
                        ),
                      ),
                ),
              )
              : null,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(
          height: 0.5,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[900]
                  : Colors.grey[200],
        ),
      ),
    );
  }

  // 検索フィールドを構築するメソッド
  Widget _buildSearchField(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: t.common.search,
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
          suffixIcon:
              searchController?.text.isNotEmpty ?? false
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
          fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
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
