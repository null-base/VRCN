import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/app_features_provider.dart';
import 'package:vrchat/utils/app_icons.dart';
import 'package:vrchat/widgets/app_bar.dart';
import 'package:vrchat/widgets/app_drawer.dart';

class ModerationPage extends ConsumerStatefulWidget {
  const ModerationPage({super.key});

  @override
  ConsumerState<ModerationPage> createState() => _ModerationPageState();
}

class _ModerationPageState extends ConsumerState<ModerationPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _groupController = TextEditingController();
  String _groupId = '';

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _groupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.t;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: strings.moderation.title,
        actions: [
          IconButton(
            tooltip: strings.moderation.clearPlayer,
            icon: const Icon(AppIcons.cleaning_services_outlined),
            onPressed: () => _clearAll(context),
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabs,
            tabs: [
              Tab(text: strings.moderation.player),
              Tab(text: strings.moderation.groupBans),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                const _PlayerModerationList(),
                _GroupBanList(
                  controller: _groupController,
                  groupId: _groupId,
                  onSubmit: () => setState(
                    () => _groupId = _groupController.text.trim(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _clearAll(BuildContext context) async {
    final strings = context.t;
    try {
      await ref.read(moderationActionsProvider).clearAll();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.moderation.cleared)),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(strings.common.error(error: error.toString())),
          ),
        );
      }
    }
  }
}

class _PlayerModerationList extends ConsumerWidget {
  const _PlayerModerationList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t;
    final moderations = ref.watch(playerModerationsProvider);
    return moderations.when(
      data: (items) => items.isEmpty
          ? Center(child: Text(strings.moderation.noPlayer))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: const Icon(AppIcons.block),
                  title: Text(item.targetDisplayName),
                  subtitle: Text(item.type.value),
                  trailing: IconButton(
                    tooltip: strings.moderation.remove,
                    icon: const Icon(AppIcons.delete_outline),
                    onPressed: () async {
                      await ref
                          .read(moderationActionsProvider)
                          .unmoderate(item);
                    },
                  ),
                );
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(strings.common.error(error: error.toString())),
      ),
    );
  }
}

class _GroupBanList extends ConsumerWidget {
  const _GroupBanList({
    required this.controller,
    required this.groupId,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final String groupId;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t;
    final bans = groupId.isEmpty ? null : ref.watch(groupBansProvider(groupId));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: strings.moderation.groupHint,
                    prefixIcon: const Icon(AppIcons.group),
                  ),
                  onSubmitted: (_) => onSubmit(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                tooltip: strings.moderation.loadBans,
                icon: const Icon(AppIcons.refresh),
                onPressed: onSubmit,
              ),
            ],
          ),
        ),
        Expanded(
          child: bans == null
              ? Center(child: Text(strings.moderation.enterGroup))
              : bans.when(
                  data: (items) => items.isEmpty
                      ? Center(child: Text(strings.moderation.noGroup))
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            final name = item.user?.displayName ?? item.userId;
                            return ListTile(
                              leading: const Icon(AppIcons.block),
                              title: Text(name),
                              subtitle: Text(item.userId),
                              trailing: IconButton(
                                tooltip: strings.moderation.unban,
                                icon: const Icon(AppIcons.lock_open),
                                onPressed: () async {
                                  await ref
                                      .read(groupActionsProvider)
                                      .unban(groupId, item.userId);
                                },
                              ),
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
