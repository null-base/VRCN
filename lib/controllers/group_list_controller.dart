import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/user_provider.dart';

class GroupListController {
  const GroupListController(this.ref);

  final Ref ref;

  Future<void> refreshCurrentUser() async {
    ref.invalidate(currentUserProvider);
    await ref.read(currentUserProvider.future);
  }

  Future<void> refreshUserGroups(String userId) async {
    ref.invalidate(userGroupsProvider(userId));
    await ref.read(userGroupsProvider(userId).future);
  }
}

final groupListControllerProvider = Provider<GroupListController>((ref) {
  return GroupListController(ref);
});
