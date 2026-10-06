import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/services/friend_status_widget_service.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('vrcn/friend_status_widget');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final calls = <MethodCall>[];

  setUp(() {
    calls.clear();
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return null;
    });
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('sends only watched friends and sorts online presence first', () async {
    await const FriendStatusWidgetService().update(
      friends: [
        _friend('offline', 'Offline', UserStatus.active, 'offline'),
        _friend('online-z', 'Zed', UserStatus.offline, 'private'),
        _friend('online-a', 'Alice', UserStatus.busy, 'wrld_example:1'),
        _friend('unwatched', 'Unwatched', UserStatus.active, 'private'),
      ],
      watchedIds: {'offline', 'online-z', 'online-a'},
    );

    expect(calls, hasLength(1));
    expect(calls.single.method, 'update');
    final arguments = calls.single.arguments as Map<Object?, Object?>;
    final friends = arguments['friends']! as List<Object?>;
    final entries = friends.cast<Map<Object?, Object?>>();

    expect(
      entries.map((entry) => entry['id']),
      ['online-a', 'online-z', 'offline'],
    );
    expect(entries.map((entry) => entry['isOnline']), [true, true, false]);
    expect(entries[1]['status'], 'active');

    final allFriends = (arguments['allFriends']! as List<Object?>)
        .cast<Map<Object?, Object?>>();
    expect(
      allFriends.map((entry) => entry['id']),
      ['online-a', 'unwatched', 'online-z', 'offline'],
    );
  });
}

LimitedUser _friend(
  String id,
  String name,
  UserStatus status,
  String location,
) {
  return LimitedUser(
    developerType: DeveloperType.none,
    displayName: name,
    id: id,
    isFriend: true,
    lastPlatform: 'standalonewindows',
    location: location,
    status: status,
    statusDescription: '',
    tags: const [],
  );
}
