import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/models/auth_state.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/auth_service.dart';

// Generate the provider code
part 'auth_provider.g.dart';

/// Provider for the AuthService
@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthService();
}

/// Provider for managing authentication state
@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    // Initialize with the initial state
    return AuthState.initial();
  }

  /// Initialize provider and check for existing session
  Future<void> initialize() async {
    state = AuthState.loading();

    try {
      final user = await ref.read(authServiceProvider).getCurrentUser();

      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = AuthState.initial();
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Register a new user
  Future<bool> register({
    required String email,
    required String password,
    required String username,
  }) async {
    state = AuthState.loading();

    try {
      final user = await ref.read(authServiceProvider).register(
            email: email,
            password: password,
            username: username,
          );

      state = AuthState.authenticated(user);
      return true;
    } catch (e) {
      state = AuthState.error(e.toString());
      return false;
    }
  }

  /// Login an existing user
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();

    try {
      final user = await ref.read(authServiceProvider).login(
            email: email,
            password: password,
          );

      state = AuthState.authenticated(user);
      return true;
    } catch (e) {
      state = AuthState.error(e.toString());
      return false;
    }
  }

  /// Logout the current user
  Future<void> logout() async {
    state = AuthState.loading();

    try {
      await ref.read(authServiceProvider).logout();
      state = AuthState.initial();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Clear the current error message
  void clearError() {
    if (state.error != null) {
      state = state.clearError();
    }
  }

  /// Update the current user profile
  void updateUser(UserProfile user) {
    if (state.isAuthenticated) {
      state = AuthState.authenticated(user);
    }
  }
}
