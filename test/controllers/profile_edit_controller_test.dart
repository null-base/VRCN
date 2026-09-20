import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/controllers/profile_edit_controller.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

void main() {
  test('splits profile fields from the legacy user update request', () {
    final payload = buildProfileEditPayload(
      const ProfileEditInput(
        status: UserStatus.active,
        statusDescription: 'Available',
        bio: 'Hello',
        bioLinks: [' https://example.com ', ''],
        pronouns: 'they/them',
      ),
    );

    expect(payload.profileRequest.bio, 'Hello');
    expect(payload.profileRequest.bioLinks, ['https://example.com']);
    expect(payload.userRequest.status, UserStatus.active);
    expect(payload.userRequest.statusDescription, 'Available');
    expect(payload.userRequest.pronouns, 'they/them');
  });
}
