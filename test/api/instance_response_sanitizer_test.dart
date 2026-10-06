import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/api/instance_response_sanitizer.dart';

void main() {
  test('fills avatar fields omitted from instance users', () {
    final response = <String, dynamic>{
      'users': [
        <String, dynamic>{
          'id': 'usr_example',
          'imageUrl': 'https://example.com/avatar.png',
          'currentAvatarTags': 'removed-by-api',
        },
      ],
    };

    InstanceResponseSanitizer.sanitize(
      '/instances/wrld_example:12345~hidden',
      response,
    );

    final user = response['users'][0] as Map<String, dynamic>;
    expect(user['currentAvatarImageUrl'], 'https://example.com/avatar.png');
    expect(
      user['currentAvatarThumbnailImageUrl'],
      'https://example.com/avatar.png',
    );
    expect(user['currentAvatarTags'], isEmpty);
  });

  test('leaves non-instance responses unchanged', () {
    final response = <String, dynamic>{
      'users': [
        <String, dynamic>{'id': 'usr_example'},
      ],
    };

    InstanceResponseSanitizer.sanitize('/users', response);

    expect(response['users'][0], <String, dynamic>{'id': 'usr_example'});
  });
}
