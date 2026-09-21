import 'package:riverpod/riverpod.dart';

import '../core/secure_storage_service.dart';

class AuthTokenStore {
  String? _authToken;
  DateTime? _expiresAt;
  final SecureStorageService _secureStorageService;

  static const String tokenStorageKey = 'account_auth_token';
  static const String tokenExpirationStorageKey = 'account_auth_token_expiration';

  AuthTokenStore({required this._secureStorageService});

  void setToken(String token, DateTime expiresAt) {
    this._authToken = token;
    this._expiresAt = expiresAt;
    _secureStorageService
      ..writeString(tokenStorageKey, token)
      ..writeString(tokenExpirationStorageKey, expiresAt.toIso8601String());
  }

  void clear() {
    _authToken = null;
    _expiresAt = null;
    _secureStorageService
      ..delete(tokenStorageKey)
      ..delete(tokenExpirationStorageKey);
  }

  Future<String?> get authorizationHeader async {
    String? token = _authToken;
    if (token == null && await _secureStorageService.exists(tokenStorageKey)) {
      token = await _secureStorageService.readString(tokenStorageKey);
    }

    DateTime? expiresAt = _expiresAt;
    if (expiresAt == null && await _secureStorageService.exists(tokenExpirationStorageKey)) {
      expiresAt = DateTime.tryParse(await _secureStorageService.readString(tokenExpirationStorageKey));
    }

    if (expiresAt != null && DateTime.now().isAfter(expiresAt.subtract(Duration(seconds: 30)))) {
      clear();
      expiresAt = null;
    }

    return token != null && expiresAt != null ? 'Bearer ' + token : null;
  }
}

final authTokenStoreProvider = Provider<AuthTokenStore>((ref) {
  return AuthTokenStore(secureStorageService: ref.read(secureStorageServiceProvider));
});
