import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/provider/favorite_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/router/app_router.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

// フレンド表示フィルター用の列挙型
enum FriendFilter {
  all, // すべてのフレンド
  online, // オンラインのみ
  offline, // オフラインのみ
  favorite, // お気に入りのみ
}

// 現在のフィルター状態を管理するプロバイダー
final friendFilterProvider = StateProvider<FriendFilter>(
  (ref) => FriendFilter.all,
);

// フレンドリストをAsyncNotifierProviderとして再定義
final friendsProvider =
    AsyncNotifierProvider<FriendsNotifier, List<LimitedUser>>(
      FriendsNotifier.new,
    );

// フレンドリストを管理するNotifier
class FriendsNotifier extends AsyncNotifier<List<LimitedUser>> {
  @override
  Future<List<LimitedUser>> build() async {
    return await _loadFriends();
  }

  // フレンドデータをロードするメソッド
  Future<List<LimitedUser>> _loadFriends() async {
    try {
      // 認証状態を確認 - ログインしていない場合は空リストを返す
      final authState = await ref.watch(authStateProvider.future);
      if (!authState) {
        debugPrint('ログインしていないため、フレンドリストは空です');
        return [];
      }

      // API取得を確認
      final rawApi = await ref.watch(vrchatRawApiProvider);

      // currentUserを確認（ログイン完了の確実な判断）
      final auth = await ref.watch(vrchatAuthProvider.future);
      if (auth.currentUser == null) {
        debugPrint('現在のユーザー情報がnullです - ログインが完全に完了していません');
        return [];
      }

      final filter = ref.watch(friendFilterProvider);
      final allFriends = <LimitedUser>[];

      // オンラインフレンド取得（filter.all または filter.online の場合）
      if (filter == FriendFilter.all || filter == FriendFilter.online) {
        try {
          final onlineFriends = <LimitedUser>[];
          var offset = 0;
          var hasMore = true;

          // offsetを使ってすべてのオンラインフレンドを取得
          while (hasMore) {
            final (friendsSuccess, friendsFailure) =
                await rawApi
                    .getFriendsApi()
                    .getFriends(offline: false, n: 100, offset: offset)
                    .validateVrc();

            if (friendsSuccess == null) {
              debugPrint('オンラインフレンド取得でnull結果: $friendsFailure');
              break;
            }

            final batch = friendsSuccess.data;
            // LimitedUserFriend から LimitedUser に変換
            final convertedBatch = batch.map(_convertToLimitedUser).toList();
            onlineFriends.addAll(convertedBatch);

            if (batch.length < 100) {
              hasMore = false;
            } else {
              offset += 100;
            }
          }

          allFriends.addAll(onlineFriends);
          debugPrint('オンラインフレンド: ${onlineFriends.length}人');
        } catch (e) {
          debugPrint('オンラインフレンド取得エラー: $e');
          // エラーがあっても処理を続行（オフラインフレンドは取得できる可能性あり）
        }
      }

      // オフラインフレンド取得（filter.all または filter.offline の場合）
      if (filter == FriendFilter.all || filter == FriendFilter.offline) {
        try {
          final offlineFriends = <LimitedUser>[];
          var offset = 0;
          var hasMore = true;

          // offsetを使ってすべてのオフラインフレンドを取得
          while (hasMore) {
            final (friendsSuccess, friendsFailure) =
                await rawApi
                    .getFriendsApi()
                    .getFriends(offline: true, n: 100, offset: offset)
                    .validateVrc();

            if (friendsSuccess == null) {
              debugPrint('オフラインフレンド取得でnull結果: $friendsFailure');
              break;
            }

            final batch = friendsSuccess.data;
            // LimitedUserFriend から LimitedUser に変換
            final convertedBatch = batch.map(_convertToLimitedUser).toList();
            offlineFriends.addAll(convertedBatch);

            // 100件未満なら終了、そうでなければ次の100件を取得
            if (batch.length < 100) {
              hasMore = false;
            } else {
              offset += 100;
            }
          }

          allFriends.addAll(offlineFriends);
          debugPrint('オフラインフレンド: ${offlineFriends.length}人');
        } catch (e) {
          debugPrint('オフラインフレンド取得エラー: $e');
        }
      }

      // --- お気に入りのみ ---
      if (filter == FriendFilter.favorite) {
        // すべてのフレンドを取得
        final allFriends = <LimitedUser>[];

        // オンライン
        try {
          final onlineFriends = <LimitedUser>[];
          var offset = 0;
          var hasMore = true;
          while (hasMore) {
            final (friendsSuccess, friendsFailure) =
                await rawApi
                    .getFriendsApi()
                    .getFriends(offline: false, n: 100, offset: offset)
                    .validateVrc();
            if (friendsSuccess == null) break;
            final batch = friendsSuccess.data;
            onlineFriends.addAll(batch.map(_convertToLimitedUser));
            if (batch.length < 100) {
              hasMore = false;
            } else {
              offset += 100;
            }
          }
          allFriends.addAll(onlineFriends);
        } catch (_) {}

        // オフライン
        try {
          final offlineFriends = <LimitedUser>[];
          var offset = 0;
          var hasMore = true;
          while (hasMore) {
            final (friendsSuccess, friendsFailure) =
                await rawApi
                    .getFriendsApi()
                    .getFriends(offline: true, n: 100, offset: offset)
                    .validateVrc();
            if (friendsSuccess == null) break;
            final batch = friendsSuccess.data;
            offlineFriends.addAll(batch.map(_convertToLimitedUser));
            if (batch.length < 100) {
              hasMore = false;
            } else {
              offset += 100;
            }
          }
          allFriends.addAll(offlineFriends);
        } catch (_) {}

        // お気に入りIDリスト取得
        final favoriteFriendsAsync = await ref.watch(
          favoriteFriendsProvider.future,
        );
        final favoriteIds =
            favoriteFriendsAsync.map((f) => f.favoriteId).toSet();

        // フレンドリストをお気に入りIDでフィルタ
        final filtered =
            allFriends.where((u) => favoriteIds.contains(u.id)).toList();
        debugPrint('お気に入りフレンド: ${filtered.length}人');
        return filtered;
      }

      debugPrint('フレンド取得完了: 合計${allFriends.length}人');
      return allFriends;
    } catch (e, stack) {
      debugPrint('フレンドリスト取得中のエラー: $e');
      debugPrint('スタックトレース: $stack');
      rethrow;
    }
  }

