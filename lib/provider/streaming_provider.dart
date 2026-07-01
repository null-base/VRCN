import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart' as vrc;
import 'package:vrchat/utils/app_logger.dart';

// ストリーミング接続の状態を管理するプロバイダー
final streamingStateProvider = StateProvider<bool>((ref) => false);

// ストリーミング接続を管理するクラス用のプロバイダー
final streamingControllerProvider = Provider<StreamingController>((ref) {
  return StreamingController(ref);
});

// ストリーミング接続を制御するクラス
class StreamingController {
  StreamingController(this.ref);
  final Ref ref;
  var _isInitialized = false;

  // ストリーミング接続を開始するメソッド
  Future<void> startConnection() async {
    if (_isInitialized) return;

    final vrchatAsync = ref.read(vrchatProvider);

    // AsyncValueから安全に値を取得
    final api = vrchatAsync.value;
    if (api == null) {
      appLogger.d('API接続が初期化されていないため、ストリーミングを開始できません');
      return;
    }

    try {
      // すでに接続中なら何もしない
      if (ref.read(streamingStateProvider)) return;

      // イベントリスナーを設定
      api.streaming.vrcEventStream.listen((event) {
        _handleVrcEvent(event, ref);
      });

      // ストリーミング接続を開始
      api.streaming.start();

      // 接続状態を更新（初期化後なので安全）
      ref.read(streamingStateProvider.notifier).state = true;
      _isInitialized = true;

      appLogger.d('VRChatストリーミング接続を開始しました');
    } catch (e) {
      appLogger.d('ストリーミング接続の開始に失敗しました: $e');
    }
  }

  // 接続を停止するメソッド
  void stopConnection() {
    final vrchatAsync = ref.read(vrchatProvider);
    final api = vrchatAsync.value;
    if (api != null) {
      try {
        api.streaming.stop();
        ref.read(streamingStateProvider.notifier).state = false;
        appLogger.d('VRChatストリーミング接続を停止しました');
      } catch (e) {
        appLogger.d('ストリーミング接続の停止に失敗しました: $e');
      }
    }
  }
}

