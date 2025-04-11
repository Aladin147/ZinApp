import 'package:zinapp_v2/features/auth/models/auth_user.dart';
import 'package:zinapp_v2/features/auth/services/auth_service.dart';

/// Repository for authentication operations in the ZinApp application
class AuthRepository {
  final AuthService _authService;
  
  AuthRepository(this._authService);
  
  /// Stream of authentication state changes
  Stream<AuthUser> get authStateChanges => _authService.authStateChanges;
  
  /// The currently authenticated user
  AuthUser get currentUser => _authService.currentUser;
  
  /// Signs in a user with email and password
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Translate service-specific errors to app-specific errors
      throw _mapAuthException(e);
    }
  }
  
  /// Creates a new user with email and password
  Future<AuthUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Signs in a user with Google
  Future<AuthUser> signInWithGoogle() async {
    try {
      return await _authService.signInWithGoogle();
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Signs in a user with Apple (iOS only)
  Future<AuthUser> signInWithApple() async {
    try {
      return await _authService.signInWithApple();
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Sends a password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Updates a user's profile information
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      await _authService.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Updates a user's email
  Future<void> updateEmail({required String email}) async {
    try {
      await _authService.updateEmail(email: email);
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Updates a user's password
  Future<void> updatePassword({required String password}) async {
    try {
      await _authService.updatePassword(password: password);
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Sends an email verification
  Future<void> sendEmailVerification() async {
    try {
      await _authService.sendEmailVerification();
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Signs out the current user
  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Deletes the current user
  Future<void> deleteUser() async {
    try {
      await _authService.deleteUser();
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Sets whether the current user is a stylist
  Future<void> setIsStylist({required bool isStylist}) async {
    try {
      await _authService.setIsStylist(isStylist: isStylist);
    } catch (e) {
      throw _mapAuthException(e);
    }
  }
  
  /// Maps service-specific exceptions to app-specific exceptions
  Exception _mapAuthException(dynamic e) {
    // In a real app, this would map Firebase Auth exceptions to app-specific exceptions
    return Exception(e.toString());
  }
}
