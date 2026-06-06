class AppConstants {
  AppConstants._();

  static const String appName = 'RENBOK';
  static const String studioName = 'by Primordial Studio';
  static const String tagline = 'Simpan Jejak, Bagikan Cerita';

  // Update for your environment
  static const String apiBaseUrl = 'http://10.0.2.2:3000'; // Android emulator → host
  // static const String apiBaseUrl = 'http://localhost:3000'; // iOS simulator

  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String onboardingKey = 'onboarding_complete';
  static const String interestsKey = 'interests_setup_complete';

  /// Set to true when login/register flow is ready.
  static const bool requireAuth = false;
}
