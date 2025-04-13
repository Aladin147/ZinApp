import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/models/user_profile.dart'; // Assuming UserProfile model exists
import 'package:zinapp_v2/data/datasources/remote/user_remote_data_source.dart'; // For dioProvider and _baseUrl

/// Abstract class for remote user profile data operations.
abstract class UserProfileRemoteDataSource {
  /// Fetches a user profile by their user ID.
  /// Note: db.json uses the user ID as the profile ID within the users collection.
  Future<UserProfile> getUserProfile(String userId);

  /// Updates a user profile.
  Future<UserProfile> updateUserProfile(UserProfile userProfile);

  // Add other profile-specific methods if needed
}

/// Implementation of [UserProfileRemoteDataSource] using Dio.
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final Dio _dio;
  // Re-use the base URL, consider centralizing it later
  final String _baseUrl = 'http://127.0.0.1:3000';

  UserProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<UserProfile> getUserProfile(String userId) async {
    try {
      // Fetch the full user object which contains profile details in db.json
      final response = await _dio.get('$_baseUrl/users/$userId');

      if (response.statusCode == 200) {
        // Assuming UserProfile has a fromJson factory
        return UserProfile.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load user profile: Status code ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print('DioError fetching user profile $userId: $e');
      throw Exception('Network error fetching user profile: ${e.message}');
    } catch (e) {
      print('Error fetching user profile $userId: $e');
      throw Exception('Failed to fetch user profile data.');
    }
  }

  @override
  Future<UserProfile> updateUserProfile(UserProfile userProfile) async {
    try {
      // Use PUT or PATCH on the /users/{id} endpoint as db.json stores profile data there
      final response = await _dio.patch( // Using PATCH for partial updates
        '$_baseUrl/users/${userProfile.id}',
        data: userProfile.toJson(), // Assuming UserProfile has toJson method
      );

      if (response.statusCode == 200) {
        return UserProfile.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to update user profile: Status code ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print('DioError updating user profile ${userProfile.id}: $e');
      throw Exception('Network error updating user profile: ${e.message}');
    } catch (e) {
      print('Error updating user profile ${userProfile.id}: $e');
      throw Exception('Failed to update user profile data.');
    }
  }
}

// --- Riverpod Provider ---

/// Provider for the UserProfileRemoteDataSource implementation.
final userProfileRemoteDataSourceProvider = Provider<UserProfileRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider); // Reuse existing Dio instance
  return UserProfileRemoteDataSourceImpl(dio);
});
