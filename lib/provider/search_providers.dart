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

bool advanceSearchOffset(WidgetRef ref, StateProvider<int> offsetProvider) {
  if (ref.read(searchingProvider)) return false;

  final currentOffset = ref.read(offsetProvider);
  ref.read(offsetProvider.notifier).state = currentOffset + searchPageSize;
  return true;
}

void handlePagedSearchResults<T>({
  required WidgetRef ref,
  required AsyncValue<List<T>> state,
  required int offset,
  required List<T> cachedResults,
  required StateProvider<List<T>> resultsProvider,
  required Object? Function(T item) idOf,
}) {
  if (state.isLoading) {
    ref.read(searchingProvider.notifier).state = true;
    return;
  }

  ref.read(searchingProvider.notifier).state = false;
  if (!state.hasValue) return;

  final newResults = state.value ?? [];
  final nextResults = offset == 0
      ? newResults
      : _appendUniqueSearchResults(cachedResults, newResults, idOf);

  if (!identical(nextResults, cachedResults)) {
    ref.read(resultsProvider.notifier).state = nextResults;
  }
}

List<T> _appendUniqueSearchResults<T>(
  List<T> cachedResults,
  List<T> newResults,
  Object? Function(T item) idOf,
) {
  if (newResults.isEmpty) return cachedResults;

  final existingIds = cachedResults.map(idOf).toSet();
  final mergedResults = <T>[...cachedResults];
  for (final item in newResults) {
    if (existingIds.add(idOf(item))) {
      mergedResults.add(item);
    }
  }
  return mergedResults;
}

// 検索ページの状態にアクセスするためのGlobalKey
final Provider<GlobalKey<State<StatefulWidget>>> searchPageKeyProvider =
    Provider((ref) => GlobalKey());
