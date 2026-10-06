abstract final class InstanceResponseSanitizer {
  static void sanitize(String path, dynamic data) {
    if (!_isInstancePath(path) || data is! Map) return;

    final users = data['users'];
    if (users is! List) return;

    for (final user in users) {
      if (user is! Map) continue;

      final imageUrl = user['imageUrl'];
      final fallbackImageUrl = imageUrl is String ? imageUrl : '';
      user['currentAvatarImageUrl'] = _stringValue(
        user['currentAvatarImageUrl'],
        fallbackImageUrl,
      );
      user['currentAvatarThumbnailImageUrl'] = _stringValue(
        user['currentAvatarThumbnailImageUrl'],
        fallbackImageUrl,
      );

      final avatarTags = user['currentAvatarTags'];
      user['currentAvatarTags'] = avatarTags is List
          ? avatarTags.whereType<String>().toList(growable: false)
          : const <String>[];
    }
  }

  static bool _isInstancePath(String path) {
    return path == '/instances' || path.startsWith('/instances/');
  }

  static String _stringValue(dynamic value, String fallback) {
    return value is String ? value : fallback;
  }
}
