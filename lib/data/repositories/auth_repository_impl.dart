import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/data/datasources/remote/user_remote_data_source.dart';
import 'package:zinapp_v2/models/user.dart';
import 'package:zinapp_v2/services/local_storage_service.dart';

/// Abstract class defining the authentication repository contract.
abstract class AuthRepository {
  /// Attempts to log in a user with email and password.
  /// Returns the User object on success, null on failure (e.g., wrong password).
  /// Throws exceptions for network or other errors.
  Future<User?> login({required String email, required String password});

  /// Logs out the current user.
  Future<void> logout();

  /// Registers a new user.
  /// Returns the newly created User object.
  /// Throws exceptions on failure (e.g., email already exists).
  Future<User> register({
    required String email,
    required String password,
    required String username,
  });

  /// Gets the currently logged-in user, potentially from local storage.
  Future<User?> getCurrentUser();
}

/// Implementation of the [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  final UserRemoteDataSource _remoteDataSource;
  final LocalStorageService _localStorageService;

  AuthRepositoryImpl(this._remoteDataSource, this._localStorageService);

  @override
  Future<User?> login({required String email, required String password}) async {
    try {
      // 1. Fetch user by email from the mock server
      // 1. Fetch user by email from the mock server
      final user = await _remoteDataSource.getUserByEmail(email);

      // 2. Check if user exists (Password check removed as 'password' is not in User model)
      if (user != null) {
        // 3. Save user ID (or mock token) to local storage
        await _localStorageService.saveMockUserId(user.id);
        // await _localStorageService.saveMockSessionToken('mock-token-${user.id}');
        return user;
      } else {
        // Invalid email or password
        return null;
      }
    } catch (e) {
      // Propagate network or other errors
      print('Login error in repository: $e');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Clear local session data
      await _localStorageService.clearMockUserSession();
      // In a real app, might also call a backend logout endpoint
    } catch (e) {
      print('Logout error in repository: $e');
      // Decide how to handle logout errors (e.g., log, but proceed)
    }
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String username,
  }) async {
    // In a real app, you'd check if email exists first.
    // json-server doesn't enforce uniqueness easily, so we simulate success.
    try {
       // Create a basic user object - ID will be assigned by json-server on POST
       // Or generate a temporary one if needed before POST response.
      final newUser = User(
        id: 'temp-${DateTime.now().millisecondsSinceEpoch}', // Temporary ID
        email: email,
        username: username,
        // password: password, // Removed - Not in User model
        userType: UserType.regular,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        // Removed fields not present in User model:
        // xp, level, tokens, achievements, badges, rank, counts, streak etc.
        // These likely belong in a UserProfile model fetched separately.
      );

      // TODO: Implement POST request to create user via UserRemoteDataSource
      // This would likely involve creating both a User and a UserProfile record.
      // For now, just return the locally created user for simulation
      // final createdUser = await _remoteDataSource.createUser(newUser); // Assuming createUser exists

      // Simulate saving session after registration
      await _localStorageService.saveMockUserId(newUser.id);
      // await _localStorageService.saveMockSessionToken('mock-token-${newUser.id}');

      return newUser; // Return the locally created user for now
    } catch (e) {
      print('Registration error in repository: $e');
      rethrow;
    }
  }

   @override
  Future<User?> getCurrentUser() async {
    try {
      // 1. Check local storage for a saved user ID/token
      final userId = _localStorageService.getMockUserId();
      // final token = _localStorageService.getMockSessionToken();

      if (userId != null) {
        // 2. If found, fetch the full user details from the remote source
        // In a real app, you might validate the token first
        final user = await _remoteDataSource.getUserById(userId);
        return user;
      } else {
        // No user session found locally
        return null;
      }
    } catch (e) {
      // Handle errors (e.g., network error fetching user, invalid stored ID)
      print('Error getting current user: $e');
      // Optionally clear local storage if session seems invalid
      // await _localStorageService.clearMockUserSession();
      return null;
    }
  }
}

// --- Riverpod Provider ---
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  final localStorageService = ref.watch(localStorageServiceProvider);
  return AuthRepositoryImpl(remoteDataSource, localStorageService);
});
