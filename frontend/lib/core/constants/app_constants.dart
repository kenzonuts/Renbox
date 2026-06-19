import 'package:flutter/foundation.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'RENBOK';
  static const String studioName = 'by Primordial Studio';
  static const String tagline = 'Simpan Jejak, Bagikan Cerita';

  // Web/iOS simulator use localhost. Android emulator reaches host via 10.0.2.2.
  static String get apiBaseUrl =>
      kIsWeb ? 'http://localhost:3000' : 'http://10.0.2.2:3000';

  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String onboardingKey = 'onboarding_complete';
  static const String interestsKey = 'interests_setup_complete';

  /// Require users to log in before accessing the app.
  static const bool requireAuth = true;

  /// Temporary UI-only mode. Set false when backend auth is ready.
  static const bool useDummyAuth = true;
}
