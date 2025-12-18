import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/theme/app_theme.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final _scrollController = ScrollController();
  var _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<NotificationItem> _getFilteredNotifications(
    List<NotificationItem> notifications,
  ) {
    switch (_selectedFilter) {
      case 'unread':
        return notifications.where((n) => !n.isRead).toList();
      case 'read':
        return notifications.where((n) => n.isRead).toList();
      default:
        return notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final notifications = ref.watch(notificationsProvider);
    final filteredNotifications = _getFilteredNotifications(notifications);

    // 未読通知の数をカウント
    final unreadCount = notifications.where((n) => !n.isRead).length;

    final backgroundColor =
        isDarkMode ? const Color(0xFF121212) : Colors.grey[50];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                backgroundColor:
                    isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:
                            isDarkMode
                                ? [
                                  AppTheme.primaryColor.withValues(alpha: .3),
                                  Colors.indigo.withValues(alpha: 0.2),
                                ]
                                : [
                                  AppTheme.primaryColor.withValues(alpha: 0.1),
                                  Colors.indigo.withValues(alpha: 0.05),
                                ],
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      const Icon(
                        Icons.notifications_active,
                        color: AppTheme.primaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '通知',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      if (unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                actions: [
                  // フィルターボタン
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.filter_list,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    onSelected: (value) {
                      setState(() {
                        _selectedFilter = value;
                      });
                    },
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: 'all',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.all_inclusive,
                                  size: 20,
                                  color:
                                      _selectedFilter == 'all'
                                          ? AppTheme.primaryColor
                                          : null,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'すべて',
                                  style: TextStyle(
                                    color:
                                        _selectedFilter == 'all'
                                            ? AppTheme.primaryColor
                                            : null,
                                    fontWeight:
                                        _selectedFilter == 'all'
                                            ? FontWeight.bold
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'unread',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mark_email_unread,
                                  size: 20,
                                  color:
                                      _selectedFilter == 'unread'
                                          ? AppTheme.primaryColor
                                          : null,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '未読 ($unreadCount)',
                                  style: TextStyle(
                                    color:
                                        _selectedFilter == 'unread'
                                            ? AppTheme.primaryColor
                                            : null,
                                    fontWeight:
                                        _selectedFilter == 'unread'
                                            ? FontWeight.bold
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'read',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mark_email_read,
                                  size: 20,
                                  color:
                                      _selectedFilter == 'read'
                                          ? AppTheme.primaryColor
                                          : null,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '既読',
                                  style: TextStyle(
                                    color:
                                        _selectedFilter == 'read'
                                            ? AppTheme.primaryColor
                                            : null,
                                    fontWeight:
                                        _selectedFilter == 'read'
                                            ? FontWeight.bold
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                  ),

                  // すべて既読ボタン
                  if (unreadCount > 0)
                    IconButton(
                      icon: Icon(
                        Icons.done_all,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                      tooltip: 'すべて既読にする',
                      onPressed: _showMarkAllAsReadDialog,
                    ),

                  // メニューボタン
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'clear_all':
                          _showClearAllDialog();
                        case 'settings':
                          // 通知設定画面への遷移
                          break;
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'clear_all',
                            child: Row(
                              children: [
                                Icon(Icons.clear_all, size: 20),
                                SizedBox(width: 8),
                                Text('すべて削除'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'settings',
                            child: Row(
                              children: [
                                Icon(Icons.settings, size: 20),
                                SizedBox(width: 8),
                                Text('通知設定'),
                              ],
                            ),
                          ),
                        ],
                  ),
                ],
              ),
            ],
        body: _buildBody(filteredNotifications, isDarkMode),
      ),
    );
  }

  Widget _buildBody(
    List<NotificationItem> filteredNotifications,
    bool isDarkMode,
  ) {
    // 通知がない場合は空の状態を表示
    if (filteredNotifications.isEmpty) {
      return _buildEmptyNotifications(isDarkMode);
    }

    return RefreshIndicator(
      onRefresh: () async {
        // リフレッシュ処理（実際の実装では通知を再取得）
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: filteredNotifications.length,
        itemBuilder: (context, index) {
          final notification = filteredNotifications[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(
                child: _buildNotificationItem(notification, index, isDarkMode),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(
    NotificationItem notification,
    int index,
    bool isDarkMode,
  ) {
    final notificationInfo = _getNotificationInfo(notification);
    final timeAgo = _getTimeAgo(notification.timestamp);

    return Dismissible(
      key: Key('notification_${notification.timestamp.millisecondsSinceEpoch}'),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.done, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // 左から右へのスワイプ：既読にする
          ref.read(notificationsProvider.notifier).markAsRead(index);
          return false; // アイテムを削除せず、既読マークのみ
        } else {
          // 右から左へのスワイプ：削除
          return await _showDeleteConfirmDialog();
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // 削除処理
          // 実際の実装では通知を削除する処理を追加
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:
              notification.isRead
                  ? (isDarkMode ? Colors.grey[850] : Colors.white)
                  : (isDarkMode ? Colors.grey[800] : Colors.blue[50]),
          border: Border.all(
            color:
                notification.isRead
                    ? Colors.transparent
                    : AppTheme.primaryColor.withValues(alpha: 0.3),
            width: notification.isRead ? 0 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          onTap: () {
            if (!notification.isRead) {
              ref.read(notificationsProvider.notifier).markAsRead(index);
            }
            // 通知タップ時の処理（詳細画面への遷移など）
          },
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: notificationInfo.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              notificationInfo.icon,
              color: notificationInfo.color,
              size: 24,
            ),
          ),
          title: Text(
            notificationInfo.message,
            style: GoogleFonts.notoSans(
              fontWeight:
                  notification.isRead ? FontWeight.normal : FontWeight.w600,
              fontSize: 14,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  timeAgo,
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              const SizedBox(height: 8),
              Icon(
                Icons.chevron_right,
                size: 16,
                color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  NotificationInfo _getNotificationInfo(NotificationItem notification) {
    switch (notification.type) {
      case NotificationType.friendRequest:
        return NotificationInfo(
          icon: Icons.person_add,
          color: Colors.blue,
          message: t.notifications.friendRequest(
            userName: notification.userName,
          ),
        );
      case NotificationType.invite:
        return NotificationInfo(
          icon: Icons.insert_invitation,
          color: Colors.green,
          message: t.notifications.invite(
            userName: notification.userName,
            worldName: notification.worldName ?? 'ワールド',
          ),
        );
      case NotificationType.friendOnline:
        return NotificationInfo(
          icon: Icons.login,
          color: Colors.amber,
          message: t.notifications.friendOnline(
            userName: notification.userName,
          ),
        );
      case NotificationType.friendOffline:
        return NotificationInfo(
          icon: Icons.logout,
          color: Colors.grey,
          message: t.notifications.friendOffline(
            userName: notification.userName,
          ),
        );
      case NotificationType.friendActive:
        return NotificationInfo(
          icon: Icons.schedule,
          color: Colors.teal,
          message: t.notifications.friendActive(
            userName: notification.userName,
          ),
        );
      case NotificationType.friendAdd:
        return NotificationInfo(
          icon: Icons.person_add_alt_1,
          color: Colors.indigo,
          message: t.notifications.friendAdd(userName: notification.userName),
        );
      case NotificationType.friendRemove:
        return NotificationInfo(
          icon: Icons.person_remove,
          color: Colors.red,
          message: t.notifications.friendRemove(
            userName: notification.userName,
          ),
        );
      case NotificationType.statusUpdate:
        final status = notification.extraData ?? t.worldDetail.unknown;
        final world =
            (notification.worldName != null &&
                    notification.worldName!.isNotEmpty)
                ? ' (${notification.worldName})'
                : '';
        return NotificationInfo(
          icon: Icons.update,
          color: Colors.purple,
          message: t.notifications.statusUpdate(
            userName: notification.userName,
            status: status,
            world: world,
          ),
        );
      case NotificationType.locationChange:
        return NotificationInfo(
          icon: Icons.location_on,
          color: Colors.orange,
          message: t.notifications.locationChange(
            userName: notification.userName,
            worldName: notification.worldName ?? t.worldDetail.unknown,
          ),
        );
      case NotificationType.userUpdate:
        final world =
            (notification.worldName != null &&
                    notification.worldName!.isNotEmpty)
                ? ': ${notification.worldName}'
                : '';
        return NotificationInfo(
          icon: Icons.person_outline,
          color: Colors.cyan,
          message: t.notifications.userUpdate(world: world),
        );
      case NotificationType.myLocationChange:
        return NotificationInfo(
          icon: Icons.my_location,
          color: Colors.deepOrange,
          message: t.notifications.myLocationChange(
            worldName: notification.worldName ?? t.worldDetail.unknown,
          ),
        );
      case NotificationType.requestInvite:
        return NotificationInfo(
          icon: Icons.directions_run,
          color: Colors.lightGreen,
          message: t.notifications.requestInvite(
            userName: notification.userName,
          ),
        );
      case NotificationType.votekick:
        return NotificationInfo(
          icon: Icons.gavel,
          color: Colors.red,
          message: t.notifications.votekick(userName: notification.userName),
        );
      case NotificationType.responseReceived:
        return NotificationInfo(
          icon: Icons.feedback,
          color: Colors.blueGrey,
          message: t.notifications.responseReceived(
            userName: notification.userName,
          ),
        );
      case NotificationType.error:
        return NotificationInfo(
          icon: Icons.error_outline,
          color: Colors.red,
          message: t.notifications.error(
            worldName: notification.worldName ?? '',
          ),
        );
      case NotificationType.system:
        return NotificationInfo(
          icon: Icons.info_outline,
          color: Colors.grey,
          message: t.notifications.system(
            extraData: notification.extraData ?? '',
          ),
        );
    }
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.timestamp();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return t.notifications.secondsAgo(
        seconds: difference.inSeconds.toString(),
      );
    } else if (difference.inMinutes < 60) {
      return t.notifications.minutesAgo(
        minutes: difference.inMinutes.toString(),
      );
    } else if (difference.inHours < 24) {
      return t.notifications.hoursAgo(hours: difference.inHours.toString());
    } else {
      final formatter = DateFormat('MM/dd HH:mm');
      return formatter.format(time);
    }
  }

  Widget _buildEmptyNotifications(bool isDarkMode) {
    String title;
    String description;
    IconData icon;

    switch (_selectedFilter) {
      case 'unread':
        title = '未読の通知はありません';
        description = 'すべての通知を確認済みです';
        icon = Icons.mark_email_read;
      case 'read':
        title = '既読の通知はありません';
        description = 'まだ通知を確認していません';
        icon = Icons.mark_email_unread;
      default:
        title = t.notifications.emptyTitle;
        description = t.notifications.emptyDescription;
        icon = Icons.notifications_off_outlined;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 60,
                    color: AppTheme.primaryColor.withValues(alpha: 0.7),
                  ),
                )
                .animate()
                .scale(duration: 600.ms, curve: Curves.elasticOut)
                .fade(duration: 400.ms),
            const SizedBox(height: 32),
            Text(
                  title,
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                )
                .animate(delay: 200.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.3, end: 0),
            const SizedBox(height: 12),
            Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                    height: 1.5,
                  ),
                )
                .animate(delay: 400.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }

  Future<void> _showMarkAllAsReadDialog() async {
    final shouldMarkAsRead = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('すべて既読にする'),
            content: const Text('すべての未読通知を既読状態にしますか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('キャンセル'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('既読にする'),
              ),
            ],
          ),
    );

    if (shouldMarkAsRead == true) {
      ref.read(notificationsProvider.notifier).markAllAsRead();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('すべての通知を既読にしました'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Future<void> _showClearAllDialog() async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('すべて削除'),
            content: const Text('すべての通知を削除しますか？この操作は元に戻せません。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('キャンセル'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('削除'),
              ),
            ],
          ),
    );

    if (shouldClear == true) {
      ref.read(notificationsProvider.notifier).clearAll();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('すべての通知を削除しました'),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Future<bool> _showDeleteConfirmDialog() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('通知を削除'),
            content: const Text('この通知を削除しますか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('キャンセル'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('削除'),
              ),
            ],
          ),
    );

    return shouldDelete ?? false;
  }
}

// 通知情報を格納するヘルパークラス
class NotificationInfo {
  final IconData icon;
  final Color color;
  final String message;

  const NotificationInfo({
    required this.icon,
    required this.color,
    required this.message,
  });
}

// 既存のenum・クラスは変更なし
enum NotificationType {
  friendRequest,
  invite,
  friendOnline,
  friendOffline,
  friendActive,
  friendAdd,
  friendRemove,
  statusUpdate,
  locationChange,
  userUpdate,
  myLocationChange,
  requestInvite,
  votekick,
  responseReceived,
  error,
  system,
}

@immutable
class NotificationItem {
  final NotificationType type;
  final String userName;
  final String? worldName;
  final DateTime timestamp;
  final bool isRead;
  final String? extraData;

  const NotificationItem({
    required this.type,
    required this.userName,
    this.worldName,
    required this.timestamp,
    required this.isRead,
    this.extraData,
  });
}
