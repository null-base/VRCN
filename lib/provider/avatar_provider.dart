import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final FutureProvider<AvatarsApi> vrchatAvatarProvider = FutureProvider((
  ref,
) async {
  final rawApi = await ref.watch(vrchatRawApiProvider);
  return rawApi.getAvatarsApi();
});

// 現在のユーザーのアバター情報を取得する
final FutureProviderFamily<Avatar, String> ownAvatarProvider =
    FutureProvider.family<Avatar, String>((
      ref,
      userId,
    ) async {
      final avatarApi = ref.watch(vrchatAvatarProvider).value;

      final currentUser = await ref.watch(currentUserProvider.future);
      if (avatarApi == null) {
        throw Exception('アバターAPIを初期化できませんでした');
      }

      try {
        final response = await avatarApi.getOwnAvatar(userId: currentUser.id);

        if (response.data == null) {
          throw Exception('自分のアバター情報が取得できませんでした');
        }

        return response.data!;
      } catch (e) {
        throw Exception('自分のアバター取得に失敗しました: $e');
      }
    });

// 特定のアバターIDからアバター情報を取得する
final FutureProviderFamily<Avatar, String> avatarDetailProvider =
    FutureProvider.family<Avatar, String>((
      ref,
      avatarId,
    ) async {
      final avatarApi = ref.watch(vrchatAvatarProvider).value;
      if (avatarApi == null) {
        throw Exception('アバターAPIを初期化できませんでした');
      }

      try {
        final response = await avatarApi.getAvatar(avatarId: avatarId);

        if (response.data == null) {
          throw Exception('アバター情報が取得できませんでした');
        }

        return response.data!;
      } catch (e) {
        throw Exception('アバターの詳細取得に失敗しました: $e');
      }
    });

// アバター検索用パラメータクラス
@immutable
class AvatarSearchParams {
  const AvatarSearchParams({
    this.featured,
    this.sort,
    this.user,
    this.n,
    this.order,
    this.offset,
    this.releaseStatus,
    String? tag,
  });
  final bool? featured;
  final SortOption? sort;
  final String? user;
  final int? n;
  final OrderOption? order;
  final int? offset;
  final ReleaseStatus? releaseStatus;

  // パラメータのハッシュコードを計算（キャッシュの一意性のため）
  @override
  int get hashCode =>
      Object.hash(featured, sort, user, n, order, offset, releaseStatus);

  // パラメータの等価性を比較（キャッシュの一意性のため）
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AvatarSearchParams &&
        other.featured == featured &&
        other.sort == sort &&
        other.user == user &&
        other.n == n &&
        other.order == order &&
        other.offset == offset &&
        other.releaseStatus == releaseStatus;
  }
}

// アバター検索プロバイダー
final FutureProviderFamily<List<Avatar>, AvatarSearchParams>
avatarSearchProvider = FutureProvider.family<List<Avatar>, AvatarSearchParams>((
  ref,
  params,
) async {
  final avatarApi = ref.watch(vrchatAvatarProvider).value;
  if (avatarApi == null) {
    throw Exception('アバターAPIを初期化できませんでした');
  }

  try {
    final response = await avatarApi.searchAvatars(
      featured: params.featured,
      sort: params.sort ?? SortOption.updated,
      user: 'me',
      n: params.n ?? 60, // デフォルト値
      order: params.order ?? OrderOption.descending,
      offset: params.offset ?? 0, // デフォルト値
      releaseStatus: params.releaseStatus ?? ReleaseStatus.all,
    );

    if (response.data == null) {
      return [];
    }

    return response.data!;
  } catch (e) {
    throw Exception('アバターの検索に失敗しました: $e');
  }
});

// アバター選択プロバイダー
final FutureProviderFamily<CurrentUser, String> selectAvatarProvider =
    FutureProvider.family<CurrentUser, String>((
      ref,
      avatarId,
    ) async {
      final avatarApi = ref.watch(vrchatAvatarProvider).value;
      if (avatarApi == null) {
        throw Exception('アバターAPIを初期化できませんでした');
      }

      try {
        final response = await avatarApi.selectAvatar(avatarId: avatarId);

        if (response.data == null) {
          throw Exception('アバター選択に失敗しました');
        }

        // ユーザー情報の更新（currentUserProviderを更新）
        ref.invalidate(currentUserProvider);

        return response.data!;
      } catch (e) {
        throw Exception('アバターの選択に失敗しました: $e');
      }
    });
