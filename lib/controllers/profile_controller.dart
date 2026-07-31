import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class ProfileController {
  const ProfileController(this.ref);

  final Ref ref;

  Future<CurrentUser> reloadCurrentUser() async {
    ref.invalidate(currentUserProvider);
    return ref.read(currentUserProvider.future);
  }
}

final profileControllerProvider = Provider<ProfileController>((ref) {
  return ProfileController(ref);
});
