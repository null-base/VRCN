import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/friend_sort_provider.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/widgets/app_drawer.dart';
import 'package:vrchat/widgets/error_container.dart';
import 'package:vrchat/widgets/friend_location_group.dart';
import 'package:vrchat/widgets/loading_indicator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class FriendsPage extends ConsumerWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(sortedFriendsProvider);

    return Scaffold(
      drawer: const AppDrawer(),
      body: friendsAsync.when(
        data: (friends) => _buildFriendsList(context, friends, ref),
        loading: () => LoadingIndicator(message: t.friends.loading),
        error: (error, stackTrace) => ErrorContainer(
          message: t.friends.error(error: error.toString()),
          onRetry: () => ref.refresh(friendsProvider),
        ),
      ),
    );
  }

  Widget _buildFriendsList(
    BuildContext context,
    List<LimitedUser> friends,
    WidgetRef ref,
  ) {
    if (friends.isEmpty) {
      return Center(
        child: Text(
          t.friends.notFound,
          style: GoogleFonts.notoSans(fontSize: 16),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.refresh(friendsProvider.future).then((_) {}),
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: _buildGroupedFriendsList(context, friends),
    );
  }

  // ロケーションでグループ化したリスト表示
  Widget _buildGroupedFriendsList(
    BuildContext context,
    List<LimitedUser> friends,
  ) {
    final friendGroups = <String, List<LimitedUser>>{};
    final offlineFriends = <LimitedUser>[];
    final activeOfflineFriends = <LimitedUser>[];
    final privateFriends = <LimitedUser>[];
    final onlineFriends = <LimitedUser>[];

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
        onlineFriends.add(friend);
      }
    }

    for (final friend in onlineFriends) {
      final location = friend.location ?? 'unknown';
      if (!friendGroups.containsKey(location)) {
        friendGroups[location] = [];
      }
      friendGroups[location]!.add(friend);
    }

    final sortedLocations = friendGroups.keys.toList()
      ..sort(
        (a, b) => friendGroups[b]!.length.compareTo(friendGroups[a]!.length),
      );

    final groupWidgets = <Widget>[];

    // オンラインワールドグループ
    for (final location in sortedLocations) {
      final locationFriends = friendGroups[location]!;
      groupWidgets.add(
        FriendLocationGroup(
          locationName: location,
          locationIcon: Icons.public,
          friends: locationFriends,
          onTapFriend: (friend) => context.push('/user/${friend.id}'),
          iconColor: Colors.green,
          location: location,
        ),
      );
    }

    // プライベートグループ
    if (privateFriends.isNotEmpty) {
      groupWidgets.add(
        FriendLocationGroup(
          locationName: t.friends.private,
          locationIcon: Icons.lock_outline,
          friends: privateFriends,
          onTapFriend: (friend) => context.push('/user/${friend.id}'),
          iconColor: Colors.redAccent,
          isPrivate: true,
        ),
      );
    }

    // アクティブオフライン
    if (activeOfflineFriends.isNotEmpty) {
      groupWidgets.add(
        FriendLocationGroup(
          locationName: t.friends.active,
          locationIcon: Icons.circle,
          friends: activeOfflineFriends,
          onTapFriend: (friend) => context.push('/user/${friend.id}'),
          iconColor: Colors.green,
          isOffline: true,
          isActive: true,
        ),
      );
    }

    // オフライン
    if (offlineFriends.isNotEmpty) {
      groupWidgets.add(
        FriendLocationGroup(
          locationName: t.friends.offline,
          locationIcon: Icons.offline_bolt,
          friends: offlineFriends,
          onTapFriend: (friend) => context.push('/user/${friend.id}'),
          iconColor: Colors.grey,
          isOffline: true,
        ),
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: groupWidgets,
    );
  }
}
