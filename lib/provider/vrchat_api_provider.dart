import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/api/vrc_api_container.dart';
import 'package:vrchat/provider/auth_refresh_provider.dart';
import 'package:vrchat/provider/auth_storage_provider.dart';
import 'package:vrchat/services/vrchat_auth_service.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrchat/utils/app_logger.dart';

final apiInitializingProvider = StateProvider<bool>((ref) => true);

// FutureProviderでVRChatのAPIを非同期に初期化
final vrchatProvider = FutureProvider<VrchatDart>((ref) async {
  try {
    final vrchatApi = await VrcApiContainer().create();
    ref.read(apiInitializingProvider.notifier).state = false;
    return vrchatApi;
  } catch (e) {
    ref.read(apiInitializingProvider.notifier).state = false;
    appLogger.d('【ERROR】VRChat API初期化エラー: $e');
    rethrow;
  }
});

final FutureProvider<VrchatAuthService> vrchatAuthProvider = FutureProvider((
  ref,
) async {
  final api = await ref.watch(vrchatProvider.future);
  return VrchatAuthService(api);
});

final Provider<Future<VrchatDartGenerated>> vrchatRawApiProvider = Provider((
  ref,
) async {
  final api = await ref.watch(vrchatProvider.future);
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
    final (loginSuccess, _) = await api.login();

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
        appLogger.d('保存された認証情報でログインを試みます');

        // 保存された認証情報でログイン試行
        final (loginSuccess, _) = await api.login(
          username: credentials.username,
          password: credentials.password,
        );

        final credentialAuthResponse = loginSuccess?.data;
        if (loginSuccess != null &&
            credentialAuthResponse != null &&
            !credentialAuthResponse.requiresTwoFactorAuth) {
          // 認証状態更新
          ref.read(authRefreshProvider.notifier).state++;
          return true;
        }
      }
    }

    return false;
  } catch (e) {
    appLogger.d('自動ログイン失敗: $e');
    return false;
  }
});
