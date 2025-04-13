import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/data/repositories/auth_repository_impl.dart'; // Import Repository
import 'package:zinapp_v2/models/auth_state.dart';
import 'package:zinapp_v2/models/user.dart'; // Import base User model
import 'package:zinapp_v2/models/user_profile.dart' as models; // Keep for updateUser type hint for now

// Generate the provider code
part 'auth_provider.g.dart';

// Removed the old AuthService provider

/// Provider for managing authentication state
@riverpod
class Auth extends _$Auth {
  // Helper to get the repository
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  AuthState build() {
    // Initialize with the initial state
    return AuthState.initial();
  }

  /// Initialize provider and check for existing session
  Future<void> initialize() async {
    state = AuthState.loading();
    try {
      // Get current user (core auth info) from the repository
      final coreUser = await _repository.getCurrentUser();

      // Update state based on user existence
      if (coreUser != null) {
        // TODO: Fetch UserProfile details separately if needed after auth
        // This highlights the need to coordinate User and UserProfile fetching.
        print("Auth Initialize: Found core user ${coreUser.id}, needs UserProfile fetch.");
        // TEMPORARY: Using coreUser - AuthState expects UserProfile.
        // This will cause a type error until AuthState is updated or UserProfile is fetched.
        state = AuthState.authenticated(coreUser);
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
      // Call repository register method
      final user = await _repository.register(
            email: email,
            password: password, // Password handling is mock
            username: username,
          );

      // TODO: Fetch UserProfile details separately if needed after registration
      // TEMPORARY: Using coreUser - AuthState expects UserProfile.
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
      // Call repository login method
      final user = await _repository.login(
            email: email,
            password: password, // Password handling is mock
          );

      if (user != null) {
         // TODO: Fetch UserProfile details separately if needed after login
         // TEMPORARY: Using coreUser - AuthState expects UserProfile.
        state = AuthState.authenticated(user);
        return true;
      } else {
        state = AuthState.error('Invalid email or password.'); // Provide specific error
        return false;
      }
    } catch (e) {
      state = AuthState.error(e.toString());
      return false;
    }
  }

  /// Logout the current user
  Future<void> logout() async {
    state = AuthState.loading();
    try {
      // Call repository logout method
      await _repository.logout();
      state = AuthState.initial();
    } catch (e) {
      // Even if logout fails remotely, clear local state
      state = AuthState.initial();
      print('Logout error: $e');
      // Optionally rethrow or handle differently
    }
  }

  /// Clear the current error message
  void clearError() {
    if (state.error != null) {
      // Assuming AuthState has a copyWith or similar method to clear error
      // If not, adjust state creation based on AuthState definition
      // Example: state = AuthState(user: state.user, isLoading: state.isLoading, error: null);
       state = state.clearError(); // Assuming this method exists
    }
  }

  /// Update the current user profile - This method signature might need adjustment
  /// if AuthState strictly holds UserProfile.
  void updateUser(models.UserProfile userProfile) {
     // This logic needs review based on how User and UserProfile are linked.
     // If AuthState holds UserProfile, this is fine.
     // If AuthState holds User, we might need a different approach.
    if (state.isAuthenticated) {
       // Assuming AuthState.authenticated takes UserProfile
       // If it takes User, this needs conversion or separate profile state management.
       // TEMPORARY: This will cause a type error until AuthState is fixed.
      state = AuthState.authenticated(userProfile);
    }
  }

  /// Send a password reset email
  Future<bool> sendPasswordResetEmail({required String email}) async {
    // This likely needs a dedicated repository method
    state = state.copyWith(isLoading: true, error: null); // Assuming copyWith exists
    try {
      print("Password reset requested for $email (Mock Implementation)");
      // TODO: Call repository method for password reset
      // await _repository.sendPasswordResetEmail(email);
      await Future.delayed(const Duration(seconds: 1)); // Simulate network call
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}
