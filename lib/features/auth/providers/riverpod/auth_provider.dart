import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/data/repositories/auth_repository_impl.dart';
import 'package:zinapp_v2/data/repositories/user_profile_repository_impl.dart'; // Import UserProfile Repo
import 'package:zinapp_v2/models/auth_state.dart';
import 'package:zinapp_v2/models/user.dart';
import 'package:zinapp_v2/models/user_profile.dart'; // Import UserProfile model

// Generate the provider code
part 'auth_provider.g.dart';

/// Provider for managing authentication state
@riverpod
class Auth extends _$Auth {
  // Helper to get repositories
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);
  UserProfileRepository get _profileRepository => ref.read(userProfileRepositoryProvider);

  @override
  AuthState build() {
    // Initialize with the initial state
    // Consider triggering initialize() here or from the app's root widget
    return AuthState.initial();
  }

  /// Initialize provider and check for existing session
  Future<void> initialize() async {
    state = AuthState.loading();
    try {
      // Get current user (core auth info) from the auth repository
      final coreUser = await _authRepository.getCurrentUser();

      if (coreUser != null) {
        // If core user exists, fetch the full UserProfile
        try {
          final userProfile = await _profileRepository.getUserProfile(coreUser.id);
          state = AuthState.authenticated(userProfile); // Use UserProfile
        } catch (profileError) {
          // Handle error fetching profile (e.g., profile deleted but auth session remained)
          print('Error fetching profile during init for user ${coreUser.id}: $profileError');
          // Decide recovery strategy: logout or stay in error state?
          await _authRepository.logout(); // Logout if profile fetch fails
          state = AuthState.error('Failed to load user profile.');
        }
      } else {
        // No core user session found
        state = AuthState.initial();
      }
    } catch (e) {
      // Error fetching core user
      print('Error initializing auth: $e');
      state = AuthState.error('Failed to check authentication status.');
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
      // Call repository register method (returns base User)
      final user = await _authRepository.register(
            email: email,
            password: password, // Password handling is mock
            username: username,
          );

      // After successful registration, fetch the corresponding UserProfile
      // Note: The register method in repo currently returns a locally created User.
      // A real implementation would POST to create the user AND profile,
      // then fetch the created profile. We simulate fetching here.
      try {
        // It's crucial that the backend/mock server actually creates the user profile
        // record during registration for this fetch to succeed.
        // If registration only creates the base User, this fetch will fail.
        // We might need to adjust the register repository method or db.json structure.
        // For now, assuming profile exists after registration.
        final userProfile = await _profileRepository.getUserProfile(user.id);
        state = AuthState.authenticated(userProfile); // Use UserProfile
        return true;
      } catch (profileError) {
         print('Error fetching profile after registration for user ${user.id}: $profileError');
         // Registration succeeded but profile fetch failed - critical issue
         // Might need rollback logic or specific error state
         state = AuthState.error('Registration complete, but failed to load profile.');
         return false; // Indicate overall failure to the UI
      }
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
      // Call repository login method (returns base User or null)
      final user = await _authRepository.login(
            email: email,
            password: password, // Password handling is mock
          );

      if (user != null) {
         // If login successful, fetch the UserProfile
         try {
           final userProfile = await _profileRepository.getUserProfile(user.id);
           state = AuthState.authenticated(userProfile); // Use UserProfile
           return true;
         } catch (profileError) {
            print('Error fetching profile after login for user ${user.id}: $profileError');
            // Login succeeded but profile fetch failed
            // Attempt logout to clear inconsistent state
            await logout();
            state = AuthState.error('Login successful, but failed to load profile.');
            return false; // Indicate overall failure to the UI
         }
      } else {
        // Login failed (invalid credentials)
        state = AuthState.error('Invalid email or password.');
        return false;
      }
    } catch (e) {
      // Error during login attempt (network etc.)
      print('Login error: $e');
      state = AuthState.error('An error occurred during login.');
      return false;
    }
  }

  /// Logout the current user
  Future<void> logout() async {
    // No need for loading state here, just clear session
    try {
      // Call repository logout method (clears local storage)
      await _authRepository.logout();
    } catch (e) {
      print('Logout repository error: $e');
      // Log error but proceed to clear state anyway
    } finally {
       // Always clear the state regardless of repository outcome
      state = AuthState.initial();
    }
  }

  /// Clear the current error message
  void clearError() {
    if (state.error != null) {
       state = state.clearError(); // Use method from AuthState
    }
  }

  /// Update the current user profile
  /// This method now correctly receives and updates the UserProfile in the state.
  void updateUser(UserProfile userProfile) {
    // Only update if currently authenticated and the ID matches
    if (state.isAuthenticated && state.user?.id == userProfile.id) {
      state = AuthState.authenticated(userProfile);
    }
  }

  /// Send a password reset email
  Future<bool> sendPasswordResetEmail({required String email}) async {
    // This likely needs a dedicated repository method in AuthRepository
    // For now, keep the mock implementation
    state = state.copyWith(isLoading: true, error: null);
    try {
      print("Password reset requested for $email (Mock Implementation)");
      // TODO: Call repository method for password reset
      // await _authRepository.sendPasswordResetEmail(email);
      await Future.delayed(const Duration(seconds: 1)); // Simulate network call
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}
