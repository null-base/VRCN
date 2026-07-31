import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/models/avtrdb_search_result.dart';
import 'package:vrchat/provider/avtrdb_provider.dart';

class AvatarSearchController {
  const AvatarSearchController(this.ref);

  final Ref ref;

  Future<List<AvtrDbSearchResult>> refresh(String query) {
    return ref.refresh(avtrDbSearchProvider(query).future);
  }
}

final avatarSearchControllerProvider = Provider<AvatarSearchController>((ref) {
  return AvatarSearchController(ref);
});
