import 'package:dio_response_validator/dio_response_validator.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class VrchatAuthService {
  const VrchatAuthService(this._api);

  final VrchatDart _api;

  CurrentUser? get currentUser => _api.auth.currentUser;

  Future<TransformedResponse<dynamic, AuthResponse>> login({
    String? username,
    String? password,
  }) {
    return _api.auth.login(username: username, password: password);
  }

  Future<TransformedResponse<dynamic, AuthResponse>> verify2fa(String code) {
    return _api.auth.verify2fa(code);
  }

  Future<ValidatedResponse<Success>> logout() {
    return _api.auth.logout();
  }
}
