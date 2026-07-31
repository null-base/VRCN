import 'package:flutter/foundation.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

@immutable
class FriendLocationGroups {
  const FriendLocationGroups({
    required this.onlineByLocation,
    required this.sortedLocations,
    required this.privateFriends,
    required this.activeOfflineFriends,
    required this.offlineFriends,
  });

  final Map<String, List<LimitedUser>> onlineByLocation;
  final List<String> sortedLocations;
  final List<LimitedUser> privateFriends;
  final List<LimitedUser> activeOfflineFriends;
  final List<LimitedUser> offlineFriends;
}

class FriendListController {
  const FriendListController();

  FriendLocationGroups groupByLocation(List<LimitedUser> friends) {
    final onlineByLocation = <String, List<LimitedUser>>{};
    final offlineFriends = <LimitedUser>[];
    final activeOfflineFriends = <LimitedUser>[];
    final privateFriends = <LimitedUser>[];

    for (final friend in friends) {
      if (friend.location == 'offline' &&
          friend.status != UserStatus.offline &&
          friend.status.toString().isNotEmpty) {
        activeOfflineFriends.add(friend);
      } else if (friend.location == null || friend.location == 'offline') {
        offlineFriends.add(friend);
      } else if (friend.location == 'private') {
        privateFriends.add(friend);
      } else {
        final location = friend.location ?? 'unknown';
        onlineByLocation.putIfAbsent(location, () => []).add(friend);
      }
    }

    return FriendLocationGroups(
      onlineByLocation: onlineByLocation,
      sortedLocations: onlineByLocation.keys.toList()
        ..sort(
          (a, b) => onlineByLocation[b]!.length.compareTo(
            onlineByLocation[a]!.length,
          ),
        ),
      privateFriends: privateFriends,
      activeOfflineFriends: activeOfflineFriends,
      offlineFriends: offlineFriends,
    );
  }
}

const friendListController = FriendListController();
