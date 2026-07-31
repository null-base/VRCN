import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/controllers/favorite_controller.dart';
import 'package:vrchat/provider/avatar_provider.dart';
import 'package:vrchat/provider/favorite_provider.dart' as favorites;
import 'package:vrchat/utils/share_utils.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class AvatarDetailController {
  const AvatarDetailController(this.ref);

  final Ref ref;

  Future<void> selectAvatar(String avatarId) async {
    await ref.read(selectAvatarProvider(avatarId).future);
    ref.invalidate(avatarDetailProvider(avatarId));
  }

  Future<void> refresh(String avatarId) async {
    ref.invalidate(avatarDetailProvider(avatarId));
    await ref.read(avatarDetailProvider(avatarId).future);
  }

  Future<void> addAvatarToFavorites(String avatarId) async {
    await ref
        .read(favoriteControllerProvider)
        .addToFirstGroup(
          favoriteId: avatarId,
          type: favorites.FavoriteType.avatar,
        );
  }

  Future<void> shareAvatarProfile(Avatar avatar) {
    return ShareUtils.shareUrl(
      'https://vrchat.com/home/avatar/${avatar.id}',
      subject: avatar.name,
    );
  }
}

final avatarDetailControllerProvider = Provider<AvatarDetailController>((ref) {
  return AvatarDetailController(ref);
});