  // LimitedUserFriend を LimitedUser に変換するヘルパーメソッド
  LimitedUser _convertToLimitedUser(LimitedUserFriend friend) {
    return LimitedUser(
      bio: friend.bio,
      currentAvatarImageUrl: friend.currentAvatarImageUrl!,
      currentAvatarThumbnailImageUrl: friend.currentAvatarThumbnailImageUrl,
      developerType: friend.developerType,
      displayName: friend.displayName,
      id: friend.id,
      isFriend: friend.isFriend,
      lastPlatform: friend.lastPlatform,
      profilePicOverride: friend.profilePicOverride,
      status: friend.status,
      statusDescription: friend.statusDescription,
      tags: friend.tags,
      userIcon: friend.userIcon,
      location: friend.location,
      friendKey: friend.friendKey,
      lastLogin: friend.lastLogin,
    );
  }

  // フレンド情報を更新するメソッド
  void updateFriendState(String userId, {required bool isOnline}) {
    state.whenData((friends) {
      state = AsyncData(
        friends.map((friend) {
          if (friend.id == userId) {
            // LimitedUserは不変なので新しいインスタンスを作成
            return LimitedUser(
              bio: friend.bio,
              currentAvatarImageUrl: friend.currentAvatarImageUrl,
              currentAvatarThumbnailImageUrl:
                  friend.currentAvatarThumbnailImageUrl,
              developerType: friend.developerType,
              displayName: friend.displayName,
              id: friend.id,
              isFriend: friend.isFriend,
              lastPlatform: friend.lastPlatform,
              profilePicOverride: friend.profilePicOverride,
              status: isOnline ? UserStatus.active : UserStatus.offline,
              statusDescription: friend.statusDescription,
              tags: friend.tags,
              userIcon: friend.userIcon,
              location: isOnline ? friend.location : 'offline',
              friendKey: friend.friendKey,
              lastLogin: friend.lastLogin,
            );
          }
          return friend;
        }).toList(),
      );
    });
  }

