import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrchat_dart/vrchat_dart.dart' as vrc;
import 'package:vrchat/utils/app_logger.dart';

final FutureProvider<FavoritesApi> vrchatFavoriteProvider = FutureProvider((
  ref,
) async {
  final rawApi = await ref.watch(vrchatRawApiProvider);
  return rawApi.getFavoritesApi();
});

final favoriteActionProvider =
    StateNotifierProvider<FavoriteActionNotifier, AsyncValue<void>>((ref) {
      final favoriteApi = ref.watch(vrchatFavoriteProvider).value;
      return FavoriteActionNotifier(favoriteApi);
    });

class FavoriteActionNotifier extends StateNotifier<AsyncValue<void>> {
  FavoriteActionNotifier(this._favoriteApi)
    : super(const AsyncValue.data(null));

  final FavoritesApi? _favoriteApi;

  Future<void> removeFavorite(String favoriteId) async {
    if (_favoriteApi == null) {
      state = const AsyncValue.error('お気に入りAPIが初期化されていません', StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();

    try {
      await _favoriteApi.removeFavorite(favoriteId: favoriteId);
      state = const AsyncValue.data(null);
    } catch (error, stack) {
      state = AsyncValue.error('お気に入り削除に失敗しました: $error', stack);
    }
  }

  Future<void> addFavorite({
    required String favoriteId,
    required FavoriteType type,
    required List<String> tags,
  }) async {
    if (_favoriteApi == null) {
      state = const AsyncValue.error('お気に入りAPIが初期化されていません', StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();

    try {
      await _favoriteApi.addFavorite(
        addFavoriteRequest: vrc.AddFavoriteRequest(
          favoriteId: favoriteId,
          tags: tags,
          type: type.apiType,
        ),
      );
      state = const AsyncValue.data(null);
    } catch (error, stack) {
      state = AsyncValue.error('お気に入り追加に失敗しました: $error', stack);
      rethrow;
    }
  }
}

// お気に入りの検索パラメータを定義
@immutable
class FavoriteSearchParams {
  const FavoriteSearchParams({this.n = 100, this.offset, this.type, this.tag});
  final int? n;
  final int? offset;
  final String? type;
  final String? tag;

  // パラメータの比較用
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteSearchParams &&
        other.n == n &&
        other.offset == offset &&
        other.type == type &&
        other.tag == tag;
  }

  @override
  int get hashCode => Object.hash(n, offset, type, tag);
}

// お気に入り一覧を取得するプロバイダー
final FutureProviderFamily<List<Favorite>, FavoriteSearchParams>
favoritesListProvider =
    FutureProvider.family<List<Favorite>, FavoriteSearchParams>((
      ref,
      params,
    ) async {
      final favoriteApi = ref.watch(vrchatFavoriteProvider).value;
      if (favoriteApi == null) {
        throw Exception('お気に入りAPIを初期化できませんでした');
      }

      try {
        final response = await favoriteApi.getFavorites(
          n: params.n,
          offset: params.offset,
          type: params.type,
          tag: params.tag,
        );

        if (response.data == null) {
          return []; // データがない場合は空リストを返す
        }

        return response.data!;
      } catch (e) {
        throw Exception('お気に入りの取得に失敗しました: $e');
      }
    });

// お気に入りの種類を定義する列挙型（使いやすさ向上）
enum FavoriteType { world, friend, avatar }

// 列挙型を文字列に変換する拡張メソッド
extension FavoriteTypeExtension on FavoriteType {
  String get value {
    switch (this) {
      case FavoriteType.world:
        return 'world';
      case FavoriteType.friend:
        return 'friend';
      case FavoriteType.avatar:
        return 'avatar';
    }
  }

  vrc.FavoriteType get apiType {
    switch (this) {
      case FavoriteType.world:
        return vrc.FavoriteType.world;
      case FavoriteType.friend:
        return vrc.FavoriteType.friend;
      case FavoriteType.avatar:
        return vrc.FavoriteType.avatar;
    }
  }
}

// タイプ別にお気に入りを簡単に取得するヘルパープロバイダー
final FutureProviderFamily<List<Favorite>, FavoriteType>
typedFavoritesProvider = FutureProvider.family<List<Favorite>, FavoriteType>((
  ref,
  type,
) {
  final params = FavoriteSearchParams(type: type.value);
  return ref.watch(favoritesListProvider(params).future);
});

// すべてのお気に入りを再帰的に取得するプロバイダー
final FutureProviderFamily<List<Favorite>, FavoriteType> allFavoritesProvider =
    FutureProvider.family<List<Favorite>, FavoriteType>((ref, type) async {
      final favoriteApi = ref.watch(vrchatFavoriteProvider).value;
      if (favoriteApi == null) {
        throw Exception('お気に入りAPIを初期化できませんでした');
      }

      final allFavorites = <Favorite>[];
      var offset = 0;
      var hasMore = true;

      // すべてのページを取得するまで繰り返し
      while (hasMore) {
        try {
          final response = await favoriteApi.getFavorites(
            n: 100, // 最大数
            offset: offset,
            type: type.value,
          );

          if (response.data == null || response.data!.isEmpty) {
            hasMore = false;
          } else {
            allFavorites.addAll(response.data!);
            offset += response.data!.length;

            // 取得数が100未満ならこれ以上のデータはない
            if (response.data!.length < 100) {
              hasMore = false;
            }

            // デバッグ情報
            appLogger.d('${type.value}のお気に入りを$offset件取得中...');
          }
        } catch (e) {
          throw Exception('お気に入りの取得に失敗しました: $e');
        }
      }

      appLogger.d('${type.value}のお気に入りを合計${allFavorites.length}件取得しました');
      return allFavorites;
    });

// お気に入りアバターを全件取得するプロバイダー
final favoriteAvatarsProvider = FutureProvider<List<Favorite>>((ref) {
  return ref.watch(allFavoritesProvider(FavoriteType.avatar).future);
});

// お気に入りワールドを全件取得するプロバイダー
final favoriteWorldsProvider = FutureProvider<List<Favorite>>((ref) {
  return ref.watch(allFavoritesProvider(FavoriteType.world).future);
});

// お気に入りフレンドを全件取得するプロバイダー
final favoriteFriendsProvider = FutureProvider<List<Favorite>>((ref) {
  return ref.watch(allFavoritesProvider(FavoriteType.friend).future);
});

// お気に入りグループの検索パラメータを定義
@immutable
class FavoriteGroupSearchParams {
  const FavoriteGroupSearchParams({
    this.n = 60, // デフォルト値は60件
    this.offset,
    this.ownerId, // 省略時は自分自身のお気に入りグループを取得
  });
  final int? n;
  final int? offset;
  final String? ownerId;

  // パラメータの比較用
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteGroupSearchParams &&
        other.n == n &&
        other.offset == offset &&
        other.ownerId == ownerId;
  }

  @override
  int get hashCode => Object.hash(n, offset, ownerId);
}

// お気に入りグループ一覧を取得するプロバイダー
final FutureProviderFamily<List<FavoriteGroup>, FavoriteGroupSearchParams>
favoriteGroupsListProvider =
    FutureProvider.family<List<FavoriteGroup>, FavoriteGroupSearchParams>((
      ref,
      params,
    ) async {
      final favoriteApi = ref.watch(vrchatFavoriteProvider).value;
      if (favoriteApi == null) {
        throw Exception('お気に入りAPIを初期化できませんでした');
      }

      try {
        final response = await favoriteApi.getFavoriteGroups(
          n: params.n,
          offset: params.offset,
          ownerId: params.ownerId,
        );

        if (response.data == null) {
          return []; // データがない場合は空リストを返す
        }

        return response.data!;
      } catch (e) {
        throw Exception('お気に入りグループの取得に失敗しました: $e');
      }
    });

// 自分自身のお気に入りグループを簡単に取得するプロバイダー
final myFavoriteGroupsProvider = FutureProvider<List<FavoriteGroup>>((ref) {
  const params = FavoriteGroupSearchParams(); // デフォルトパラメータ（自分自身）
  return ref.watch(favoriteGroupsListProvider(params).future);
});

// 特定のタイプのお気に入りグループを取得するプロバイダー
final FutureProviderFamily<List<FavoriteGroup>, FavoriteType>
typedFavoriteGroupsProvider =
    FutureProvider.family<List<FavoriteGroup>, FavoriteType>((ref, type) async {
      final allGroups = await ref.watch(myFavoriteGroupsProvider.future);
      // グループタイプでフィルタリング
      return allGroups
          .where((group) => group.type.toString() == type.value)
          .toList();
    });

// お気に入りグループを取得して、そのグループに所属するお気に入りを取得するプロバイダー
final FutureProviderFamily<List<Favorite>, String> favoritesByGroupIdProvider =
    FutureProvider.family<List<Favorite>, String>((ref, groupId) {
      // グループIDに指定したタグのついたお気に入りを検索
      final params = FavoriteSearchParams(tag: groupId);
      return ref.watch(favoritesListProvider(params).future);
    });
