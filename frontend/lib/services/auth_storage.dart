import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/constants/app_constants.dart';

class AuthStorage {
  AuthStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: AppConstants.tokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(
        key: AppConstants.refreshTokenKey,
        value: refreshToken,
      );
    }
  }

  Future<String?> getAccessToken() =>
      _storage.read(key: AppConstants.tokenKey);

  Future<void> clearTokens() async {
    await _storage.delete(key: AppConstants.tokenKey);
    await _storage.delete(key: AppConstants.refreshTokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> setOnboardingComplete(bool value) async {
    await _storage.write(
      key: AppConstants.onboardingKey,
      value: value.toString(),
    );
  }

  Future<bool> isOnboardingComplete() async {
    final v = await _storage.read(key: AppConstants.onboardingKey);
    return v == 'true';
  }

  Future<void> setInterestsSetupComplete(bool value) async {
    await _storage.write(
      key: AppConstants.interestsKey,
      value: value.toString(),
    );
  }

  Future<bool> isInterestsSetupComplete() async {
    final v = await _storage.read(key: AppConstants.interestsKey);
    return v == 'true';
  }
}
