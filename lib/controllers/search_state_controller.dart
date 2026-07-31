import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/provider/search_providers.dart';

class SearchStateController {
  const SearchStateController(this.ref);

  final Ref ref;

  void updateQuery(String query) {
    if (query != ref.read(searchQueryProvider)) {
      resetPaging();
    }

    ref.read(searchQueryProvider.notifier).state = query;
  }

  void resetPaging() {
    ref.read(userSearchOffsetProvider.notifier).state = 0;
    ref.read(worldSearchOffsetProvider.notifier).state = 0;
    ref.read(groupSearchOffsetProvider.notifier).state = 0;
    ref.read(worldSearchResultsProvider.notifier).state = [];
    ref.read(userSearchResultsProvider.notifier).state = [];
    ref.read(groupSearchResultsProvider.notifier).state = [];
  }

  bool loadMore(StateProvider<int> offsetProvider) {
    if (ref.read(searchingProvider)) return false;

    final currentOffset = ref.read(offsetProvider);
    ref.read(offsetProvider.notifier).state = currentOffset + searchPageSize;
    return true;
  }

  void handlePagedResults<T>({
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
}

final searchStateControllerProvider = Provider<SearchStateController>((ref) {
  return SearchStateController(ref);
});