  // フレンドの位置情報を更新
  void updateFriendLocation(String userId, String location, String? worldName) {
    state.whenData((friends) {
      state = AsyncData(
        friends.map((friend) {
          if (friend.id == userId) {
            return LimitedUser(
              bio: friend.bio,
              currentAvatarImageUrl: friend.currentAvatarImageUrl,
              currentAvatarThumbnailImageUrl:
                  friend.currentAvatarThumbnailImageUrl,
              developerType: friend.developerType,
              displayName: friend.displayName,
              id: friend.id,
              isFriend: friend.isFriend,
              lastPlatform: friend.lastPlatform,
              profilePicOverride: friend.profilePicOverride,
              status: friend.status,
              statusDescription: friend.statusDescription,
              tags: friend.tags,
              userIcon: friend.userIcon,
              location: location,
              friendKey: friend.friendKey,
              lastLogin: friend.lastLogin,
            );
          }
          return friend;
        }).toList(),
      );
    });

    // ワールド名が提供されている場合はキャッシュに追加
    if (worldName != null && location.startsWith('wrld_')) {
      final worldId = location.split(':')[0];
      ref
          .read(worldNamesProvider.notifier)
          .update((state) => {...state, worldId: worldName});
    }
  }

  // フレンド情報（ステータスなど）を更新
  void updateFriendInfo(
    String userId, {
    UserStatus? status,
    String? statusDescription,
  }) {
    state.whenData((friends) {
      state = AsyncData(
        friends.map((friend) {
          if (friend.id == userId) {
            return LimitedUser(
              bio: friend.bio,
              currentAvatarImageUrl: friend.currentAvatarImageUrl,
              currentAvatarThumbnailImageUrl:
                  friend.currentAvatarThumbnailImageUrl,
              developerType: friend.developerType,
              displayName: friend.displayName,
              id: friend.id,
              isFriend: friend.isFriend,
              lastPlatform: friend.lastPlatform,
              profilePicOverride: friend.profilePicOverride,
              status: status ?? friend.status,
              statusDescription: statusDescription ?? friend.statusDescription,
              tags: friend.tags,
              userIcon: friend.userIcon,
              location: friend.location,
              friendKey: friend.friendKey,
              lastLogin: friend.lastLogin,
            );
          }
          return friend;
        }).toList(),
      );
    });
  }

  // フレンドを削除
  void removeFriend(String userId) {
    state.whenData((friends) {
      state = AsyncData(
        friends.where((friend) => friend.id != userId).toList(),
      );
    });
  }

  // フレンドリストを再取得
  Future<void> refreshFriends() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadFriends);
  }
}

// フレンドの状態を更新するハンドラー
final friendStateUpdaterProvider =
    Provider<void Function(String, {required bool isOnline})>((ref) {
      return (String userId, {required bool isOnline}) {
        ref
            .read(friendsProvider.notifier)
            .updateFriendState(userId, isOnline: isOnline);
      };
    });

// フレンドの位置情報を更新するハンドラー
final friendLocationUpdaterProvider =
    Provider<void Function(String, String, String?)>((ref) {
      return (String userId, String location, String? worldName) {
        ref
            .read(friendsProvider.notifier)
            .updateFriendLocation(userId, location, worldName);
      };
    });

// フレンド情報を更新するハンドラー
final friendInfoUpdaterProvider = Provider<
  void Function(String, {UserStatus? status, String? statusDescription})
>((ref) {
  return (String userId, {UserStatus? status, String? statusDescription}) {
    ref
        .read(friendsProvider.notifier)
        .updateFriendInfo(
          userId,
          status: status,
          statusDescription: statusDescription,
        );
  };
});

// フレンド追加ハンドラー
final friendAddHandlerProvider = Provider<void Function(String)>((ref) {
  return (String userId) {
    // フレンドリストを再読み込み（新しいフレンドを取得するため）
    ref.read(friendsProvider.notifier).refreshFriends();
  };
});

// フレンド削除ハンドラー
final friendDeleteHandlerProvider = Provider<void Function(String)>((ref) {
  return (String userId) {
    ref.read(friendsProvider.notifier).removeFriend(userId);
  };
});

// 通知ハンドラー
final notificationHandlerProvider = Provider<void Function(Notification)>((
  ref,
) {
  return (Notification notification) {
    // 通知の処理（通知プロバイダーが実装されている場合）
    // ref.read(notificationsProvider.notifier).addNotification(notification);
    debugPrint('新しい通知: ${notification.type}');
  };
});

// ワールド名キャッシュ
final worldNamesProvider = StateProvider<Map<String, String>>((ref) => {});
