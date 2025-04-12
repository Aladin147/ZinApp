import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/api_config.dart';
import 'package:zinapp_v2/services/mock_data.dart';
import 'package:zinapp_v2/features/auth/models/auth_user.dart';
import 'package:zinapp_v2/features/auth/services/auth_service.dart';

/// Exception thrown when authentication fails
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// Implementation of the AuthService interface using HTTP and secure storage
class AuthServiceImpl implements AuthService {
  final String baseUrl = ApiConfig.baseUrl;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  
  AuthUser _currentUser = AuthUser.empty();
  
  @override
  AuthUser get currentUser => _currentUser;
  
  @override
  Stream<AuthUser> get authStateChanges => throw UnimplementedError();

  @override
  Future<AuthUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Use mock data if configured
      if (ApiConfig.useMockData) {
        // Check if user exists in mock data
        final existingUsers = MockData.users.where((user) => user['email'] == email).toList();
        if (existingUsers.isNotEmpty) {
          throw AuthException('User already exists');
        }

        // Create new user with mock data
        final userId = 'user${DateTime.now().millisecondsSinceEpoch}';
        final userData = {
          'id': userId,
          'email': email,
          'password': password, // Plain text for MVP only
          'username': email.split('@')[0], // Default username from email
          'profilePictureUrl': 'assets/images/avatars/default.png',
          'xp': 0,
          'level': 1,
          'tokens': 10, // Starting tokens
          'achievements': [],
          'badges': [],
          'rank': 'Style Novice',
          'userType': 'regular',
          'postsCount': 0,
          'bookingsCount': 0,
          'followersCount': 0,
          'followingCount': 0,
          'createdAt': DateTime.now().toIso8601String(),
          'lastLogin': DateTime.now().toIso8601String(),
        };

        // Add to mock data (this won't persist between app restarts)
        MockData.users.add(userData);

        // Create AuthUser from user data
        final authUser = AuthUser(
          uid: userId,
          email: email,
          isEmailVerified: false,
          displayName: email.split('@')[0],
          photoURL: 'assets/images/avatars/default.png',
          createdAt: DateTime.now(),
          lastSignInAt: DateTime.now(),
          isStylist: false,
        );
        
        // Save auth state
        await _saveAuthState(authUser);
        _currentUser = authUser;
        
        return authUser;
      } else {
        // Use real API
        // Implementation for real API would go here
        throw UnimplementedError('Real API implementation not yet available');
      }
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Registration error: $e');
    }
  }

  @override
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Use mock data if configured
      if (ApiConfig.useMockData) {
        // Find user in mock data
        final users = MockData.users.where(
          (user) => user['email'] == email && user['password'] == password,
        ).toList();

        if (users.isEmpty) {
          throw AuthException('Invalid credentials');
        }

        final userData = Map<String, dynamic>.from(users.first);

        // Update last login
        userData['lastLogin'] = DateTime.now().toIso8601String();

        // Create AuthUser from user data
        final authUser = AuthUser(
          uid: userData['id'],
          email: userData['email'],
          isEmailVerified: true, // Assume verified for mock data
          displayName: userData['username'],
          photoURL: userData['profilePictureUrl'],
          createdAt: DateTime.parse(userData['createdAt']),
          lastSignInAt: DateTime.now(),
          isStylist: userData['userType'] == 'stylist',
        );
        
        // Save auth state
        await _saveAuthState(authUser);
        _currentUser = authUser;
        
        return authUser;
      } else {
        // Use real API
        // Implementation for real API would go here
        throw UnimplementedError('Real API implementation not yet available');
      }
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Login error: $e');
    }
  }

  @override
  Future<AuthUser> signInWithGoogle() {
    throw UnimplementedError('Google sign-in not implemented yet');
  }

  @override
  Future<AuthUser> signInWithApple() {
    throw UnimplementedError('Apple sign-in not implemented yet');
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    throw UnimplementedError('Password reset not implemented yet');
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) {
    throw UnimplementedError('Profile update not implemented yet');
  }

  @override
  Future<void> updateEmail({required String email}) {
    throw UnimplementedError('Email update not implemented yet');
  }

  @override
  Future<void> updatePassword({required String password}) {
    throw UnimplementedError('Password update not implemented yet');
  }

  @override
  Future<void> sendEmailVerification() {
    throw UnimplementedError('Email verification not implemented yet');
  }

  @override
  Future<void> signOut() async {
    await storage.delete(key: 'user_id');
    await storage.delete(key: 'user_data');
    _currentUser = AuthUser.empty();
  }

  @override
  Future<void> deleteUser() {
    throw UnimplementedError('User deletion not implemented yet');
  }

  @override
  Future<void> setIsStylist({required bool isStylist}) {
    throw UnimplementedError('Stylist status update not implemented yet');
  }

  /// Save authentication state
  Future<void> _saveAuthState(AuthUser user) async {
    await storage.write(key: 'user_id', value: user.uid);
    await storage.write(key: 'user_data', value: jsonEncode(user.toJson()));
  }
}
