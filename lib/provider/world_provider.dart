import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final FutureProvider<WorldsApi> vrchatWorldProvider = FutureProvider((
  ref,
) async {
  try {
    final rawApi = await ref.watch(vrchatRawApiProvider);
    return rawApi.getWorldsApi();
  } catch (e) {
    throw Exception('WorldsAPIの初期化に失敗しました: $e');
  }
});

// ワールド情報
final FutureProviderFamily<World, String> worldDetailProvider =
    FutureProvider.family<World, String>((
      ref,
      worldId,
    ) async {
      final worldsApi = await ref.watch(vrchatWorldProvider.future);

      try {
        final response = await worldsApi.getWorld(worldId: worldId);
        if (response.data == null) {
          throw Exception('ワールドデータが取得できませんでした: $worldId');
        }
        return response.data!;
      } catch (e) {
        throw Exception('ワールド情報の取得に失敗しました: $e');
      }
    });

// ワールド検索パラメータクラス
@immutable
class WorldSearchParams {
  const WorldSearchParams({
    this.featured,
    this.sort,
    this.user,
    this.userId,
    this.n = 60,
    this.order,
    this.offset = 0,
    this.search,
    this.tag,
    this.notag,
    this.platform,
  });
  final bool? featured;
  final SortOption? sort;
  final String? user;
  final String? userId;
  final int? n;
  final OrderOption? order;
  final int? offset;
  final String? search;
  final String? tag;
  final String? notag;
  final String? platform;

  // 文字列からSortOptionに変換するヘルパーメソッド
  SortOption? stringToSortOption(String? sortStr) {
    if (sortStr == null) return null;

    switch (sortStr.toLowerCase()) {
      case 'popularity':
        return SortOption.popularity;
      case 'heat':
        return SortOption.heat;
      case 'trust':
        return SortOption.trust;
      case 'shuffle':
        return SortOption.shuffle;
      case 'random':
        return SortOption.random;
      case 'favorites':
        return SortOption.favorites;
      case 'created':
        return SortOption.created;
      case 'updated':
        return SortOption.updated;
      case 'order':
        return SortOption.order;
      case 'relevance':
        return SortOption.relevance;
      case 'magic':
        return SortOption.magic;
      default:
        return null;
    }
  }

  // 文字列からOrderOptionに変換するヘルパーメソッド
  OrderOption? stringToOrderOption(String? orderStr) {
    if (orderStr == null) return null;

    switch (orderStr.toLowerCase()) {
      case 'ascending':
        return OrderOption.ascending;
      case 'descending':
        return OrderOption.descending;
      default:
        return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorldSearchParams &&
        other.featured == featured &&
        other.sort == sort &&
        other.user == user &&
        other.userId == userId &&
        other.n == n &&
        other.order == order &&
        other.offset == offset &&
        other.search == search &&
        other.tag == tag &&
        other.notag == notag &&
        other.platform == platform;
  }

  @override
  int get hashCode => Object.hash(
    featured,
    sort,
    user,
    userId,
    n,
    order,
    offset,
    search,
    tag,
    notag,
    platform,
  );
}

// ワールド検索プロバイダー
final FutureProviderFamily<List<LimitedWorld>, WorldSearchParams>
worldSearchProvider =
    FutureProvider.family<List<LimitedWorld>, WorldSearchParams>((
      ref,
      params,
    ) async {
      final worldsApi = await ref.watch(vrchatWorldProvider.future);

      try {
        final response = await worldsApi.searchWorlds(
          featured: params.featured,
          sort: params.sort,
          user: params.user,
          userId: params.userId,
          n: params.n,
          order: params.order,
          offset: params.offset,
          search: params.search,
          tag: params.tag,
          notag: params.notag,
          platform: params.platform,
        );

        if (response.data == null) {
          return [];
        }
        return response.data!;
      } catch (e) {
        throw Exception('ワールド検索に失敗しました: $e');
      }
    });
