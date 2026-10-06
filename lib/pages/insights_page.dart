import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/app_features_provider.dart';
import 'package:vrchat/utils/app_icons.dart';
import 'package:vrchat/utils/status_helpers.dart';
import 'package:vrchat/widgets/app_bar.dart';
import 'package:vrchat/widgets/app_drawer.dart';

class InsightsPage extends ConsumerStatefulWidget {
  const InsightsPage({super.key});

  @override
  ConsumerState<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends ConsumerState<InsightsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _userController = TextEditingController();
  final _locationController = TextEditingController();
  String _userId = '';
  String _location = '';

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _userController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.t;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(title: strings.insights.title),
      body: Column(
        children: [
          TabBar(
            controller: _tabs,
            tabs: [
              Tab(text: strings.insights.mutualFriends),
              Tab(text: strings.insights.hotWorlds),
              Tab(text: strings.insights.instancePlayers),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _MutualFriendsTab(
                  controller: _userController,
                  userId: _userId,
                  onSubmit: () => setState(
                    () => _userId = _userController.text.trim(),
                  ),
                ),
                const _HotWorldsTab(),
                _InstancePlayersTab(
                  controller: _locationController,
                  location: _location,
                  onSubmit: () => setState(
                    () => _location = _locationController.text.trim(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MutualFriendsTab extends ConsumerWidget {
  const _MutualFriendsTab({
    required this.controller,
    required this.userId,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final String userId;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t;
    final mutual = userId.isEmpty
        ? null
        : ref.watch(mutualFriendsProvider(userId));
    return Column(
      children: [
        _IdInput(
          controller: controller,
          hint: strings.insights.userHint,
          onSubmit: onSubmit,
        ),
        Expanded(
          child: mutual == null
              ? Center(child: Text(strings.insights.enterUser))
              : mutual.when(
                  data: (friends) => friends.isEmpty
                      ? Center(child: Text(strings.insights.noMutual))
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          itemCount: friends.length,
                          itemBuilder: (context, index) {
                            final friend = friends[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: friend.iconUrl == null
                                    ? null
                                    : CachedNetworkImageProvider(
                                        friend.iconUrl!,
                                      ),
                                child: friend.iconUrl == null
                                    ? const Icon(AppIcons.person)
                                    : null,
                              ),
                              title: Text(friend.displayName),
                              subtitle: Text(friend.status.text),
                              onTap: () => context.push('/user/${friend.id}'),
                            );
                          },
                        ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(
                    child: Text(strings.common.error(error: error.toString())),
                  ),
                ),
        ),
      ],
    );
  }
}

class _HotWorldsTab extends ConsumerWidget {
  const _HotWorldsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t;
    final worlds = ref.watch(hotWorldsProvider);
    if (worlds.isEmpty) {
      return Center(child: Text(strings.insights.noLocations));
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: worlds.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final world = worlds[index];
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(world.name),
          subtitle: Text(world.worldId),
          trailing: Text(strings.insights.friendsCount(count: world.count)),
          onTap: () => context.push('/world/${world.worldId}'),
        );
      },
    );
  }
}

class _InstancePlayersTab extends ConsumerWidget {
  const _InstancePlayersTab({
    required this.controller,
    required this.location,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final String location;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t;
    final players = location.isEmpty
        ? null
        : ref.watch(instancePlayersProvider(location));
    return Column(
      children: [
        _IdInput(
          controller: controller,
          hint: strings.insights.locationHint,
          onSubmit: onSubmit,
        ),
        Expanded(
          child: players == null
              ? Center(child: Text(strings.insights.enterLocation))
              : players.when(
                  data: (users) => users.isEmpty
                      ? Center(child: Text(strings.insights.noPlayers))
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: user.userIcon == null
                                    ? null
                                    : CachedNetworkImageProvider(
                                        user.userIcon!,
                                      ),
                                child: user.userIcon == null
                                    ? const Icon(AppIcons.person)
                                    : null,
                              ),
                              title: Text(user.displayName),
                              subtitle: Text(user.status.text),
                              onTap: () => context.push('/user/${user.id}'),
                            );
                          },
                        ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(
                    child: Text(strings.common.error(error: error.toString())),
                  ),
                ),
        ),
      ],
    );
  }
}

class _IdInput extends StatelessWidget {
  const _IdInput({
    required this.controller,
    required this.hint,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final String hint;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: const Icon(AppIcons.search),
              ),
              onSubmitted: (_) => onSubmit(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            tooltip: context.t.insights.load,
            icon: const Icon(AppIcons.arrow_forward_ios),
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}
