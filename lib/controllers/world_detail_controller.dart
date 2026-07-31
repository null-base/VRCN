import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/controllers/favorite_controller.dart';
import 'package:vrchat/provider/favorite_provider.dart' as favorites;
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat/utils/share_utils.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class WorldDetailController {
  const WorldDetailController(this.ref);

  final Ref ref;

  Future<World> refresh(String worldId) {
    return ref.refresh(worldDetailProvider(worldId).future);
  }

  Future<void> openWorldWebsite(String worldId) {
    return UrlLauncherUtils.launchExternalURL(
      'https://vrchat.com/home/world/$worldId',
    );
  }

  Future<void> shareWorld(World world) {
    return ShareUtils.shareUrl(
      'https://vrchat.com/home/world/${world.id}',
      subject: world.name,
    );
  }

  Future<void> addWorldToFavorites(String worldId) async {
    await ref
        .read(favoriteControllerProvider)
        .addToFirstGroup(
          favoriteId: worldId,
          type: favorites.FavoriteType.world,
        );
  }
}

final worldDetailControllerProvider = Provider<WorldDetailController>((ref) {
  return WorldDetailController(ref);
});
