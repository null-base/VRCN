import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/avatar_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

@immutable
class AvatarListRequest {
  const AvatarListRequest({
    required this.params,
    required this.sortByName,
  });

  final AvatarSearchParams params;
  final bool sortByName;
}

class AvatarListController {
  const AvatarListController(this.ref);

  final Ref ref;

  Future<List<Avatar>> fetch(AvatarListRequest request) async {
    final avatars = await ref.read(avatarSearchProvider(request.params).future);
    if (!request.sortByName) return avatars;
    return [...avatars]..sort((a, b) => a.name.compareTo(b.name));
  }

  List<Avatar> sortByName(Iterable<Avatar> avatars) {
    return [...avatars]..sort((a, b) => a.name.compareTo(b.name));
  }
}

final avatarListControllerProvider = Provider<AvatarListController>((ref) {
  return AvatarListController(ref);
});
