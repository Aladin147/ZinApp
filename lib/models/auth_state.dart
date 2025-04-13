import 'package:equatable/equatable.dart';
import 'package:zinapp_v2/models/user_profile.dart'; // Use UserProfile again
// import 'package:zinapp_v2/models/user.dart'; // No longer need base User here

/// Represents the current authentication state of the application
class AuthState extends Equatable {
  final bool isAuthenticated;
  final UserProfile? user; // Reverted to UserProfile
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.user, // Reverted type
    this.isLoading = false,
    this.error,
  });

  /// Initial unauthenticated state
  factory AuthState.initial() => const AuthState();

  /// Loading state during authentication operations
  factory AuthState.loading() => const AuthState(isLoading: true);

  /// Authenticated state with user data
  factory AuthState.authenticated(UserProfile user) => AuthState( // Expect UserProfile again
        isAuthenticated: true,
        user: user, // Reverted type
      );

  /// Error state with error message
  factory AuthState.error(String message) => AuthState(
        error: message,
      );

  @override
  List<Object?> get props => [isAuthenticated, user, isLoading, error];

  /// Creates a copy of this AuthState with the given fields replaced with new values
  AuthState copyWith({
    bool? isAuthenticated,
    UserProfile? user, // Reverted type
    bool? isLoading,
    String? error,
    // Add parameter to explicitly clear user on copy if needed
    bool clearUser = false,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      // Handle user update/clearing
      user: clearUser ? null : (user ?? this.user), // Reverted type
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  /// Clears the error message
  AuthState clearError() {
    // Use copyWith to maintain other state properties
    return copyWith(error: null);
  }
}
