import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/favorite_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart' hide FavoriteType;

class FavoriteFolderMissingException implements Exception {
  const FavoriteFolderMissingException();
}

class FavoriteController {
  const FavoriteController(this.ref);

  final Ref ref;

  Future<void> addToFirstGroup({
    required String favoriteId,
    required FavoriteType type,
  }) async {
    final favoriteGroups = await ref.read(
      typedFavoriteGroupsProvider(type).future,
    );
    if (favoriteGroups.isEmpty) {
      throw const FavoriteFolderMissingException();
    }

    await ref
        .read(favoriteActionProvider.notifier)
        .addFavorite(
          favoriteId: favoriteId,
          type: type,
          tags: [favoriteGroups.first.name],
        );

    ref.invalidate(allFavoritesProvider(type));
    switch (type) {
      case FavoriteType.friend:
        ref.invalidate(favoriteFriendsProvider);
      case FavoriteType.world:
        ref.invalidate(favoriteWorldsProvider);
      case FavoriteType.avatar:
        ref.invalidate(favoriteAvatarsProvider);
    }
  }

  Future<void> removeFavorite(String favoriteId) async {
    await ref.read(favoriteActionProvider.notifier).removeFavorite(favoriteId);
    ref
      ..invalidate(favoriteFriendsProvider)
      ..invalidate(favoriteWorldsProvider)
      ..invalidate(favoriteAvatarsProvider);
  }

  Map<String, List<Favorite>> groupByFolder({
    required List<Favorite> favorites,
    required List<FavoriteGroup> groups,
    required FavoriteType type,
  }) {
    final groupTagToNameMap = <String, String>{};
    final result = <String, List<Favorite>>{};

    for (final group in groups.where(
      (group) => group.type.toString() == type.value,
    )) {
      result[group.displayName] = [];
      groupTagToNameMap[group.name] = group.displayName;
    }

    for (final favorite in favorites) {
      for (final tag in favorite.tags) {
        final displayName = groupTagToNameMap[tag];
        if (displayName == null) continue;
        result[displayName]!.add(favorite);
        break;
      }
    }

    return result;
  }

  void refreshFriends() {
    ref.invalidate(favoriteFriendsProvider);
  }

  void refreshWorlds() {
    ref.invalidate(favoriteWorldsProvider);
  }

  void refreshAvatars() {
    ref.invalidate(favoriteAvatarsProvider);
  }

  void refreshFriendsWithGroups() {
    ref
      ..invalidate(myFavoriteGroupsProvider)
      ..invalidate(favoriteFriendsProvider);
  }

  void refreshWorldsWithGroups() {
    ref
      ..invalidate(myFavoriteGroupsProvider)
      ..invalidate(favoriteWorldsProvider);
  }

  void refreshAvatarsWithGroups() {
    ref
      ..invalidate(myFavoriteGroupsProvider)
      ..invalidate(favoriteAvatarsProvider);
  }
}

final favoriteControllerProvider = Provider<FavoriteController>((ref) {
  return FavoriteController(ref);
});
