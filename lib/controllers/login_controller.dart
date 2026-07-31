import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/auth_refresh_provider.dart';
import 'package:vrchat/provider/auth_storage_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/utils/app_logger.dart';

enum LoginFlowStatus { success, requiresTwoFactor, failure }

@immutable
class LoginFlowResult {
  const LoginFlowResult._(this.status, [this.error]);

  const LoginFlowResult.success() : this._(LoginFlowStatus.success);
  const LoginFlowResult.requiresTwoFactor()
    : this._(LoginFlowStatus.requiresTwoFactor);
  const LoginFlowResult.failure([Object? error])
    : this._(LoginFlowStatus.failure, error);
  final LoginFlowStatus status;
  final Object? error;
}

class LoginController {
  LoginController(this.ref);
  final Ref ref;

  Future<LoginFlowResult> login({
    required String username,
    required String password,
    required bool rememberLogin,
  }) async {
    try {
      final auth = await ref.read(vrchatAuthProvider.future);
      final (success, failure) = await auth.login(
        username: username,
        password: password,
      );

      if (success == null) {
        return LoginFlowResult.failure(failure);
      }

      if (success.data.requiresTwoFactorAuth) {
        return const LoginFlowResult.requiresTwoFactor();
      }

      if (rememberLogin) {
        await ref.read(authStorageProvider).saveCredentials(username, password);
      } else {
        await ref.read(authStorageProvider).clearCredentials();
      }

      await completeLogin();
      return const LoginFlowResult.success();
    } catch (e) {
      return LoginFlowResult.failure(e);
    }
  }

  Future<LoginFlowResult> verifyTwoFactorCode({
    required String code,
    required String username,
    required String password,
    required bool rememberLogin,
  }) async {
    try {
      final auth = await ref.read(vrchatAuthProvider.future);
      final (success, failure) = await auth.verify2fa(code);

      if (success == null) {
        return LoginFlowResult.failure(failure);
      }

      if (rememberLogin) {
        await ref.read(authStorageProvider).saveCredentials(username, password);
      } else {
        await ref.read(authStorageProvider).clearCredentials();
      }

      await completeLogin();
      return const LoginFlowResult.success();
    } catch (e) {
      return LoginFlowResult.failure(e);
    }
  }

  Future<void> completeLogin() async {
    ref.read(authRefreshProvider.notifier).state++;

    try {
      await ref.read(currentUserProvider.future);
    } catch (e) {
      appLogger.d('ログイン後のユーザー情報取得でエラー: $e');
    }
  }

  String? extractTwoFactorCode(String? text) {
    if (text == null || text.isEmpty) return null;

    final digitsOnly = text.replaceAll(RegExp('[^0-9]'), '');
    if (digitsOnly.isEmpty) return null;

    return digitsOnly.length >= 6 ? digitsOnly.substring(0, 6) : digitsOnly;
  }
}

final loginControllerProvider = Provider<LoginController>((ref) {
  return LoginController(ref);
});
