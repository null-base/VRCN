import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/models/app_feature_models.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/provider/app_features_provider.dart';
import 'package:vrchat/utils/app_icons.dart';
import 'package:vrchat/widgets/app_bar.dart';
import 'package:vrchat/widgets/app_drawer.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class FeatureHubPage extends ConsumerStatefulWidget {
  const FeatureHubPage({super.key});

  @override
  ConsumerState<FeatureHubPage> createState() => _FeatureHubPageState();
}

class _FeatureHubPageState extends ConsumerState<FeatureHubPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _groupController = TextEditingController();
  final _worldController = TextEditingController();
  String _groupId = '';
  String _worldId = '';
  var _groupTab = 0;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _groupController.dispose();
    _worldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.t;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(title: strings.tools.title),
      body: Column(
        children: [
          TabBar(
            controller: _tabs,
            isScrollable: true,
            tabs: [
              Tab(text: strings.tools.groups),
              Tab(text: strings.tools.myAvatars),
              Tab(text: strings.tools.status),
              Tab(text: strings.tools.data),
              Tab(text: strings.tools.server),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _buildGroups(context),
                _buildAssets(context),
                _buildStatus(context),
                _buildData(context),
                _buildServer(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroups(BuildContext context) {
    final strings = context.t;
    final members = _groupId.isEmpty
        ? null
        : ref.watch(groupMembersProvider(_groupId));
    final bans = _groupId.isEmpty
        ? null
        : ref.watch(groupBansProvider(_groupId));
    final events = _groupId.isEmpty
        ? null
        : ref.watch(groupCalendarEventsProvider(_groupId));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _groupController,
                  decoration: InputDecoration(
                    hintText: strings.tools.groupHint,
                    prefixIcon: const Icon(AppIcons.group),
                  ),
                  onSubmitted: (_) => _loadGroup(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                tooltip: strings.tools.loadGroup,
                icon: const Icon(AppIcons.refresh),
                onPressed: _loadGroup,
              ),
            ],
          ),
        ),
        if (_groupId.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () => _runGroupAction(
                      () => ref.read(groupActionsProvider).join(_groupId),
                    ),
                    icon: const Icon(AppIcons.group_add),
                    label: Text(strings.tools.join),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _runGroupAction(
                      () => ref.read(groupActionsProvider).leave(_groupId),
                    ),
                    icon: const Icon(AppIcons.person_remove_outlined),
                    label: Text(strings.tools.leave),
                  ),
                ),
              ],
            ),
          ),
        if (_groupId.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: SegmentedButton<int>(
              segments: [
                ButtonSegment(value: 0, label: Text(strings.tools.members)),
                ButtonSegment(value: 1, label: Text(strings.tools.bans)),
                ButtonSegment(value: 2, label: Text(strings.tools.calendar)),
              ],
              selected: {_groupTab},
              onSelectionChanged: (selection) {
                setState(() => _groupTab = selection.first);
              },
            ),
          ),
        Expanded(
          child: _groupId.isEmpty
              ? Center(child: Text(strings.tools.enterGroup))
              : switch (_groupTab) {
                  0 => _buildMembers(members),
                  1 => _buildBans(bans),
                  _ => _buildCalendar(events),
                },
        ),
      ],
    );
  }

  Widget _buildMembers(AsyncValue<List<GroupMember>>? members) {
    final strings = context.t;
    if (members == null) return const SizedBox.shrink();
    return members.when(
      data: (items) => items.isEmpty
          ? Center(child: Text(strings.tools.noMembers))
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final member = items[index];
                final name = member.user?.displayName ?? member.userId;
                return ListTile(
                  leading: const Icon(AppIcons.person),
                  title: Text(name),
                  subtitle: Text(member.userId),
                  trailing: IconButton(
                    tooltip: strings.tools.banMember,
                    icon: const Icon(AppIcons.block),
                    onPressed: () => _runGroupAction(
                      () => ref
                          .read(groupActionsProvider)
                          .ban(_groupId, member.userId),
                    ),
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

  Widget _buildBans(AsyncValue<List<GroupMember>>? bans) {
    final strings = context.t;
    if (bans == null) return const SizedBox.shrink();
    return bans.when(
      data: (items) => items.isEmpty
          ? Center(child: Text(strings.tools.noGroupBans))
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final member = items[index];
                return ListTile(
                  leading: const Icon(AppIcons.block),
                  title: Text(member.user?.displayName ?? member.userId),
                  subtitle: Text(member.userId),
                  trailing: IconButton(
                    tooltip: strings.tools.unbanMember,
                    icon: const Icon(AppIcons.lock_open),
                    onPressed: () => _runGroupAction(
                      () => ref
                          .read(groupActionsProvider)
                          .unban(_groupId, member.userId),
                    ),
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

  Widget _buildCalendar(AsyncValue<List<CalendarEvent>>? events) {
    final strings = context.t;
    if (events == null) return const SizedBox.shrink();
    return events.when(
      data: (items) => items.isEmpty
          ? Center(child: Text(strings.tools.noCalendar))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final event = items[index];
                final following = event.userInterest?.isFollowing ?? false;
                return ListTile(
                  leading: const Icon(AppIcons.event_available),
                  title: Text(event.title),
                  subtitle: Text(
                    '${event.startsAt.toLocal()} - ${event.endsAt.toLocal()}',
                  ),
                  trailing: IconButton(
                    tooltip: following
                        ? strings.tools.unfollowEvent
                        : strings.tools.followEvent,
                    icon: Icon(
                      following
                          ? AppIcons.notifications_active
                          : AppIcons.notifications_none_outlined,
                    ),
                    onPressed: () => _runGroupAction(
                      () => ref
                          .read(groupActionsProvider)
                          .followCalendarEvent(
                            _groupId,
                            event.id,
                            !following,
                          ),
                    ),
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

  Widget _buildAssets(BuildContext context) {
    final strings = context.t;
    final avatars = ref.watch(ownAvatarsManagementProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Text(
          strings.tools.ownAvatars,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        avatars.when(
          data: (items) => items.isEmpty
              ? Text(strings.tools.noOwnAvatars)
              : Column(
                  children: [
                    for (final avatar in items)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(AppIcons.face_rounded),
                        title: Text(avatar.name),
                        subtitle: Text(avatar.id),
                        trailing: IconButton(
                          tooltip: strings.tools.editAvatar,
                          icon: const Icon(AppIcons.edit_outlined),
                          onPressed: () => _editAvatar(avatar),
                        ),
                      ),
                  ],
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(
            strings.common.error(error: error.toString()),
          ),
        ),
        const Divider(height: 32),
        Text(
          strings.tools.worldMetadata,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          strings.tools.worldId,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _worldController,
          decoration: InputDecoration(
            hintText: strings.tools.worldHint,
            prefixIcon: const Icon(AppIcons.public_outlined),
          ),
          onSubmitted: (_) => _loadWorld(),
        ),
        const SizedBox(height: 8),
        FilledButton.tonalIcon(
          onPressed: _worldId.isEmpty ? _loadWorld : () => _editWorld(_worldId),
          icon: Icon(
            _worldId.isEmpty ? AppIcons.search : AppIcons.edit_outlined,
          ),
          label: Text(
            _worldId.isEmpty
                ? strings.tools.loadWorld
                : strings.tools.editWorldMetadata,
          ),
        ),
        if (_worldId.isNotEmpty)
          Text(
            strings.tools.worldPermissionHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }

  Widget _buildStatus(BuildContext context) {
    final strings = context.t;
    final presets = ref.watch(statusPresetsProvider);
    final automation = ref.watch(statusAutomationProvider);
    final friends =
        ref.watch(friendsProvider).asData?.value ?? const <LimitedUser>[];
    final selectedIndex = presets.isEmpty
        ? 0
        : automation.presetIndex < 0
        ? 0
        : automation.presetIndex >= presets.length
        ? presets.length - 1
        : automation.presetIndex;
    final names = ref.watch(discordNamesProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                strings.tools.statusPresets,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              tooltip: strings.tools.addPreset,
              icon: const Icon(AppIcons.add),
              onPressed: _addStatusPreset,
            ),
          ],
        ),
        for (final preset in presets)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(AppIcons.mood),
            title: Text(_presetName(preset, strings)),
            subtitle: Text(
              '${_localizedStatus(preset.status, strings)} ${preset.description}',
            ),
            trailing: Wrap(
              spacing: 4,
              children: [
                IconButton(
                  tooltip: strings.tools.applyPreset,
                  icon: const Icon(AppIcons.check),
                  onPressed: () => _applyPreset(preset),
                ),
                IconButton(
                  tooltip: strings.tools.deletePreset,
                  icon: const Icon(AppIcons.delete_outline),
                  onPressed: () =>
                      ref.read(statusPresetsProvider.notifier).remove(preset),
                ),
              ],
            ),
          ),
        const Divider(height: 32),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: Text(strings.tools.applyPresetOnLogin),
          subtitle: Text(strings.tools.restoreStatus),
          value: automation.enabled,
          onChanged: (value) =>
              ref.read(statusAutomationProvider.notifier).setEnabled(value),
        ),
        if (presets.isNotEmpty)
          DropdownButtonFormField<int>(
            value: selectedIndex,
            decoration: InputDecoration(
              labelText: strings.tools.automaticPreset,
            ),
            items: [
              for (var index = 0; index < presets.length; index++)
                DropdownMenuItem(
                  value: index,
                  child: Text(_presetName(presets[index], strings)),
                ),
            ],
            onChanged: (value) {
              if (value != null) {
                ref
                    .read(statusAutomationProvider.notifier)
                    .setPresetIndex(value);
              }
            },
          ),
        const Divider(height: 32),
        Row(
          children: [
            Expanded(
              child: Text(
                strings.tools.discordNames,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              tooltip: strings.tools.scanFriendProfiles,
              icon: const Icon(AppIcons.refresh),
              onPressed: () =>
                  ref.read(discordNamesProvider.notifier).scan(friends),
            ),
            IconButton(
              tooltip: strings.tools.exportDiscordNames,
              icon: const Icon(AppIcons.share),
              onPressed: () => _shareDiscordNames(names),
            ),
          ],
        ),
        if (names.isEmpty)
          Text(strings.tools.noLinkedNames)
        else
          for (final entry in names.entries)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(AppIcons.link),
              title: Text(entry.value),
              subtitle: Text(entry.key),
            ),
      ],
    );
  }

  Widget _buildData(BuildContext context) {
    final strings = context.t;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(AppIcons.storage_outlined),
          title: Text(strings.tools.dataTransfer),
          subtitle: Text(strings.tools.dataTransferDescription),
        ),
        FilledButton.icon(
          onPressed: _exportData,
          icon: const Icon(AppIcons.share),
          label: Text(strings.tools.exportData),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _importData,
          icon: const Icon(AppIcons.download),
          label: Text(strings.tools.importData),
        ),
        const SizedBox(height: 24),
        Text(strings.tools.dataExportHint),
      ],
    );
  }

  Widget _buildServer(BuildContext context) {
    final strings = context.t;
    final status = ref.watch(apiServerStatusProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(apiServerStatusProvider),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        children: [
          status.when(
            data: (value) => Card(
              child: ListTile(
                leading: Icon(
                  value.ok ? AppIcons.check_circle : AppIcons.error,
                  color: value.ok ? Colors.green : Colors.red,
                ),
                title: Text(
                  value.ok
                      ? strings.tools.apiOnline
                      : strings.tools.apiDegraded,
                ),
                subtitle: Text('${value.serverName}\n${value.version}'),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Card(
              child: ListTile(
                leading: const Icon(AppIcons.warning_amber_rounded),
                title: Text(strings.tools.apiUnavailable),
                subtitle: Text(strings.common.error(error: error.toString())),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(strings.tools.serverRefreshHint),
        ],
      ),
    );
  }

  void _loadGroup() {
    final value = _groupController.text.trim();
    if (value.isEmpty) return;
    setState(() {
      _groupId = value;
      _groupTab = 0;
    });
  }

  void _loadWorld() {
    final value = _worldController.text.trim();
    if (value.isEmpty) return;
    setState(() => _worldId = value);
  }

  String _presetName(StatusPreset preset, Translations strings) {
    return switch (preset.name) {
      'Available' => strings.tools.statusAvailable,
      'Ask me' => strings.tools.statusAskMe,
      'Busy' => strings.tools.statusBusy,
      'Join me' => strings.tools.statusJoinMe,
      _ => preset.name,
    };
  }

  String _localizedStatus(String status, Translations strings) {
    return switch (status) {
      'active' => strings.status.active,
      'ask me' => strings.status.askMe,
      'busy' => strings.status.busy,
      'join me' => strings.status.joinMe,
      'offline' => strings.status.offline,
      _ => status,
    };
  }

  Future<void> _runGroupAction(Future<void> Function() action) async {
    final strings = context.t;
    try {
      await action();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.tools.groupActionCompleted)),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(strings.common.error(error: error.toString())),
          ),
        );
      }
    }
  }

  Future<void> _editAvatar(Avatar avatar) async {
    final strings = context.t;
    final name = TextEditingController(text: avatar.name);
    final description = TextEditingController(text: avatar.description);
    final tags = TextEditingController(text: avatar.tags.join(', '));
    final save = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.tools.editAvatarDialog),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(labelText: strings.tools.name),
              ),
              TextField(
                controller: description,
                decoration: InputDecoration(
                  labelText: strings.tools.description,
                ),
                maxLines: 4,
              ),
              TextField(
                controller: tags,
                decoration: InputDecoration(
                  labelText: strings.tools.tags,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(strings.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.common.save),
          ),
        ],
      ),
    );
    if (save != true) return;
    await _runGroupAction(
      () => ref
          .read(assetManagementActionsProvider)
          .updateAvatar(
            avatarId: avatar.id,
            name: name.text.trim(),
            description: description.text.trim(),
            tags: tags.text
                .split(',')
                .map((tag) => tag.trim())
                .where((tag) => tag.isNotEmpty)
                .toList(growable: false),
          ),
    );
    name.dispose();
    description.dispose();
    tags.dispose();
  }

  Future<void> _editWorld(String worldId) async {
    final strings = context.t;
    final name = TextEditingController();
    final description = TextEditingController();
    final capacity = TextEditingController();
    final tags = TextEditingController();
    final save = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.tools.editWorldDialog),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(labelText: strings.tools.name),
              ),
              TextField(
                controller: description,
                decoration: InputDecoration(
                  labelText: strings.tools.description,
                ),
                maxLines: 4,
              ),
              TextField(
                controller: capacity,
                decoration: InputDecoration(labelText: strings.tools.capacity),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: tags,
                decoration: InputDecoration(
                  labelText: strings.tools.tags,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(strings.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(strings.common.save),
          ),
        ],
      ),
    );
    if (save != true) return;
    await _runGroupAction(
      () => ref
          .read(assetManagementActionsProvider)
          .updateWorld(
            worldId: worldId,
            name: name.text.trim().isEmpty ? null : name.text.trim(),
            description: description.text.trim().isEmpty
                ? null
                : description.text.trim(),
            capacity: int.tryParse(capacity.text.trim()),
            tags: tags.text
                .split(',')
                .map((tag) => tag.trim())
                .where((tag) => tag.isNotEmpty)
                .toList(growable: false),
          ),
    );
    name.dispose();
    description.dispose();
    capacity.dispose();
    tags.dispose();
  }

  Future<void> _addStatusPreset() async {
    final strings = context.t;
    final name = TextEditingController();
    final description = TextEditingController();
    var status = UserStatus.active;
    final save = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(strings.tools.newStatusPreset),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(labelText: strings.tools.name),
              ),
              DropdownButtonFormField<UserStatus>(
                value: status,
                items: [
                  for (final value in UserStatus.values)
                    DropdownMenuItem(
                      value: value,
                      child: Text(_localizedStatus(value.value, strings)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) setDialogState(() => status = value);
                },
                decoration: InputDecoration(labelText: strings.tools.status),
              ),
              TextField(
                controller: description,
                decoration: InputDecoration(
                  labelText: strings.tools.description,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(strings.common.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(strings.common.save),
            ),
          ],
        ),
      ),
    );
    if (save == true && name.text.trim().isNotEmpty) {
      await ref
          .read(statusPresetsProvider.notifier)
          .save(
            StatusPreset(
              name: name.text.trim(),
              status: status.value,
              description: description.text.trim(),
            ),
          );
    }
    name.dispose();
    description.dispose();
  }

  Future<void> _applyPreset(StatusPreset preset) async {
    await _runGroupAction(
      () => ref.read(statusPresetsProvider.notifier).apply(preset, ref),
    );
  }

  Future<void> _shareDiscordNames(Map<String, String> names) async {
    final strings = context.t;
    await SharePlus.instance.share(
      ShareParams(
        subject: strings.tools.discordNames,
        text: const JsonEncoder.withIndent('  ').convert(names),
      ),
    );
  }

  Future<void> _exportData() async {
    final strings = context.t;
    final payload = ref
        .read(dataTransferServiceProvider)
        .exportLocalData(
          activity: ref.read(activityHistoryProvider),
          presets: ref.read(statusPresetsProvider),
          watchedFriends: ref.read(watchedFriendIdsProvider),
          discordNames: ref.read(discordNamesProvider),
        );
    await SharePlus.instance.share(
      ShareParams(
        subject: strings.tools.dataTransfer,
        text: const JsonEncoder.withIndent('  ').convert(payload),
      ),
    );
  }

  Future<void> _importData() async {
    final strings = context.t;
    final controller = TextEditingController();
    final source = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.tools.importData),
        content: TextField(
          controller: controller,
          maxLines: 12,
          decoration: InputDecoration(
            hintText: strings.tools.pasteExport,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(strings.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(strings.tools.importData),
          ),
        ],
      ),
    );
    controller.dispose();
    if (source == null || source.trim().isEmpty) return;
    try {
      await ref
          .read(dataTransferServiceProvider)
          .importLocalData(
            source,
            activityNotifier: ref.read(activityHistoryProvider.notifier),
            statusNotifier: ref.read(statusPresetsProvider.notifier),
            watchedNotifier: ref.read(watchedFriendIdsProvider.notifier),
            discordNotifier: ref.read(discordNamesProvider.notifier),
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.tools.dataImported)),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(strings.tools.importFailed(error: error.toString())),
          ),
        );
      }
    }
  }
}
