import 'package:equatable/equatable.dart';
import 'package:zinapp_v2/app/models/user_profile.dart';

/// Represents the current authentication state of the application
class AuthState extends Equatable {
  final bool isAuthenticated;
  final UserProfile? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.user,
    this.isLoading = false,
    this.error,
  });

  /// Initial unauthenticated state
  factory AuthState.initial() => const AuthState();

  /// Loading state during authentication operations
  factory AuthState.loading() => const AuthState(isLoading: true);

  /// Authenticated state with user data
  factory AuthState.authenticated(UserProfile user) => AuthState(
        isAuthenticated: true,
        user: user,
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
    UserProfile? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  /// Clears the error message
  AuthState clearError() {
    return AuthState(
      isAuthenticated: isAuthenticated,
      user: user,
      isLoading: isLoading,
      error: null,
    );
  }
}
