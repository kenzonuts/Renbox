import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/dummy_data.dart';
import '../../../models/profile_model.dart';
import '../../../services/api_service.dart';
import '../../../services/auth_storage.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.profile,
    this.isLoading = false,
    this.error,
  });

  final AuthStatus status;
  final ProfileModel? profile;
  final bool isLoading;
  final String? error;

  AuthState copyWith({
    AuthStatus? status,
    ProfileModel? profile,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._api, this._storage) : super(const AuthState()) {
    _init();
  }

  final ApiService _api;
  final AuthStorage _storage;

  Future<void> _init() async {
    if (!AppConstants.requireAuth) {
      state = AuthState(
        status: AuthStatus.authenticated,
        profile: DummyData.demoProfile,
      );
      return;
    }

    if (AppConstants.useDummyAuth) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }

    final loggedIn = await _storage.isLoggedIn();
    if (!loggedIn) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }
    try {
      final profile = await _api.getMe();
      state = AuthState(status: AuthStatus.authenticated, profile: profile);
    } catch (_) {
      await _storage.clearTokens();
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    if (AppConstants.useDummyAuth) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      await _storage.saveTokens(accessToken: 'dummy_access_token');
      state = AuthState(
        status: AuthStatus.authenticated,
        profile: DummyData.demoProfile,
      );
      return true;
    }

    try {
      final res = await _api.login({'email': email, 'password': password});
      final data = res['data'] as Map<String, dynamic>;
      await _storage.saveTokens(
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String?,
      );
      final profile = await _api.getMe();
      state = AuthState(status: AuthStatus.authenticated, profile: profile);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.unauthenticated,
      );
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
    required String username,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    if (AppConstants.useDummyAuth) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      await _storage.saveTokens(accessToken: 'dummy_access_token');
      state = AuthState(
        status: AuthStatus.authenticated,
        profile: DummyData.demoProfile,
      );
      return true;
    }

    try {
      final res = await _api.register({
        'email': email,
        'password': password,
        'full_name': fullName,
        'username': username,
      });
      final data = res['data'] as Map<String, dynamic>;
      if (data['access_token'] != null) {
        await _storage.saveTokens(
          accessToken: data['access_token'] as String,
          refreshToken: data['refresh_token'] as String?,
        );
        final profile = await _api.getMe();
        state = AuthState(status: AuthStatus.authenticated, profile: profile);
      } else {
        state = state.copyWith(isLoading: false);
      }
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.clearTokens();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void setProfile(ProfileModel profile) {
    state = state.copyWith(profile: profile);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(apiServiceProvider),
    ref.watch(authStorageProvider),
  );
});
