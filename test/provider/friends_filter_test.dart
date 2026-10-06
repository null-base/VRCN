import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrchat/provider/friend_sort_provider.dart';
import 'package:vrchat/provider/friends_provider.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('online and offline filters reuse the loaded friend list', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    _TestFriendsNotifier.buildCount = 0;
    final friends = [
      _friend('online', 'Online', 'private'),
      _friend('offline', 'Offline', 'offline'),
    ];
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        friendsProvider.overrideWith(() => _TestFriendsNotifier(friends)),
      ],
    );
    addTearDown(container.dispose);

    await container.read(friendsProvider.future);
    final subscription = container.listen(sortedFriendsProvider, (_, _) {});
    addTearDown(subscription.close);

    expect(
      container
          .read(sortedFriendsProvider)
          .asData!
          .value
          .map((friend) => friend.id),
      ['online', 'offline'],
    );

    container.read(friendFilterProvider.notifier).state = FriendFilter.offline;
    expect(
      container
          .read(sortedFriendsProvider)
          .asData!
          .value
          .map((friend) => friend.id),
      ['offline'],
    );

    container.read(friendFilterProvider.notifier).state = FriendFilter.online;
    expect(
      container
          .read(sortedFriendsProvider)
          .asData!
          .value
          .map((friend) => friend.id),
      ['online'],
    );
    expect(_TestFriendsNotifier.buildCount, 1);
  });
}

LimitedUser _friend(String id, String name, String location) {
  return LimitedUser(
    developerType: DeveloperType.none,
    displayName: name,
    id: id,
    isFriend: true,
    lastPlatform: 'standalonewindows',
    location: location,
    status: location == 'offline' ? UserStatus.offline : UserStatus.active,
    statusDescription: '',
    tags: const [],
  );
}

class _TestFriendsNotifier extends FriendsNotifier {
  _TestFriendsNotifier(this.friends);

  final List<LimitedUser> friends;
  static int buildCount = 0;

  @override
  Future<List<LimitedUser>> build() async {
    buildCount++;
    return friends;
  }
}
