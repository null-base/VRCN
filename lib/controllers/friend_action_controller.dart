import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/instance_provider.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/playermoderation_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/world_provider.dart';
import 'package:vrchat/utils/share_utils.dart';
import 'package:vrchat/utils/url_launcher_utils.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final FutureProviderFamily<FriendStatus, String> friendStatusProvider =
    FutureProvider.family<FriendStatus, String>((
      ref,
      userId,
    ) async {
      final api = await ref.watch(vrchatRawApiProvider);
      final response = await api.getFriendsApi().getFriendStatus(
        userId: userId,
      );
      final status = response.data;
      if (status == null) throw StateError(t.friendDetail.friendStatusEmpty);
      return status;
    });

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

  Future<FriendStatus> getFriendStatus(String userId) async {
    final api = await ref.read(vrchatRawApiProvider);
    final response = await api.getFriendsApi().getFriendStatus(userId: userId);
    final status = response.data;
    if (status == null) throw StateError(t.friendDetail.friendStatusEmpty);
    return status;
  }

  Future<void> sendFriendRequest(String userId) async {
    final api = await ref.read(vrchatRawApiProvider);
    await api.getFriendsApi().friend(userId: userId);
    ref.invalidate(userDetailProvider(userId));
    ref.invalidate(userProfileProvider(userId));
  }

  Future<void> cancelFriendRequest(String userId) async {
    final api = await ref.read(vrchatRawApiProvider);
    await api.getFriendsApi().deleteFriendRequest(userId: userId);
    ref.invalidate(userDetailProvider(userId));
    ref.invalidate(userProfileProvider(userId));
  }

  Future<void> unfriend(String userId) async {
    final api = await ref.read(vrchatRawApiProvider);
    await api.getFriendsApi().unfriend(userId: userId);
    ref.invalidate(userDetailProvider(userId));
    ref.invalidate(userProfileProvider(userId));
    ref.invalidate(friendsProvider);
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
    ref.invalidate(userProfileProvider(userId));
    return ref.refresh(userDetailProvider(userId).future);
  }

  void refreshUserDetail(User user) {
    ref.invalidate(userDetailProvider(user.id));
    ref.invalidate(userProfileProvider(user.id));
    if (user.worldId != null) {
      ref.invalidate(worldDetailProvider(user.worldId!));
    }
    if (user.worldId != null &&
        user.instanceId != null &&
        isInstanceLocation(user.location)) {
      ref.invalidate(instanceDetailProvider(user.location.toString()));
    }
    ref.invalidate(userRepresentedGroupProvider(user.id));
  }
}

final friendActionControllerProvider = Provider<FriendActionController>((ref) {
  return FriendActionController(ref);
});
