import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/api/notification_response_sanitizer.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

void main() {
  test('fills fields omitted from system notifications', () {
    final response = <dynamic>[
      <String, dynamic>{
        'canDelete': false,
        'category': '',
        'createdAt': '2026-01-01T00:00:00Z',
        'data': <String, String>{},
        'expiresAt': '2026-01-02T00:00:00Z',
        'expiryAfterSeen': null,
        'id': 'not_example',
        'ignoreDND': false,
        'imageUrl': null,
        'isSystem': true,
        'link': null,
        'linkText': null,
        'linkTextKey': null,
        'message': 'System notification',
        'receiverUserId': 'usr_receiver',
        'relatedNotificationsId': null,
        'requireSeen': false,
        'responses': <dynamic>[],
        'seen': false,
        'senderUserId': null,
        'senderUsername': null,
        'title': 'System notification',
        'titleKey': null,
        'type': 'text.adventure',
        'updatedAt': '2026-01-01T00:00:00Z',
        'version': 2,
      },
    ];

    NotificationResponseSanitizer.sanitize('/notifications', response);

    final notification = response.first as Map<String, dynamic>;
    expect(notification['senderUserId'], isEmpty);
    expect(notification['imageUrl'], isNull);
    expect(notification['senderUsername'], isNull);
    expect(notification['responses'], isEmpty);
    expect(notification['data'], <String, String>{});
    expect(notification['version'], 2);

    final parsed = NotificationV2.fromJson(notification);
    expect(parsed.senderUserId, isEmpty);
  });

  test('leaves non-notification responses unchanged', () {
    final response = <dynamic>[
      <String, dynamic>{'senderUserId': null},
    ];

    NotificationResponseSanitizer.sanitize('/users', response);

    expect(response.first, <String, dynamic>{'senderUserId': null});
  });

  test('sanitizes a single notification response', () {
    final response = <String, dynamic>{
      'createdAt': '2026-01-01T00:00:00Z',
      'senderUserId': null,
      'type': 'text.adventure',
    };

    NotificationResponseSanitizer.sanitize(
      'https://api.vrchat.cloud/api/1/notifications/not_example/see',
      response,
    );

    expect(response['senderUserId'], isEmpty);
    expect(response['senderUsername'], isNull);
    expect(response['responses'], isEmpty);
  });
}
