import 'package:flutter/foundation.dart';
import 'package:zinapp_v2/models/auth_state.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/auth_service.dart';

/// Provider for managing authentication state
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  AuthState _state = AuthState.initial();
  
  /// Current authentication state
  AuthState get state => _state;
  
  /// Whether the user is authenticated
  bool get isAuthenticated => _state.isAuthenticated;
  
  /// Current user profile
  UserProfile? get user => _state.user;
  
  /// Whether authentication is in progress
  bool get isLoading => _state.isLoading;
  
  /// Current error message
  String? get error => _state.error;
  
  /// Initialize provider and check for existing session
  Future<void> initialize() async {
    _setState(AuthState.loading());
    
    try {
      final user = await _authService.getCurrentUser();
      
      if (user != null) {
        _setState(AuthState.authenticated(user));
      } else {
        _setState(AuthState.initial());
      }
    } catch (e) {
      _setState(AuthState.error(e.toString()));
    }
  }
  
  /// Register a new user
  Future<bool> register({
    required String email,
    required String password,
    required String username,
  }) async {
    _setState(AuthState.loading());
    
    try {
      final user = await _authService.register(
        email: email,
        password: password,
        username: username,
      );
      
      _setState(AuthState.authenticated(user));
      return true;
    } catch (e) {
      _setState(AuthState.error(e.toString()));
      return false;
    }
  }
  
  /// Login an existing user
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setState(AuthState.loading());
    
    try {
      final user = await _authService.login(
        email: email,
        password: password,
      );
      
      _setState(AuthState.authenticated(user));
      return true;
    } catch (e) {
      _setState(AuthState.error(e.toString()));
      return false;
    }
  }
  
  /// Logout the current user
  Future<void> logout() async {
    _setState(AuthState.loading());
    
    try {
      await _authService.logout();
      _setState(AuthState.initial());
    } catch (e) {
      _setState(AuthState.error(e.toString()));
    }
  }
  
  /// Clear the current error message
  void clearError() {
    if (_state.error != null) {
      _setState(_state.clearError());
    }
  }
  
  /// Update the current user profile
  void updateUser(UserProfile user) {
    if (_state.isAuthenticated) {
      _setState(AuthState.authenticated(user));
    }
  }
  
  /// Update the authentication state
  void _setState(AuthState state) {
    _state = state;
    notifyListeners();
  }
}
