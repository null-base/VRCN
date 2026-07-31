import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/utils/app_logger.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

@immutable
class ProfileEditInput {
  const ProfileEditInput({
    required this.status,
    required this.statusDescription,
    required this.bio,
    required this.bioLinks,
    required this.pronouns,
  });

  final UserStatus status;
  final String statusDescription;
  final String bio;
  final Iterable<String> bioLinks;
  final String pronouns;
}

class ProfileEditController {
  const ProfileEditController(this.ref);

  final Ref ref;

  Future<void> save(ProfileEditInput input) async {
    final updateRequest = UpdateUserRequest(
      status: input.status,
      statusDescription: input.statusDescription,
      bio: input.bio,
      bioLinks: input.bioLinks
          .map((link) => link.trim())
          .where((link) => link.isNotEmpty)
          .toList(),
      pronouns: input.pronouns,
    );

    await ref.read(updateUserProvider(updateRequest).future);
    ref.invalidate(currentUserProvider);

    try {
      await ref.read(currentUserProvider.future);
    } catch (error) {
      appLogger.d('ユーザー情報の再取得中にエラーが発生: $error');
    }
  }
}

final profileEditControllerProvider = Provider<ProfileEditController>((ref) {
  return ProfileEditController(ref);
});
