import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/playermoderation_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat/utils/share_utils.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class FriendActionController {
  const FriendActionController(this.ref);

  final Ref ref;

  Future<void> blockUser(String userId) {
    return ref.read(
      moderateUserProvider(PlayerModerationUtil.blockUser(userId)).future,
    );
  }

  Future<void> muteUser(String userId) {
    return ref.read(
      moderateUserProvider(PlayerModerationUtil.muteUser(userId)).future,
    );
  }

  Future<void> openUserWebsite(String userId) {
    return UrlLauncherUtils.launchExternalURL(
      'https://vrchat.com/home/user/$userId',
    );
  }

  Future<void> shareUserProfile(User user) {
    return ShareUtils.shareUrl(
      'https://vrchat.com/home/user/${user.id}',
      title: user.displayName,
    );
  }

  Future<User> refreshUserDetailById(String userId) {
    return ref.refresh(userDetailProvider(userId).future);
  }

  void refreshUserDetail(User user) {
    ref.invalidate(userDetailProvider(user.id));
    if (user.worldId != null) {
      ref.invalidate(worldDetailProvider(user.worldId!));
    }
    if (user.worldId != null && user.instanceId != null) {
      ref.invalidate(
        instanceDetailWithParamsProvider(
          InstanceParams(worldId: user.worldId!, instanceId: user.instanceId!),
        ),
      );
    }
    ref.invalidate(userRepresentedGroupProvider(user.id));
  }
}

final friendActionControllerProvider = Provider<FriendActionController>((ref) {
  return FriendActionController(ref);
});
