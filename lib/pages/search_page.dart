import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/controllers/search_state_controller.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/pages/tabs/search/avatar_search_tab.dart';
import 'package:vrchat/pages/tabs/search/group_search_tab.dart';
import 'package:vrchat/pages/tabs/search/user_search_tab.dart';
import 'package:vrchat/pages/tabs/search/world_search_tab.dart';
import 'package:vrchat/provider/settings_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();

  // 検索コントローラーと検索メソッドを外部に公開
  static SearchPageController? of(BuildContext context) {
    final state = context.findAncestorStateOfType<SearchPageState>();
    if (state == null) return null;
    return SearchPageController(
      searchController: state._searchController,
      onSearchChanged: state._onSearchChanged,
    );
  }
}

@immutable
class SearchPageController {
  const SearchPageController({
    required this.searchController,
    required this.onSearchChanged,
  });
  final TextEditingController searchController;
  final void Function(String) onSearchChanged;
}

class SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  var _tabCount = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearchControllerChanged);
    _configureTabController(
      hasAvatarApiUrl: ref.read(settingsProvider).avatarSearchApiUrl.isNotEmpty,
    );
  }

  void _configureTabController({
    required bool hasAvatarApiUrl,
    bool notify = false,
  }) {
    final tabCount = hasAvatarApiUrl ? 4 : 3; // APIが設定されていない場合は3タブのみ
    if (_tabCount == tabCount) return;

    if (_tabCount != 0) {
      _tabController.removeListener(_onTabChanged);
      _tabController.dispose();
    }

    _tabController = TabController(length: tabCount, vsync: this);
    _tabController.addListener(_onTabChanged);
    _tabCount = tabCount;

    if (notify && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.removeListener(_handleSearchControllerChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;
    setState(() {});
  }

  void _handleSearchControllerChanged() {
    _onSearchChanged(_searchController.text);
  }

  void _onSearchChanged(String query) {
    ref.read(searchStateControllerProvider).updateQuery(query);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final settings = ref.watch(settingsProvider);
    final hasAvatarApiUrl = settings.avatarSearchApiUrl.isNotEmpty;

    ref.listen<AppSettings>(settingsProvider, (previous, next) {
      if (previous?.avatarSearchApiUrl.isEmpty !=
          next.avatarSearchApiUrl.isEmpty) {
        _configureTabController(
          hasAvatarApiUrl: next.avatarSearchApiUrl.isNotEmpty,
          notify: true,
        );
      }
    });

    return Scaffold(
      body: Column(
        children: [
          // タブバー
          ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: primaryColor,
              unselectedLabelColor: isDarkMode
                  ? Colors.grey[400]
                  : Colors.grey[600],
              indicatorColor: primaryColor,
              labelStyle: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: t.search.userTab),
                Tab(text: t.search.worldTab),
                if (hasAvatarApiUrl) Tab(text: t.search.avatarTab),
                Tab(text: t.search.groupTab),
              ],
            ),
          ),

          // 検索結果 - タブビュー
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const UserSearchTab(),
                const WorldSearchTab(),
                if (hasAvatarApiUrl) const AvatarSearchTab(),
                const GroupSearchTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
