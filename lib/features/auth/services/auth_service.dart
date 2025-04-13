import 'package:zinapp_v2/models/auth_user.dart';

/// Interface for authentication services in the ZinApp application
abstract class AuthService {
  /// Stream of authentication state changes
  Stream<AuthUser> get authStateChanges;

  /// The currently authenticated user
  AuthUser get currentUser;

  /// Signs in a user with email and password
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Creates a new user with email and password
  Future<AuthUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs in a user with Google
  Future<AuthUser> signInWithGoogle();

  /// Signs in a user with Apple (iOS only)
  Future<AuthUser> signInWithApple();

  /// Sends a password reset email
  Future<void> sendPasswordResetEmail({required String email});

  /// Updates a user's profile information
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  });

  /// Updates a user's email
  Future<void> updateEmail({required String email});

  /// Updates a user's password
  Future<void> updatePassword({required String password});

  /// Sends an email verification
  Future<void> sendEmailVerification();

  /// Signs out the current user
  Future<void> signOut();

  /// Deletes the current user
  Future<void> deleteUser();

  /// Sets whether the current user is a stylist
  Future<void> setIsStylist({required bool isStylist});
}
