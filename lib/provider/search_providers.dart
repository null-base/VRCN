import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

// 入力中の検索クエリを管理するプロバイダー
final inputSearchQueryProvider = StateProvider<String>((ref) => '');

// 実際に検索に使用するクエリを管理するプロバイダー
final searchQueryProvider = StateProvider<String>((ref) => '');

// 検索中状態を管理するプロバイダー
final searchingProvider = StateProvider<bool>((ref) => false);

// 検索オフセットを各タブ用に分離
final userSearchOffsetProvider = StateProvider<int>((ref) => 0);
final worldSearchOffsetProvider = StateProvider<int>((ref) => 0);
final groupSearchOffsetProvider = StateProvider<int>((ref) => 0);

// 検索結果キャッシュを保持するためのプロバイダー
final worldSearchResultsProvider = StateProvider<List<LimitedWorld>>(
  (ref) => [],
);
final userSearchResultsProvider = StateProvider<List<LimitedUser>>((ref) => []);
final groupSearchResultsProvider = StateProvider<List<LimitedGroup>>(
  (ref) => [],
);

const searchPageSize = 60;

// 検索ページの状態にアクセスするためのGlobalKey
final Provider<GlobalKey<State<StatefulWidget>>> searchPageKeyProvider =
    Provider((ref) => GlobalKey());
