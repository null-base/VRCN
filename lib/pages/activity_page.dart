import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/utils/app_icons.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/models/app_feature_models.dart';
import 'package:vrchat/provider/app_features_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/widgets/app_bar.dart';
import 'package:vrchat/widgets/app_drawer.dart';

class ActivityPage extends ConsumerStatefulWidget {
  const ActivityPage({super.key});

  @override
  ConsumerState<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends ConsumerState<ActivityPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.t;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: strings.activity.title,
        actions: [
          IconButton(
            tooltip: strings.activity.clearHistory,
            icon: const Icon(AppIcons.delete_outline),
            onPressed: () => ref.read(activityHistoryProvider.notifier).clear(),
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabs,
            tabs: [
              Tab(text: strings.activity.feed),
              Tab(text: strings.activity.friendLog),
              Tab(text: strings.activity.heatmap),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: const [
                _ActivityList(friendOnly: false),
                _ActivityList(friendOnly: true),
                _ActivityHeatmap(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityList extends ConsumerWidget {
  const _ActivityList({required this.friendOnly});
  final bool friendOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t;
    final records = ref
        .watch(activityHistoryProvider)
        .where((record) {
          if (!friendOnly) return true;
          return record.kind.startsWith('friend');
        })
        .toList(growable: false);
    final durations = ref.watch(activitySessionDurationsProvider);

    if (records.isEmpty) {
      return Center(child: Text(strings.activity.empty));
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: records.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final record = records[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.12),
              child: Icon(_iconFor(record.kind), color: AppTheme.primaryColor),
            ),
            title: Text(
              record.userName.isEmpty || record.userName == 'Unknown'
                  ? strings.profile.unknown
                  : record.userName,
            ),
            subtitle: Text(_subtitleFor(record, strings)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat.MMMd().add_Hm().format(record.timestamp),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                if (friendOnly && durations[record.userId] != null)
                  Text(
                    _formatDuration(durations[record.userId]!, strings),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
              ],
            ),
            onTap: record.userId.isEmpty
                ? null
                : () => context.push('/user/${record.userId}'),
          ),
        );
      },
    );
  }

  static IconData _iconFor(String kind) {
    return switch (kind) {
      'friendOnline' => AppIcons.wifi_rounded,
      'friendOffline' => AppIcons.wifi_off_rounded,
      'friendActive' => AppIcons.bolt_outlined,
      'friendAdd' => AppIcons.person_add,
      'friendRemove' => AppIcons.person_remove_outlined,
      'locationChange' => AppIcons.location_on,
      'statusUpdate' => AppIcons.edit_outlined,
      _ => AppIcons.notifications_outlined,
    };
  }

  static String _subtitleFor(ActivityRecord record, Translations strings) {
    final detail = record.worldName ?? record.detail ?? record.location;
    final kind = _kindLabel(record.kind, strings);
    if (detail == null || detail.isEmpty) return kind;
    return strings.activity.summary(kind: kind, detail: detail);
  }

  static String _formatDuration(Duration duration, Translations strings) {
    if (duration.inHours > 0) {
      return strings.activity.trackedHours(
        hours: duration.inHours.toString(),
        minutes: duration.inMinutes.remainder(60).toString(),
      );
    }
    return strings.activity.trackedMinutes(
      minutes: duration.inMinutes.toString(),
    );
  }

  static String _kindLabel(String kind, Translations strings) {
    return switch (kind) {
      'friendOnline' => strings.activity.kind.friendOnline,
      'friendOffline' => strings.activity.kind.friendOffline,
      'friendActive' => strings.activity.kind.friendActive,
      'friendAdd' => strings.activity.kind.friendAdd,
      'friendRemove' => strings.activity.kind.friendRemove,
      'locationChange' => strings.activity.kind.locationChange,
      'statusUpdate' => strings.activity.kind.statusUpdate,
      _ => strings.activity.kind.activity,
    };
  }
}

class _ActivityHeatmap extends ConsumerWidget {
  const _ActivityHeatmap();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = context.t;
    final heatmap = ref.watch(activityHeatmapProvider);
    final today = DateTime.now();
    final days = List.generate(
      42,
      (index) => DateTime(today.year, today.month, today.day - 41 + index),
    );
    final maxCount = heatmap.values.fold<int>(0, (max, value) {
      return value > max ? value : max;
    });

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          strings.activity.heatmapTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final count = heatmap[days[index]] ?? 0;
            final intensity = maxCount == 0 ? 0.0 : count / maxCount;
            return Tooltip(
              message: '${days[index].month}/${days[index].day}: $count',
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: count == 0
                      ? Theme.of(context).colorScheme.surfaceContainerHighest
                      : AppTheme.primaryColor.withValues(
                          alpha: 0.2 + intensity * 0.8,
                        ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
