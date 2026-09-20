import 'package:vrchat_dart_generated/vrchat_dart_generated.dart';

class VrchatProfileApi {
  const VrchatProfileApi(this._usersApi);

  final UsersApi _usersApi;

  Future<PublicProfile> getPublicProfile(
    String userId, {
    bool asSelf = false,
  }) async {
    final response = await _usersApi.getPublicProfile(
      userId: userId,
      asSelf: asSelf,
    );
    final profile = response.data;
    if (profile == null) {
      throw StateError('Public profile was empty for $userId');
    }
    return profile;
  }

  Future<PublicProfile> updateProfile(
    String userId,
    UpdateProfileRequest request,
  ) async {
    final response = await _usersApi.updateProfile(
      userId: userId,
      updateProfileRequest: request,
    );
    final profile = response.data;
    if (profile == null) {
      throw StateError('Updated public profile was empty for $userId');
    }
    return profile;
  }
}
