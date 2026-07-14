import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vrchat/utils/app_logger.dart';

/// 認証情報を安全に保存するためのクラス
class AuthStorageService {
  static const _usernameKey = 'vrchat_username';
  static const _passwordKey = 'vrchat_password';
  static const _rememberLoginKey = 'vrchat_remember_login';

  final _secureStorage = const FlutterSecureStorage();

  // ユーザー名を保存
  Future<void> saveUsername(String username) async {
    await _secureStorage.write(key: _usernameKey, value: username);
  }

  // パスワードを保存
  Future<void> savePassword(String password) async {
    await _secureStorage.write(key: _passwordKey, value: password);
  }

  // 認証情報を保存（ユーザー名とパスワードの両方）
  Future<void> saveCredentials(String username, String password) async {
    await saveUsername(username);
    await savePassword(password);
    await setRememberLogin(true);
    appLogger.d('認証情報を安全に保存しました');
  }

  // ユーザー名を取得
  Future<String?> getUsername() async {
    return _secureStorage.read(key: _usernameKey);
  }

  // パスワードを取得
  Future<String?> getPassword() async {
    return _secureStorage.read(key: _passwordKey);
  }

  // 認証情報を取得（ユーザー名とパスワードの両方）
  Future<({String? username, String? password})> getCredentials() async {
    final username = await getUsername();
    final password = await getPassword();
    return (username: username, password: password);
  }

  // 認証情報を削除
  Future<void> clearCredentials() async {
    await _secureStorage.delete(key: _usernameKey);
    await _secureStorage.delete(key: _passwordKey);
    await setRememberLogin(false);
    appLogger.d('保存された認証情報を削除しました');
  }

  // 自動ログインの設定を保存
  Future<void> setRememberLogin(bool remember) async {
    await _secureStorage.write(
      key: _rememberLoginKey,
      value: remember.toString(),
    );
  }

  // 自動ログインの設定を取得
  Future<bool> getRememberLogin() async {
    final value = await _secureStorage.read(key: _rememberLoginKey);
    return value == 'true';
  }
}
