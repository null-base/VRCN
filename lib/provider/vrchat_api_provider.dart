import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/api/vrc_api_container.dart';
import 'package:vrchat/provider/auth_storage_provider.dart';
import 'package:vrchat/router/app_router.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final vrchatApiProvider = Provider<Future<VrchatDart>>((ref) {
  return VrcApiContainer().create();
});

final apiInitializingProvider = StateProvider<bool>((ref) => true);

// FutureProviderでVRChatのAPIを非同期に初期化
final vrchatProvider = FutureProvider<VrchatDart>((ref) async {
  final apiPromise = ref.watch(vrchatApiProvider);
  try {
    final vrchatApi = await apiPromise;
    ref.read(apiInitializingProvider.notifier).state = false;
    return vrchatApi;
  } catch (e) {
    ref.read(apiInitializingProvider.notifier).state = false;
    debugPrint('【ERROR】VRChat API初期化エラー: $e');
    rethrow;
  }
});

final vrchatAuthProvider = FutureProvider((ref) async {
  final api = await ref.watch(vrchatApiProvider);
  return api.auth;
});
final vrchatRawApiProvider = Provider((ref) async {
  final api = await ref.watch(vrchatApiProvider);
  return api.rawApi;
});

// 自動ログイン処理を行うプロバイダー
final autoLoginProvider = FutureProvider<bool>((ref) async {
  try {
    // API初期化待機
    final api = await ref.watch(vrchatAuthProvider.future);

    // 既にログイン済みかチェック
    if (api.currentUser != null) {
      // 既にログイン済みなら認証状態更新
      ref.read(authRefreshProvider.notifier).state++;
      return true;
    }

    // 保存されたセッションを使ってログインを試みる
    final (loginSuccess, loginFailure) = await api.login();

    final authResponse = loginSuccess?.data;

    // セッションが有効ならログイン成功
    if (loginSuccess != null && !authResponse!.requiresTwoFactorAuth) {
      // 認証状態更新
      ref.read(authRefreshProvider.notifier).state++;
      return true;
    }

    // 保存された認証情報を使用してログイン試行
    final authStorage = ref.read(authStorageProvider);
    final shouldRemember = await authStorage.getRememberLogin();

    if (shouldRemember) {
      final credentials = await authStorage.getCredentials();

      if (credentials.username != null &&
          credentials.password != null &&
          credentials.username!.isNotEmpty &&
          credentials.password!.isNotEmpty) {
        debugPrint('保存された認証情報でログインを試みます');

        // 保存された認証情報でログイン試行
        final (loginSuccess, loginFailure) = await api.login(
          username: credentials.username!,
          password: credentials.password!,
        );

        if (loginSuccess != null && !authResponse!.requiresTwoFactorAuth) {
          // 認証状態更新
          ref.read(authRefreshProvider.notifier).state++;
          return true;
        }
      }
    }

    // デバッグモードで.env認証情報がある場合に使用
    if (kDebugMode) {
      final username = dotenv.env['VRCHAT_USERNAME'];
      final password = dotenv.env['VRCHAT_PASSWORD'];

      if (username != null &&
          password != null &&
          username.isNotEmpty &&
          password.isNotEmpty) {
        // .envの認証情報でログイン試行
        final (loginSuccess, loginFailure) = await api.login(
          username: username,
          password: password,
        );

        if (loginSuccess != null) {
          // 認証状態更新
          ref.read(authRefreshProvider.notifier).state++;
          return true;
        }
      }
    }

    return false;
  } catch (e) {
    debugPrint('自動ログイン失敗: $e');
    return false;
  }
});
