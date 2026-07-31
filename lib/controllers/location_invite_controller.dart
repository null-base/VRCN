import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/invite_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class LocationInviteController {
  const LocationInviteController(this.ref);

  final Ref ref;

  Future<void> inviteMyself(User user) async {
    final worldId = user.worldId;
    final instanceId = user.instanceId;
    if (worldId == null || instanceId == null) {
      throw StateError('Invite target is missing world or instance id');
    }

    await ref.read(
      inviteMyselfProvider(
        InviteParams(worldId: worldId, instanceId: instanceId),
      ).future,
    );
  }
}

final locationInviteControllerProvider = Provider<LocationInviteController>((
  ref,
) {
  return LocationInviteController(ref);
});
