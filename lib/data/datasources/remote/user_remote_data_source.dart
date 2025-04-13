import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/models/user.dart'; // Use package import

// Define the base URL for the mock server
const String _baseUrl = 'http://127.0.0.1:3000';

/// Abstract class for remote user data operations.
abstract class UserRemoteDataSource {
  /// Fetches a user profile by their ID.
  Future<User> getUserById(String userId);

  /// Updates a user profile.
  Future<User> updateUser(User user);

  /// Fetches a user by email (useful for login simulation).
  Future<User?> getUserByEmail(String email);
}

/// Implementation of [UserRemoteDataSource] using Dio.
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSourceImpl(this._dio);

  @override
  Future<User> getUserById(String userId) async {
    try {
      final response = await _dio.get('$_baseUrl/users/$userId');

      if (response.statusCode == 200) {
        // Assuming User has a fromJson factory
        return User.fromJson(response.data as Map<String, dynamic>);
      } else {
        // Handle non-200 responses appropriately
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load user: Status code ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      // Handle Dio specific errors (network, timeout, etc.)
      print('DioError fetching user $userId: $e');
      // Re-throw or handle as needed, maybe return a custom error state
      throw Exception('Network error fetching user: ${e.message}');
    } catch (e) {
      // Handle other potential errors during parsing etc.
      print('Error fetching user $userId: $e');
      throw Exception('Failed to fetch user data.');
    }
  }

  @override
  Future<User> updateUser(User user) async {
    try {
      // Use PUT for full replacement or PATCH for partial update
      // json-server supports both
      final response = await _dio.put(
        '$_baseUrl/users/${user.id}',
        data: user.toJson(), // Assuming UserModel has toJson method
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to update user: Status code ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print('DioError updating user ${user.id}: $e');
      throw Exception('Network error updating user: ${e.message}');
    } catch (e) {
      print('Error updating user ${user.id}: $e');
      throw Exception('Failed to update user data.');
    }
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    try {
      // json-server allows filtering via query parameters
      final response = await _dio.get(
        '$_baseUrl/users',
        queryParameters: {'email': email},
      );

      if (response.statusCode == 200) {
        final List<dynamic> users = response.data as List<dynamic>;
        if (users.isNotEmpty) {
          // Assuming email is unique, return the first match
          return User.fromJson(users.first as Map<String, dynamic>);
        } else {
          // No user found with that email
          return null;
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to query user by email: Status code ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print('DioError querying user by email $email: $e');
      throw Exception('Network error querying user: ${e.message}');
    } catch (e) {
      print('Error querying user by email $email: $e');
      throw Exception('Failed to query user data.');
    }
  }
}

// --- Riverpod Providers ---

/// Provider for the Dio instance.
/// Can be configured with interceptors, base options etc. later.
final dioProvider = Provider<Dio>((ref) {
  // Basic Dio instance for now
  return Dio();
});

/// Provider for the UserRemoteDataSource implementation.
final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRemoteDataSourceImpl(dio);
});
