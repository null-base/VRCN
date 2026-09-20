import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:vrchat/provider/vrchat_extended_api_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final FutureProvider<UsersApi> vrchatUserProvider = FutureProvider((ref) async {
  try {
    final rawApi = await ref.watch(vrchatRawApiProvider);
    return rawApi.getUsersApi();
  } catch (e) {
    throw Exception('UserAPIの初期化に失敗しました: $e');
  }
});

// 特定のユーザーの詳細情報を取得するプロバイダー
final FutureProviderFamily<User, String> userDetailProvider =
    FutureProvider.family<User, String>((
      ref,
      userId,
    ) async {
      final usersApi = await ref.watch(vrchatUserProvider.future);
      try {
        final response = await usersApi.getUser(userId: userId);

        if (response.data == null) {
          throw Exception('ユーザーデータが取得できませんでした: $userId');
        }
        return response.data!;
      } catch (e) {
        throw Exception('ユーザー情報の取得に失敗しました: $e');
      }
    });

// ユーザーの代表グループを取得するプロバイダー
final FutureProviderFamily<RepresentedGroup?, String>
userRepresentedGroupProvider = FutureProvider.family<RepresentedGroup?, String>(
  (ref, userId) async {
    final usersApi = await ref.watch(vrchatUserProvider.future);
    try {
      final response = await usersApi.getUserRepresentedGroup(
        userId: userId,
      );
      return response.data;
    } catch (e) {
      return null;
    }
  },
);

// ユーザー検索パラメータクラス
@immutable
class UserSearchParams {
  const UserSearchParams({this.search, this.n = 60, this.offset = 0});
  final String? search;
  final int? n;
  final int? offset;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserSearchParams &&
        other.search == search &&
        other.n == n &&
        other.offset == offset;
  }

  @override
  int get hashCode => Object.hash(search, n, offset);
}

// LimitedUserSearchをLimitedUserに変換するヘルパー関数
LimitedUser _convertSearchUserToLimitedUser(LimitedUserSearch searchUser) {
  return LimitedUser(
    currentAvatarImageUrl: null,
    currentAvatarThumbnailImageUrl: null,
    developerType: searchUser.developerType,
    displayName: searchUser.displayName,
    id: searchUser.id,
    isFriend: searchUser.isFriend,
    lastPlatform: searchUser.lastPlatform,
    profilePicOverride: null,
    status: searchUser.status,
    statusDescription: searchUser.statusDescription,
    tags: searchUser.tags,
    userIcon: searchUser.iconUrl,
    pronouns: searchUser.pronouns,
  );
}

// ユーザー検索プロバイダー
final FutureProviderFamily<List<LimitedUser>, UserSearchParams>
userSearchProvider = FutureProvider.family<List<LimitedUser>, UserSearchParams>(
  (
    ref,
    params,
  ) async {
    final usersApi = await ref.watch(vrchatUserProvider.future);

    try {
      final response = await usersApi.searchUsers(
        search: params.search,
        n: params.n,
        offset: params.offset,
      );

      if (response.data == null) {
        return [];
      }

      // LimitedUserSearchをLimitedUserに変換
      return response.data!.map(_convertSearchUserToLimitedUser).toList();
    } catch (e) {
      throw Exception('ユーザー検索に失敗しました: $e');
    }
  },
);

// 現在のユーザー（自分自身）の情報を取得するプロバイダー
final currentUserProvider = FutureProvider<CurrentUser>((ref) async {
  try {
    final rawApi = await ref.watch(vrchatRawApiProvider);
    final response = await rawApi.getAuthenticationApi().getCurrentUser();
    final currentUser = response.data;

    if (currentUser == null) {
      throw Exception('ログインしていません');
    }

    return currentUser;
  } catch (e) {
    throw Exception('ユーザー情報を取得できませんでした: $e');
  }
});

@immutable
class UserProfileData {
  const UserProfileData({required this.user, required this.profile});

  final User user;
  final PublicProfile profile;
}

@immutable
class CurrentUserProfileData {
  const CurrentUserProfileData({required this.user, required this.profile});

  final CurrentUser user;
  final PublicProfile profile;
}

final FutureProvider<PublicProfile> currentUserPublicProfileProvider =
    FutureProvider<PublicProfile>((ref) async {
      final user = await ref.watch(currentUserProvider.future);
      final profileApi = await ref.watch(vrchatProfileApiProvider.future);
      return profileApi.getPublicProfile(user.id, asSelf: true);
    });

final FutureProvider<CurrentUserProfileData> currentUserProfileProvider =
    FutureProvider<CurrentUserProfileData>((ref) async {
      final user = await ref.watch(currentUserProvider.future);
      final profile = await ref.watch(currentUserPublicProfileProvider.future);
      return CurrentUserProfileData(user: user, profile: profile);
    });

final FutureProviderFamily<UserProfileData, String> userProfileProvider =
    FutureProvider.family<UserProfileData, String>((ref, userId) async {
      final user = await ref.watch(userDetailProvider(userId).future);
      final profileApi = await ref.watch(vrchatProfileApiProvider.future);
      final profile = await profileApi.getPublicProfile(userId);
      return UserProfileData(user: user, profile: profile);
    });

// ユーザー情報を更新するプロバイダー
final FutureProviderFamily<CurrentUser, UpdateUserRequest> updateUserProvider =
    FutureProvider.family<CurrentUser, UpdateUserRequest>((
      ref,
      updateUserRequest,
    ) async {
      final usersApi = await ref.watch(vrchatUserProvider.future);
      final currentUser = await ref.watch(currentUserProvider.future);

      try {
        final response = await usersApi.updateUser(
          userId: currentUser.id,
          updateUserRequest: updateUserRequest,
        );

        if (response.statusMessage != 'OK') {
          throw Exception('ユーザー情報の更新に失敗しました');
        }

        ref.invalidate(currentUserProvider);

        return response.data!;
      } catch (e) {
        throw Exception('ユーザー情報の更新に失敗しました: $e');
      }
    });

// ユーザーのグループ一覧を取得するプロバイダー
final FutureProviderFamily<List<LimitedUserGroups>, String> userGroupsProvider =
    FutureProvider.family<List<LimitedUserGroups>, String>((ref, userId) async {
      final usersApi = await ref.watch(vrchatUserProvider.future);

      try {
        final response = await usersApi.getUserGroups(userId: userId);

        if (response.data == null) {
          return [];
        }
        return response.data!;
      } catch (e) {
        throw Exception('ユーザーのグループ情報の取得に失敗しました: $e');
      }
    });
