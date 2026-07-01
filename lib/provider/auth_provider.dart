import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/auth_refresh_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';

// 軽量なセッション認証状態を管理するプロバイダー
final sessionAuthStateProvider = FutureProvider<bool>((ref) async {
  ref.watch(authRefreshProvider);

  try {
    final api = await ref.read(vrchatAuthProvider.future);
    return api.currentUser != null;
  } catch (e) {
    return false;
  }
});
