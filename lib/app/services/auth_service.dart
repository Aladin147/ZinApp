import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zinapp_v2/app/models/user_profile.dart';
import 'package:zinapp_v2/app/services/api_config.dart';
import 'package:zinapp_v2/app/services/mock_data.dart';

/// Exception thrown when authentication fails
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// Service responsible for authentication operations
class AuthService {
  final String baseUrl = ApiConfig.baseUrl;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Register a new user
  Future<UserProfile> register({
    required String email,
    required String password,
    required String username,
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
          'username': username,
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

        final user = UserProfile.fromJson(userData);

        // Save auth state
        await _saveAuthState(user.id, user);

        return user;
      } else {
        // Use real API
        // Check if user exists
        final checkResponse = await http.get(
          Uri.parse('$baseUrl/users?email=$email'),
        );

        final existingUsers = jsonDecode(checkResponse.body) as List;
        if (existingUsers.isNotEmpty) {
          throw AuthException('User already exists');
        }

        // Create new user
        final userId = 'user${DateTime.now().millisecondsSinceEpoch}';
        final response = await http.post(
          Uri.parse('$baseUrl/users'),
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode({
            'id': userId,
            'email': email,
            'password': password, // Plain text for MVP only
            'username': username,
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
          }),
        );

        if (response.statusCode == 201) {
          final userData = jsonDecode(response.body);
          final user = UserProfile.fromJson(userData);

          // Save auth state
          await _saveAuthState(user.id, user);

          return user;
        } else {
          throw AuthException('Failed to register: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Registration error: $e');
    }
  }

  /// Login existing user
  Future<UserProfile> login({
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

        final user = UserProfile.fromJson(userData);

        // Save auth state
        await _saveAuthState(user.id, user);

        return user;
      } else {
        // Use real API
        final response = await http.get(
          Uri.parse('$baseUrl/users?email=$email&password=$password'),
        );

        final users = jsonDecode(response.body) as List;

        if (users.isEmpty) {
          throw AuthException('Invalid credentials');
        }

        final userData = users.first;
        final user = UserProfile.fromJson(userData);

        // Update last login
        await http.patch(
          Uri.parse('$baseUrl/users/${user.id}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'lastLogin': DateTime.now().toIso8601String(),
          }),
        );

        // Save auth state
        await _saveAuthState(user.id, user);

        return user;
      }
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Login error: $e');
    }
  }

  /// Check if user is logged in
  Future<UserProfile?> getCurrentUser() async {
    try {
      final userId = await storage.read(key: 'user_id');
      if (userId == null) return null;

      final userJson = await storage.read(key: 'user_data');
      if (userJson == null) return null;

      final userData = jsonDecode(userJson);
      return UserProfile.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  /// Logout user
  Future<void> logout() async {
    await storage.delete(key: 'user_id');
    await storage.delete(key: 'user_data');
  }

  /// Save authentication state
  Future<void> _saveAuthState(String userId, UserProfile user) async {
    await storage.write(key: 'user_id', value: userId);
    await storage.write(key: 'user_data', value: jsonEncode(user.toJson()));
  }
}
