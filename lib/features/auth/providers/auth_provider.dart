import 'package:flutter/foundation.dart';
import 'package:zinapp_v2/features/auth/models/auth_user.dart';
import 'package:zinapp_v2/features/auth/repositories/auth_repository.dart';

/// Provider for authentication state in the ZinApp application
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  
  /// The currently authenticated user
  AuthUser _user;
  
  /// Loading state for authentication operations
  bool _isLoading = false;
  
  /// Error message from the last operation
  String? _errorMessage;
  
  AuthProvider(this._authRepository) : _user = _authRepository.currentUser {
    // Listen for auth state changes
    _authRepository.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }
  
  /// The currently authenticated user
  AuthUser get user => _user;
  
  /// Whether the user is authenticated
  bool get isAuthenticated => _user.isAuthenticated;
  
  /// Whether the user is a stylist
  bool get isStylist => _user.isStylist;
  
  /// Loading state for authentication operations
  bool get isLoading => _isLoading;
  
  /// Error message from the last operation
  String? get errorMessage => _errorMessage;
  
  /// Signs in a user with email and password
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  /// Creates a new user with email and password
  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  /// Signs in a user with Google
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authRepository.signInWithGoogle();
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  /// Signs in a user with Apple (iOS only)
  Future<bool> signInWithApple() async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authRepository.signInWithApple();
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  /// Sends a password reset email
  Future<bool> sendPasswordResetEmail({required String email}) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authRepository.sendPasswordResetEmail(email: email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  /// Updates a user's profile information
  Future<bool> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authRepository.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  /// Sets whether the current user is a stylist
  Future<bool> setIsStylist({required bool isStylist}) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authRepository.setIsStylist(isStylist: isStylist);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  /// Signs out the current user
  Future<bool> signOut() async {
    _setLoading(true);
    _clearError();
    
    try {
      await _authRepository.signOut();
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }
  
  /// Sets the loading state
  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
  
  /// Sets the error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
  
  /// Clears the error message
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
