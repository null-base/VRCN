import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/theme/app_theme.dart';
import 'package:vrchat/utils/cache_manager.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart' hide NotificationType;

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  _NotificationFilter _selectedFilter = _NotificationFilter.all;

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(vrchatNotificationsProvider);
    final activityNotifications = ref.watch(localActivityNotificationsProvider);

    return notificationsAsync.when(
      data: (notifications) {
        final entries = _mergeNotifications(
          apiNotifications: notifications,
          activityNotifications: activityNotifications,
        );
        final filtered = _filterNotifications(entries);

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(vrchatNotificationsProvider);
            await ref.read(vrchatNotificationsProvider.future);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _NotificationToolbar(
                  selectedFilter: _selectedFilter,
                  entries: entries,
                  onFilterChanged: (filter) {
                    setState(() => _selectedFilter = filter);
                  },
                  onManageOnlineAlerts: _showFriendOnlineAlertDialog,
                ),
              ),
              if (filtered.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyNotifications(filter: _selectedFilter),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  sliver: SliverList.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return _NotificationTile(entry: filtered[index]);
                    },
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => LoadingIndicator(message: t.notifications.emptyTitle),
      error: (error, _) => ErrorContainer(
        message: t.common.error(error: error.toString()),
        onRetry: () => ref.invalidate(vrchatNotificationsProvider),
      ),
    );
  }

  List<_NotificationEntry> _mergeNotifications({
    required List<NotificationV2> apiNotifications,
    required List<NotificationItem> activityNotifications,
  }) {
    final entries = <_NotificationEntry>[
      for (final notification in apiNotifications)
        _NotificationEntry.api(notification),
      for (var index = 0; index < activityNotifications.length; index++)
        _NotificationEntry.activity(activityNotifications[index], index),
    ];

    return entries..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<_NotificationEntry> _filterNotifications(
    List<_NotificationEntry> entries,
  ) {
    return switch (_selectedFilter) {
      _NotificationFilter.unread =>
        entries.where((notification) => !notification.isRead).toList(),
      _NotificationFilter.read =>
        entries.where((notification) => notification.isRead).toList(),
      _NotificationFilter.all => entries,
    };
  }

  Future<void> _showFriendOnlineAlertDialog() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _FriendOnlineAlertSheet(),
    );
  }
}

enum _NotificationFilter { all, unread, read }

enum _NotificationEntrySource { api, activity }

class _NotificationEntry {
  const _NotificationEntry.api(this.apiNotification)
    : activityNotification = null,
      activityIndex = null,
      source = _NotificationEntrySource.api;

  const _NotificationEntry.activity(
    this.activityNotification,
    this.activityIndex,
  ) : apiNotification = null,
      source = _NotificationEntrySource.activity;

  final NotificationV2? apiNotification;
  final NotificationItem? activityNotification;
  final int? activityIndex;
  final _NotificationEntrySource source;

  bool get isActivity => source == _NotificationEntrySource.activity;
  bool get isRead => apiNotification?.seen ?? activityNotification!.isRead;
  bool get canDelete => apiNotification?.canDelete ?? true;
  DateTime get createdAt =>
      apiNotification?.createdAt ?? activityNotification!.timestamp;
  String get keyValue => apiNotification?.id ?? 'activity-$activityIndex';
}

class _NotificationToolbar extends StatelessWidget {
  const _NotificationToolbar({
    required this.selectedFilter,
    required this.entries,
    required this.onFilterChanged,
    required this.onManageOnlineAlerts,
  });

  final _NotificationFilter selectedFilter;
  final List<_NotificationEntry> entries;
  final ValueChanged<_NotificationFilter> onFilterChanged;
  final VoidCallback onManageOnlineAlerts;

  @override
  Widget build(BuildContext context) {
    final unreadCount = entries.where((item) => !item.isRead).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Row(
        children: [
          Expanded(
            child: _SegmentedFilter(
              selectedFilter: selectedFilter,
              unreadCount: unreadCount,
              onChanged: onFilterChanged,
            ),
          ),
          const SizedBox(width: 10),
          _IconPillButton(
            icon: Icons.person_pin_circle_outlined,
            label: t.notifications.onlineAlerts,
            onPressed: onManageOnlineAlerts,
          ),
        ],
      ),
    );
  }
}

class _SegmentedFilter extends StatelessWidget {
  const _SegmentedFilter({
    required this.selectedFilter,
    required this.unreadCount,
    required this.onChanged,
  });

