import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrchat/controllers/friend_list_controller.dart';
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
          onRetry: () => ref.read(friendsActionsProvider).refreshFriends(),
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
      onRefresh: () => ref.read(friendsActionsProvider).refreshFriends(),
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
    final groupedFriends = friendListController.groupByLocation(friends);
    final groupWidgets = <Widget>[];

    // オンラインワールドグループ
    for (final location in groupedFriends.sortedLocations) {
      final locationFriends = groupedFriends.onlineByLocation[location]!;
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
    if (groupedFriends.privateFriends.isNotEmpty) {
      groupWidgets.add(
        FriendLocationGroup(
          locationName: t.friends.private,
          locationIcon: Icons.lock_outline,
          friends: groupedFriends.privateFriends,
          onTapFriend: (friend) => context.push('/user/${friend.id}'),
          iconColor: Colors.redAccent,
          isPrivate: true,
        ),
      );
    }

    // アクティブオフライン
    if (groupedFriends.activeOfflineFriends.isNotEmpty) {
      groupWidgets.add(
        FriendLocationGroup(
          locationName: t.friends.active,
          locationIcon: Icons.circle,
          friends: groupedFriends.activeOfflineFriends,
          onTapFriend: (friend) => context.push('/user/${friend.id}'),
          iconColor: Colors.green,
          isOffline: true,
          isActive: true,
        ),
      );
    }

    // オフライン
    if (groupedFriends.offlineFriends.isNotEmpty) {
      groupWidgets.add(
        FriendLocationGroup(
          locationName: t.friends.offline,
          locationIcon: Icons.offline_bolt,
          friends: groupedFriends.offlineFriends,
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
