import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final vrchatGroupProvider = FutureProvider((ref) async {
  try {
    final rawApi = await ref.watch(vrchatRawApiProvider);
    return rawApi.getGroupsApi();
  } catch (e) {
    throw Exception('GroupsAPIの初期化に失敗しました: $e');
  }
});

/// グループ検索パラメータクラス
@immutable
class GroupSearchParams {
  final String? query;
  final int? offset;
  final int? n;

  const GroupSearchParams({this.query, this.offset = 0, this.n = 60});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GroupSearchParams &&
        other.query == query &&
        other.offset == offset &&
        other.n == n;
  }

  @override
  int get hashCode => Object.hash(query, offset, n);
}

/// グループ検索プロバイダー
final groupSearchProvider =
    FutureProvider.family<List<LimitedGroup>, GroupSearchParams>((
      ref,
      params,
    ) async {
      try {
        final rawApi = await ref.watch(vrchatRawApiProvider);
        final groupsApi = rawApi.getGroupsApi();

        final response = await groupsApi.searchGroups(
          query: params.query,
          offset: params.offset,
          n: params.n,
        );

        if (response.data == null) {
          return [];
        }

        return response.data!;
      } catch (e) {
        throw Exception('グループ検索に失敗しました: $e');
      }
    });

// グループキャッシュ用のプロバイダー
final groupSearchResultsProvider = StateProvider<List<LimitedGroup>>(
  (ref) => [],
);

/// グループ情報の詳細を取得するプロバイダー
final groupDetailProvider = FutureProvider.family<Group, GroupDetailParams>((
  ref,
  params,
) async {
  final groupsApi = await ref.watch(vrchatGroupProvider.future);

  try {
    final response = await groupsApi.getGroup(
      groupId: params.groupId,
      includeRoles: params.includeRoles,
    );

    if (response.data == null) {
      throw Exception('グループデータが取得できませんでした: ${params.groupId}');
    }
    return response.data!;
  } catch (e) {
    throw Exception('グループ情報の取得に失敗しました: $e');
  }
});

/// グループ詳細取得パラメータクラス
@immutable
class GroupDetailParams {
  final String groupId;
  final bool includeRoles;

  const GroupDetailParams({required this.groupId, this.includeRoles = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GroupDetailParams &&
        other.groupId == groupId &&
        other.includeRoles == includeRoles;
  }

  @override
  int get hashCode => Object.hash(groupId, includeRoles);
}