// ストリーミングイベントハンドラー
Future<void> _handleVrcEvent(vrc.VrcStreamingEvent event, ref) async {
  // イベント受信のログ
  appLogger.d('======= VRC EVENT RECEIVED: ${event.type} =======');

  switch (event.type) {
    case vrc.VrcStreamingEventType.friendOnline:
      final friendOnlineEvent = event as vrc.FriendOnlineEvent;
      appLogger.d('フレンドオンライン: ${friendOnlineEvent.user.displayName}');

      ref.read(friendStateUpdaterProvider)(
        friendOnlineEvent.userId,
        isOnline: true,
      );

      // 通知を追加
      ref
          .read(notificationsProvider.notifier)
          .addNotification(
            NotificationItem(
              type: NotificationType.friendOnline,
              userName: friendOnlineEvent.user.displayName,
              timestamp: DateTime.timestamp(),
              isRead: false,
            ),
          );

    case vrc.VrcStreamingEventType.friendOffline:
      final friendOfflineEvent = event as vrc.FriendOfflineEvent;
      appLogger.d('フレンドオフライン: ${friendOfflineEvent.userId}');

      ref.read(friendStateUpdaterProvider)(
        friendOfflineEvent.userId,
        isOnline: false,
      );

      final friend = await ref.read(
        userDetailProvider(friendOfflineEvent.userId).future,
      );

      // 通知を追加
      ref
          .read(notificationsProvider.notifier)
          .addNotification(
            NotificationItem(
              type: NotificationType.friendOffline,
              userName: friend.displayName.toString(),
              timestamp: DateTime.timestamp(),
              isRead: false,
            ),
          );

    case vrc.VrcStreamingEventType.friendActive:
      final friendActiveEvent = event as vrc.FriendActiveEvent;
      appLogger.d('フレンドアクティブ: ${friendActiveEvent.user.displayName}');

      //通知の追加
      ref
          .read(notificationsProvider.notifier)
          .addNotification(
            NotificationItem(
              type: NotificationType.friendActive,
              userName: friendActiveEvent.user.displayName,
              timestamp: DateTime.timestamp(),
              isRead: false,
            ),
          );

    case vrc.VrcStreamingEventType.friendAdd:
      final friendAddEvent = event as vrc.FriendAddEvent;
      appLogger.d('フレンド追加: ${friendAddEvent.user.displayName}');

      ref.read(friendAddHandlerProvider)(friendAddEvent.userId);

      // 通知の追加
      ref
          .read(notificationsProvider.notifier)
          .addNotification(
            NotificationItem(
              type: NotificationType.friendAdd,
              userName: friendAddEvent.user.displayName,
              timestamp: DateTime.timestamp(),
              isRead: false,
            ),
          );

    case vrc.VrcStreamingEventType.friendDelete:
      final friendDeleteEvent = event as vrc.FriendDeleteEvent;
      appLogger.d('フレンド削除: ${friendDeleteEvent.userId}');

      ref.read(friendDeleteHandlerProvider)(friendDeleteEvent.userId);

      final friend = await ref.read(
        userDetailProvider(friendDeleteEvent.userId).future,
      );

      //通知の追加
      await ref
          .read(notificationsProvider.notifier)
          .addNotification(
            NotificationItem(
              type: NotificationType.friendRemove,
              userName: friend.displayName.toString(),
              timestamp: DateTime.timestamp(),
              isRead: false,
            ),
          );

    case vrc.VrcStreamingEventType.friendUpdate:
      final friendUpdateEvent = event as vrc.FriendUpdateEvent;
      appLogger.d('フレンド情報更新: ${friendUpdateEvent.user.displayName}');

      ref.read(friendInfoUpdaterProvider)(
        friendUpdateEvent.userId,
        status: friendUpdateEvent.user.status,
        statusDescription: friendUpdateEvent.user.statusDescription,
      );

      // 通知を追加
      ref
          .read(notificationsProvider.notifier)
          .addNotification(
            NotificationItem(
              type: NotificationType.statusUpdate,
              userName: friendUpdateEvent.user.displayName,
              worldName: friendUpdateEvent.user.statusDescription,
              timestamp: DateTime.timestamp(),
              isRead: false,
              extraData: friendUpdateEvent.user.status.toString(),
            ),
          );

    case vrc.VrcStreamingEventType.friendLocation:
      final friendLocationEvent = event as vrc.FriendLocationEvent;
      appLogger.d('フレンド位置変更: ${friendLocationEvent.user.displayName}');
      appLogger.d('ロケーション: ${friendLocationEvent.location}');

      ref.read(friendLocationUpdaterProvider)(
        friendLocationEvent.userId,
        friendLocationEvent.location ?? 'unknown',
        null,
      );

      String? worldName;

      if (friendLocationEvent.location != null &&
          friendLocationEvent.location != 'private' &&
          friendLocationEvent.location != 'traveling') {
        try {
          final location = await ref.read(
            instanceDetailProvider(
              friendLocationEvent.location.toString(),
            ).future,
          );
          worldName = location.world.name.toString();
        } catch (e) {
          appLogger.d('ワールド情報の取得に失敗: $e');
          worldName = 'Unknown World';
        }
      } else {
        worldName = friendLocationEvent.location.toString();
      }

      // フレンド位置変更通知
      await ref
          .read(notificationsProvider.notifier)
          .addNotification(
            NotificationItem(
              type: NotificationType.locationChange,
              userName: friendLocationEvent.user.displayName,
              worldName: worldName,
              timestamp: DateTime.timestamp(),
              isRead: false,
            ),
          );

    case vrc.VrcStreamingEventType.userUpdate:
      appLogger.d('詳細: ${jsonEncode(event)}');
      try {
        final userUpdateEvent = event as vrc.UserUpdateEvent;
        appLogger.d('ユーザー更新イベント: ${userUpdateEvent.user.displayName}');

        ref.refresh(currentUserProvider);

        // ユーザーのステータス情報を取得
        final status = userUpdateEvent.user.status;
        final statusDescription = userUpdateEvent.user.statusDescription;

        // フレンドリストの更新
        ref.read(friendInfoUpdaterProvider)(
          userUpdateEvent.userId,
          status: status,
          statusDescription: statusDescription,
        );
      } catch (e) {
        appLogger.d('UserUpdateEventの処理中にエラーが発生: $e');
        appLogger.d(
          '生データ: ${event is vrc.UnknownEvent ? event.rawString : "不明"}',
        );
      }

    case vrc.VrcStreamingEventType.userLocation:
      appLogger.d('詳細: ${jsonEncode(event)}');
      try {
        final userLocationEvent = event as vrc.UserLocationEvent;

        appLogger.d('ユーザー位置変更イベント: ${userLocationEvent.userId}');
        appLogger.d('新しい位置: ${userLocationEvent.location}');
      } catch (e) {
        appLogger.d('UserLocationEventの処理中にエラーが発生: $e');
        appLogger.d(
          '生データ: ${event is vrc.UnknownEvent ? event.rawString : "不明"}',
        );
      }

    case vrc.VrcStreamingEventType.notificationReceived:
      final notificationEvent = event as vrc.NotificationReceivedEvent;
      appLogger.d('通知受信: タイプ=${notificationEvent.notification.type}');
      appLogger.d('送信者: ${notificationEvent.notification.senderUserId}');

      ref.read(notificationHandlerProvider)(notificationEvent.notification);

      // 通知のタイプによって振り分け
      NotificationType notificationType;
      switch (notificationEvent.notification.type) {
        case vrc.NotificationType.friendRequest:
          notificationType = NotificationType.friendRequest;
        case vrc.NotificationType.invite:
          notificationType = NotificationType.invite;
        default:
          notificationType = NotificationType.friendOnline;
      }

      ref
          .read(notificationsProvider.notifier)
          .addNotification(
            NotificationItem(
              type: notificationType,
              userName:
                  // ignore: deprecated_member_use
                  notificationEvent.notification.senderUsername ?? 'Unknown',
              worldName: notificationEvent.notification.message,
              timestamp: DateTime.timestamp(),
              isRead: false,
            ),
          );

    case vrc.VrcStreamingEventType.notificationSeen:
      event as vrc.NotificationSeenEvent;
      appLogger.d('NotificationSeen : ${event.notificationId}');

    case vrc.VrcStreamingEventType.notificationResponse:
      appLogger.d('詳細: ${jsonEncode(event)}');

    case vrc.VrcStreamingEventType.notificationHide:
      appLogger.d('${event.type.name} ${jsonEncode(event)}');

    case vrc.VrcStreamingEventType.notificationClear:
      appLogger.d('詳細: NotificationClear');

    case vrc.VrcStreamingEventType.error:
      final errorEvent = event as vrc.ErrorEvent;
      appLogger.d('エラーイベント: ${errorEvent.message}');
      appLogger.d('詳細: ${jsonEncode(event)}');

    case vrc.VrcStreamingEventType.unknown:
      final unknownEvent = event as vrc.UnknownEvent;
      appLogger.d('不明なイベント');
      appLogger.d('詳細: ${unknownEvent.rawString}');
  }

  appLogger.d('=========================================');
}