  final _NotificationFilter selectedFilter;
  final int unreadCount;
  final ValueChanged<_NotificationFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outlineVariant;

    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          _SegmentButton(
            label: t.notifications.all,
            selected: selectedFilter == _NotificationFilter.all,
            onPressed: () => onChanged(_NotificationFilter.all),
          ),
          _SegmentButton(
            label: t.notifications.unread(count: unreadCount.toString()),
            selected: selectedFilter == _NotificationFilter.unread,
            onPressed: () => onChanged(_NotificationFilter.unread),
          ),
          _SegmentButton(
            label: t.notifications.read,
            selected: selectedFilter == _NotificationFilter.read,
            onPressed: () => onChanged(_NotificationFilter.read),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? theme.colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.notoSans(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _IconPillButton extends StatelessWidget {
  const _IconPillButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Container(
          height: 40,
          width: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.entry});

  final _NotificationEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final info = entry.isActivity
        ? _activityNotificationInfo(entry.activityNotification!)
        : _apiNotificationInfo(entry.apiNotification!);
    final apiNotification = entry.apiNotification;
    final vrchatApi = ref.watch(vrchatProvider).value;
    final headers = {'User-Agent': vrchatApi?.userAgent.toString() ?? 'VRCN'};
    final imageUrl = apiNotification?.imageUrl;

    return Dismissible(
      key: ValueKey(entry.keyValue),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await _markEntryAsRead(ref, entry);
          return false;
        }

        if (!entry.canDelete) {
          return false;
        }

        final confirmed = await _confirmDelete(context);
        if (!confirmed) return false;
        await _deleteEntry(ref, entry);
        return false;
      },
      background: const _DismissBackground(
        alignment: Alignment.centerLeft,
        color: AppTheme.successColor,
        icon: Icons.done,
      ),
      secondaryBackground: _DismissBackground(
        alignment: Alignment.centerRight,
        color: entry.canDelete
            ? AppTheme.dangerColor
            : theme.colorScheme.surfaceContainerHighest,
        icon: entry.canDelete ? Icons.delete_outline : Icons.lock_outline,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          await _markEntryAsRead(ref, entry);
          final senderId = apiNotification?.senderUserId;
          if (senderId != null && senderId.startsWith('usr_')) {
            if (context.mounted) {
              context.push('/user/$senderId');
            }
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: entry.isRead
                ? theme.colorScheme.surfaceContainerLow
                : AppTheme.primaryColor.withValues(
                    alpha: theme.brightness == Brightness.dark ? 0.18 : 0.08,
                  ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: entry.isRead
                  ? theme.colorScheme.outlineVariant
                  : AppTheme.primaryColor.withValues(alpha: 0.28),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NotificationAvatar(
                imageUrl: imageUrl,
                headers: headers,
                fallbackIcon: info.icon,
                color: info.color,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            info.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.notoSans(
                              fontSize: 15,
                              fontWeight: entry.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        if (!entry.isRead)
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      info.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSans(
                        fontSize: 13,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 4,
                      children: [
                        _MetaChip(
                          icon: Icons.schedule,
                          label: _formatRelativeTime(entry.createdAt),
                        ),
                        if (entry.isActivity)
                          _MetaChip(
                            icon: Icons.bolt_outlined,
                            label: t.notifications.activity,
                          ),
                        if (apiNotification?.senderUsername != null)
                          _MetaChip(
                            icon: Icons.person_outline,
                            label: apiNotification!.senderUsername!,
                          ),
                        if (apiNotification != null &&
                            apiNotification.category.isNotEmpty)
                          _MetaChip(
                            icon: Icons.label_outline,
                            label: apiNotification.category,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _markEntryAsRead(WidgetRef ref, _NotificationEntry entry) async {
    if (entry.isRead) return;
    if (entry.isActivity) {
      ref
          .read(localActivityNotificationsProvider.notifier)
          .markAsRead(entry.activityIndex!);
      return;
    }

    await ref
        .read(notificationActionsProvider)
        .markAsRead(entry.apiNotification!.id);
  }

  Future<void> _deleteEntry(WidgetRef ref, _NotificationEntry entry) async {
    if (entry.isActivity) {
      ref
          .read(localActivityNotificationsProvider.notifier)
          .removeAt(entry.activityIndex!);
      return;
    }

    await ref
        .read(notificationActionsProvider)
        .delete(entry.apiNotification!.id);
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.notifications.deleteConfirmTitle,
                    style: GoogleFonts.notoSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _DialogAction(
                        label: t.common.cancel,
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      const SizedBox(width: 8),
                      _DialogAction(
                        label: t.common.delete,
                        destructive: true,
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
  }
}

class _DialogAction extends StatelessWidget {
  const _DialogAction({
    required this.label,
    required this.onPressed,
    this.destructive = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppTheme.dangerColor : AppTheme.primaryColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _NotificationAvatar extends StatelessWidget {
  const _NotificationAvatar({
    required this.imageUrl,
    required this.headers,
    required this.fallbackIcon,
    required this.color,
  });

  final String? imageUrl;
  final Map<String, String> headers;
  final IconData fallbackIcon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 52,
        height: 52,
        child: url == null || url.isEmpty
            ? ColoredBox(
                color: color.withValues(alpha: 0.14),
                child: Icon(fallbackIcon, color: color),
              )
            : CachedNetworkImage(
                imageUrl: url,
                httpHeaders: headers,
                cacheManager: JsonCacheManager(),
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => ColoredBox(
                  color: color.withValues(alpha: 0.14),
                  child: Icon(fallbackIcon, color: color),
                ),
              ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 3),
        Text(
          label,
          style: GoogleFonts.notoSans(fontSize: 12, color: color),
        ),
      ],
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({
    required this.alignment,
    required this.color,
    required this.icon,
  });

  final Alignment alignment;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Icon(icon, color: color),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications({required this.filter});

  final _NotificationFilter filter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = switch (filter) {
      _NotificationFilter.unread => t.notifications.emptyUnread,
      _NotificationFilter.read => t.notifications.emptyRead,
      _NotificationFilter.all => t.notifications.emptyTitle,
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Icon(
                Icons.notifications_off_outlined,
                size: 34,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.notifications.emptyDescription,
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

class _FriendOnlineAlertSheet extends ConsumerWidget {
  const _FriendOnlineAlertSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(friendsProvider);
    final watchedIds = ref.watch(watchedFriendIdsProvider);
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.78,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: friendsAsync.when(
          data: (friends) {
            final sortedFriends = [...friends]
              ..sort((a, b) => a.displayName.compareTo(b.displayName));

            return Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.notifications.friendOnlineAlerts,
                          style: GoogleFonts.notoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        t.notifications.selectedCount(
                          count: watchedIds.length.toString(),
                        ),
                        style: GoogleFonts.notoSans(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: sortedFriends.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final friend = sortedFriends[index];
                      final selected = watchedIds.contains(friend.id);
                      return _FriendAlertRow(
                        name: friend.displayName,
                        isOnline: friend.location != 'offline',
                        selected: selected,
                        onTap: () {
                          ref
                              .read(watchedFriendIdsProvider.notifier)
                              .toggle(friend.id);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorContainer(
            message: t.common.error(error: error.toString()),
            onRetry: () => ref.invalidate(friendsProvider),
          ),
        ),
      ),
    );
  }
}

class _FriendAlertRow extends StatelessWidget {
  const _FriendAlertRow({
    required this.name,
    required this.isOnline,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final bool isOnline;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = isOnline ? AppTheme.successColor : Colors.grey;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primaryColor.withValues(alpha: 0.09)
              : theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? AppTheme.primaryColor.withValues(alpha: 0.34)
                : theme.colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.circle, size: 10, color: statusColor),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isOnline ? t.friends.online : t.friends.offline,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: selected ? AppTheme.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: selected
                      ? AppTheme.primaryColor
                      : theme.colorScheme.outline,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

({IconData icon, Color color, String title, String message})
_apiNotificationInfo(NotificationV2 notification) {
  final type = notification.type.value;
  final title = notification.title.isNotEmpty ? notification.title : type;
  final message = notification.message.isNotEmpty
      ? notification.message
      : [
          notification.senderUsername,
          notification.category,
          type,
        ].whereType<String>().where((value) => value.isNotEmpty).join(' - ');

  if (type.contains('friend') || type.contains('invite')) {
    return (
      icon: Icons.person_add_alt_1,
      color: AppTheme.infoColor,
      title: title,
      message: message,
    );
  }
  if (type.contains('group')) {
    return (
      icon: Icons.groups_outlined,
      color: AppTheme.accentColor,
      title: title,
      message: message,
    );
  }
  if (type.contains('event')) {
    return (
      icon: Icons.event_available_outlined,
      color: AppTheme.successColor,
      title: title,
      message: message,
    );
  }
  if (type.contains('moderation')) {
    return (
      icon: Icons.gavel_outlined,
      color: AppTheme.dangerColor,
      title: title,
      message: message,
    );
  }
  return (
    icon: Icons.notifications_none_outlined,
    color: AppTheme.primaryColor,
    title: title,
    message: message,
  );
}

({IconData icon, Color color, String title, String message})
_activityNotificationInfo(NotificationItem notification) {
  final worldName = notification.worldName ?? '';
  final extraData = notification.extraData ?? '';

  return switch (notification.type) {
    NotificationType.friendOnline => (
      icon: Icons.wifi_tethering,
      color: AppTheme.successColor,
      title: notification.userName,
      message: t.notifications.friendOnline(userName: notification.userName),
    ),
    NotificationType.friendOffline => (
      icon: Icons.wifi_off_outlined,
      color: Colors.grey,
      title: notification.userName,
      message: t.notifications.friendOffline(userName: notification.userName),
    ),
    NotificationType.friendActive => (
      icon: Icons.bolt_outlined,
      color: AppTheme.infoColor,
      title: notification.userName,
      message: t.notifications.friendActive(userName: notification.userName),
    ),
    NotificationType.friendAdd => (
      icon: Icons.person_add_alt_1,
      color: AppTheme.successColor,
      title: notification.userName,
      message: t.notifications.friendAdd(userName: notification.userName),
    ),
    NotificationType.friendRemove => (
      icon: Icons.person_remove_outlined,
      color: AppTheme.dangerColor,
      title: notification.userName,
      message: t.notifications.friendRemove(userName: notification.userName),
    ),
    NotificationType.statusUpdate => (
      icon: Icons.edit_note_outlined,
      color: AppTheme.infoColor,
      title: notification.userName,
      message: t.notifications.statusUpdate(
        userName: notification.userName,
        status: extraData,
        world: worldName.isEmpty ? '' : ' $worldName',
      ),
    ),
    NotificationType.locationChange => (
      icon: Icons.travel_explore,
      color: AppTheme.accentColor,
      title: notification.userName,
      message: t.notifications.locationChange(
        userName: notification.userName,
        worldName: worldName,
      ),
    ),
    NotificationType.myLocationChange => (
      icon: Icons.my_location,
      color: AppTheme.accentColor,
      title: notification.userName,
      message: t.notifications.myLocationChange(worldName: worldName),
    ),
    NotificationType.invite => (
      icon: Icons.mail_outline,
      color: AppTheme.primaryColor,
      title: notification.userName,
      message: t.notifications.invite(
        userName: notification.userName,
        worldName: worldName,
      ),
    ),
    NotificationType.friendRequest => (
      icon: Icons.person_add_alt_1,
      color: AppTheme.primaryColor,
      title: notification.userName,
      message: t.notifications.friendRequest(userName: notification.userName),
    ),
    NotificationType.requestInvite => (
      icon: Icons.login,
      color: AppTheme.primaryColor,
      title: notification.userName,
      message: t.notifications.requestInvite(userName: notification.userName),
    ),
    NotificationType.votekick => (
      icon: Icons.gavel_outlined,
      color: AppTheme.dangerColor,
      title: notification.userName,
      message: t.notifications.votekick(userName: notification.userName),
    ),
    NotificationType.responseReceived => (
      icon: Icons.mark_email_read_outlined,
      color: AppTheme.infoColor,
      title: notification.userName,
      message: t.notifications.responseReceived(
        userName: notification.userName,
      ),
    ),
    NotificationType.error => (
      icon: Icons.error_outline,
      color: AppTheme.dangerColor,
      title: notification.userName,
      message: t.notifications.error(worldName: worldName),
    ),
    NotificationType.userUpdate => (
      icon: Icons.manage_accounts_outlined,
      color: AppTheme.infoColor,
      title: notification.userName,
      message: t.notifications.userUpdate(
        world: worldName.isEmpty ? '' : ' $worldName',
      ),
    ),
    NotificationType.system => (
      icon: Icons.notifications_none_outlined,
      color: AppTheme.primaryColor,
      title: notification.userName,
      message: t.notifications.system(extraData: extraData),
    ),
  };
}

String _formatRelativeTime(DateTime time) {
  final now = DateTime.timestamp();
  final difference = now.difference(time);

  if (difference.inSeconds < 60) {
    return t.notifications.secondsAgo(seconds: difference.inSeconds.toString());
  }
  if (difference.inMinutes < 60) {
    return t.notifications.minutesAgo(minutes: difference.inMinutes.toString());
  }
  if (difference.inHours < 24) {
    return t.notifications.hoursAgo(hours: difference.inHours.toString());
  }
  return DateFormat('MM/dd HH:mm').format(time);
}
