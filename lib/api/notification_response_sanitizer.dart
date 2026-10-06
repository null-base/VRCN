abstract final class NotificationResponseSanitizer {
  static const _nullableRequiredKeys = [
    'expiryAfterSeen',
    'imageUrl',
    'link',
    'linkText',
    'linkTextKey',
    'relatedNotificationsId',
    'senderUsername',
    'titleKey',
  ];

  static void sanitize(String path, dynamic data) {
    if (!_isNotificationPath(path)) return;

    if (data is List) {
      for (final value in data) {
        if (value is Map) _sanitizeNotification(value);
      }
      return;
    }

    if (data is Map && _looksLikeNotification(data)) {
      _sanitizeNotification(data);
    }
  }

  static void _sanitizeNotification(Map<dynamic, dynamic> value) {
    // VRChat may omit sender information for system notifications, while
    // the generated model still requires a non-null senderUserId.
    if (value['senderUserId'] is! String) {
      value['senderUserId'] = '';
    }

    for (final key in _nullableRequiredKeys) {
      value.putIfAbsent(key, () => null);
    }

    if (value['data'] == null) {
      value['data'] = <String, String>{};
    }
    if (value['responses'] == null) {
      value['responses'] = <dynamic>[];
    }
    value.putIfAbsent('version', () => 2);
  }

  static bool _looksLikeNotification(Map<dynamic, dynamic> value) {
    return value.containsKey('senderUserId') ||
        value.containsKey('receiverUserId') ||
        (value.containsKey('type') && value.containsKey('createdAt'));
  }

  static bool _isNotificationPath(String path) {
    final parsedPath = Uri.tryParse(path)?.path ?? path.split('?').first;
    final normalizedPath = parsedPath.startsWith('/')
        ? parsedPath
        : '/$parsedPath';
    return normalizedPath == '/notifications' ||
        normalizedPath.endsWith('/notifications') ||
        normalizedPath.contains('/notifications/');
  }
}
