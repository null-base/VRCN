import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/group_provider.dart';
import 'package:vrchat/utils/share_utils.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class GroupDetailController {
  const GroupDetailController(this.ref);

  final Ref ref;

  Future<Group> refresh(String groupId) {
    return ref.refresh(
      groupDetailProvider(
        GroupDetailParams(groupId: groupId, includeRoles: true),
      ).future,
    );
  }

  Future<void> shareGroup(Group group) {
    return ShareUtils.shareUrl(
      'https://vrchat.com/home/group/${group.id}',
      subject: group.name,
    );
  }
}

final groupDetailControllerProvider = Provider<GroupDetailController>((ref) {
  return GroupDetailController(ref);
});
