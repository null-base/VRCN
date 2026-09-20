import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/vrchat_extended_api_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/utils/app_logger.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrchat_dart_generated/vrchat_dart_generated.dart';

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

@immutable
class ProfileEditPayload {
  const ProfileEditPayload({
    required this.userRequest,
    required this.profileRequest,
  });

  final UpdateUserRequest userRequest;
  final UpdateProfileRequest profileRequest;
}

ProfileEditPayload buildProfileEditPayload(ProfileEditInput input) {
  final bioLinks = input.bioLinks
      .map((link) => link.trim())
      .where((link) => link.isNotEmpty)
      .toList();

  return ProfileEditPayload(
    userRequest: UpdateUserRequest(
      status: input.status,
      statusDescription: input.statusDescription,
      pronouns: input.pronouns,
    ),
    profileRequest: UpdateProfileRequest(
      bio: input.bio,
      bioLinks: bioLinks,
    ),
  );
}

class ProfileEditController {
  const ProfileEditController(this.ref);

  final Ref ref;

  Future<void> save(ProfileEditInput input) async {
    final payload = buildProfileEditPayload(input);
    final currentUser = await ref.read(currentUserProvider.future);

    await ref.read(updateUserProvider(payload.userRequest).future);

    final profileApi = await ref.read(vrchatProfileApiProvider.future);
    await profileApi.updateProfile(
      currentUser.id,
      payload.profileRequest,
    );

    ref.invalidate(currentUserProvider);
    ref.invalidate(currentUserPublicProfileProvider);
    ref.invalidate(currentUserProfileProvider);

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
