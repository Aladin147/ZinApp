import 'dart:async';

import 'package:zinapp_v2/features/auth/models/auth_user.dart';
import 'package:zinapp_v2/features/auth/services/auth_service.dart';

/// A mock implementation of AuthService for development and testing
class MockAuthService implements AuthService {
  final StreamController<AuthUser> _authStateController = StreamController<AuthUser>.broadcast();
  AuthUser _currentUser = AuthUser.empty();
  
  // Mock user database
  final Map<String, _MockUser> _users = {};
  
  MockAuthService() {
    // Add some mock users for testing
    _addMockUser(
      email: 'user@example.com',
      password: 'password123',
      displayName: 'Test User',
      isStylist: false,
    );
    
    _addMockUser(
      email: 'stylist@example.com',
      password: 'password123',
      displayName: 'Test Stylist',
      isStylist: true,
    );
  }
  
  void _addMockUser({
    required String email,
    required String password,
    String? displayName,
    bool isStylist = false,
  }) {
    final uid = 'mock-uid-${_users.length + 1}';
    _users[email] = _MockUser(
      uid: uid,
      email: email,
      password: password,
      displayName: displayName,
      isStylist: isStylist,
    );
  }
  
  @override
  Stream<AuthUser> get authStateChanges => _authStateController.stream;
  
  @override
  AuthUser get currentUser => _currentUser;
  
  @override
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user exists
    final user = _users[email];
    if (user == null) {
      throw Exception('User not found');
    }
    
    // Check password
    if (user.password != password) {
      throw Exception('Invalid password');
    }
    
    // Update current user
    _currentUser = AuthUser(
      uid: user.uid,
      email: user.email,
      isEmailVerified: true, // Mock as verified
      displayName: user.displayName,
      photoURL: null,
      createdAt: DateTime.now().subtract(const Duration(days: 30)), // Mock creation date
      lastSignInAt: DateTime.now(),
      isStylist: user.isStylist,
    );
    
    // Emit auth state change
    _authStateController.add(_currentUser);
    
    return _currentUser;
  }
  
  @override
  Future<AuthUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user already exists
    if (_users.containsKey(email)) {
      throw Exception('Email already in use');
    }
    
    // Create new user
    final uid = 'mock-uid-${_users.length + 1}';
    _users[email] = _MockUser(
      uid: uid,
      email: email,
      password: password,
    );
    
    // Update current user
    _currentUser = AuthUser(
      uid: uid,
      email: email,
      isEmailVerified: false, // New users start unverified
      createdAt: DateTime.now(),
      lastSignInAt: DateTime.now(),
    );
    
    // Emit auth state change
    _authStateController.add(_currentUser);
    
    return _currentUser;
  }
  
  @override
  Future<AuthUser> signInWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Create a mock Google user
    const email = 'google-user@example.com';
    const uid = 'google-uid-123';
    
    // Add to users if not exists
    if (!_users.containsKey(email)) {
      _users[email] = _MockUser(
        uid: uid,
        email: email,
        password: 'google-auth', // Not used for Google auth
        displayName: 'Google User',
      );
    }
    
    // Update current user
    _currentUser = AuthUser(
      uid: uid,
      email: email,
      isEmailVerified: true, // Google users are verified
      displayName: 'Google User',
      photoURL: 'https://example.com/google-profile.jpg',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      lastSignInAt: DateTime.now(),
    );
    
    // Emit auth state change
    _authStateController.add(_currentUser);
    
    return _currentUser;
  }
  
  @override
  Future<AuthUser> signInWithApple() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Create a mock Apple user
    const email = 'apple-user@example.com';
    const uid = 'apple-uid-123';
    
    // Add to users if not exists
    if (!_users.containsKey(email)) {
      _users[email] = _MockUser(
        uid: uid,
        email: email,
        password: 'apple-auth', // Not used for Apple auth
        displayName: 'Apple User',
      );
    }
    
    // Update current user
    _currentUser = AuthUser(
      uid: uid,
      email: email,
      isEmailVerified: true, // Apple users are verified
      displayName: 'Apple User',
      photoURL: null,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastSignInAt: DateTime.now(),
    );
    
    // Emit auth state change
    _authStateController.add(_currentUser);
    
    return _currentUser;
  }
  
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user exists
    if (!_users.containsKey(email)) {
      throw Exception('User not found');
    }
    
    // In a real implementation, this would send an email
    print('Password reset email sent to $email');
  }
  
  @override
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user is authenticated
    if (!_currentUser.isAuthenticated) {
      throw Exception('User not authenticated');
    }
    
    // Update user
    _currentUser = _currentUser.copyWith(
      displayName: displayName,
      photoURL: photoURL,
    );
    
    // Update in mock database
    final user = _users[_currentUser.email];
    if (user != null) {
      user.displayName = displayName;
    }
    
    // Emit auth state change
    _authStateController.add(_currentUser);
  }
  
  @override
  Future<void> updateEmail({required String email}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user is authenticated
    if (!_currentUser.isAuthenticated) {
      throw Exception('User not authenticated');
    }
    
    // Check if email is already in use
    if (_users.containsKey(email) && _users[email]!.uid != _currentUser.uid) {
      throw Exception('Email already in use');
    }
    
    // Remove old email entry
    final user = _users.remove(_currentUser.email);
    if (user != null) {
      // Add with new email
      _users[email] = user..email = email;
    }
    
    // Update current user
    _currentUser = _currentUser.copyWith(email: email);
    
    // Emit auth state change
    _authStateController.add(_currentUser);
  }
  
  @override
  Future<void> updatePassword({required String password}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user is authenticated
    if (!_currentUser.isAuthenticated) {
      throw Exception('User not authenticated');
    }
    
    // Update password in mock database
    final user = _users[_currentUser.email];
    if (user != null) {
      user.password = password;
    }
  }
  
  @override
  Future<void> sendEmailVerification() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user is authenticated
    if (!_currentUser.isAuthenticated) {
      throw Exception('User not authenticated');
    }
    
    // In a real implementation, this would send an email
    print('Email verification sent to ${_currentUser.email}');
    
    // For mock purposes, automatically verify the email
    _currentUser = _currentUser.copyWith(isEmailVerified: true);
    
    // Emit auth state change
    _authStateController.add(_currentUser);
  }
  
  @override
  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Reset current user
    _currentUser = AuthUser.empty();
    
    // Emit auth state change
    _authStateController.add(_currentUser);
  }
  
  @override
  Future<void> deleteUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user is authenticated
    if (!_currentUser.isAuthenticated) {
      throw Exception('User not authenticated');
    }
    
    // Remove from mock database
    _users.remove(_currentUser.email);
    
    // Reset current user
    _currentUser = AuthUser.empty();
    
    // Emit auth state change
    _authStateController.add(_currentUser);
  }
  
  @override
  Future<void> setIsStylist({required bool isStylist}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Check if user is authenticated
    if (!_currentUser.isAuthenticated) {
      throw Exception('User not authenticated');
    }
    
    // Update user
    _currentUser = _currentUser.copyWith(isStylist: isStylist);
    
    // Update in mock database
    final user = _users[_currentUser.email];
    if (user != null) {
      user.isStylist = isStylist;
    }
    
    // Emit auth state change
    _authStateController.add(_currentUser);
  }
  
  /// Dispose of resources
  void dispose() {
    _authStateController.close();
  }
}

/// Internal class for mock user data
class _MockUser {
  final String uid;
  String email;
  String password;
  String? displayName;
  bool isStylist;
  
  _MockUser({
    required this.uid,
    required this.email,
    required this.password,
    this.displayName,
    this.isStylist = false,
  });
}
