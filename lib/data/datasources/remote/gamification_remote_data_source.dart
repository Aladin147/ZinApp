import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/models/achievement.dart'; // Assuming Achievement model exists
import 'package:zinapp_v2/models/badge.dart'; // Assuming Badge model exists
import 'package:zinapp_v2/models/challenge.dart'; // Assuming Challenge model exists
import 'package:zinapp_v2/models/token_transaction.dart'; // Assuming TokenTransaction model exists
import 'package:zinapp_v2/data/datasources/remote/user_remote_data_source.dart'; // For dioProvider

/// Abstract class for remote gamification data operations.
abstract class GamificationRemoteDataSource {
  /// Fetches all available achievement definitions.
  Future<List<Achievement>> getAchievementDefinitions();

  /// Fetches all available badge definitions.
  Future<List<Badge>> getBadgeDefinitions();

  /// Fetches all available challenge definitions.
  Future<List<Challenge>> getChallengeDefinitions();

  /// Fetches token transaction history for a user.
  Future<List<TokenTransaction>> getTokenTransactions(String userId);

  // Add methods for user-specific progress if needed (e.g., getUserChallenges)
  // Or potentially update user data directly via UserRemoteDataSource
}

/// Implementation of [GamificationRemoteDataSource] using Dio.
class GamificationRemoteDataSourceImpl implements GamificationRemoteDataSource {
  final Dio _dio;
  final String _baseUrl = 'http://127.0.0.1:3000';

  GamificationRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Achievement>> getAchievementDefinitions() async {
    try {
      final response = await _dio.get('$_baseUrl/achievements');
      if (response.statusCode == 200) {
        final List<dynamic> list = response.data as List<dynamic>;
        return list
            .map((json) => Achievement.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching achievement definitions: $e');
      throw Exception('Failed to fetch achievement definitions.');
    }
  }

  @override
  Future<List<Badge>> getBadgeDefinitions() async {
    try {
      final response = await _dio.get('$_baseUrl/badges');
      if (response.statusCode == 200) {
        final List<dynamic> list = response.data as List<dynamic>;
        return list
            .map((json) => Badge.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching badge definitions: $e');
      throw Exception('Failed to fetch badge definitions.');
    }
  }

   @override
  Future<List<Challenge>> getChallengeDefinitions() async {
    try {
      final response = await _dio.get('$_baseUrl/challenges');
      if (response.statusCode == 200) {
        final List<dynamic> list = response.data as List<dynamic>;
        return list
            .map((json) => Challenge.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching challenge definitions: $e');
      throw Exception('Failed to fetch challenge definitions.');
    }
  }

  @override
  Future<List<TokenTransaction>> getTokenTransactions(String userId) async {
     try {
      // Filter transactions by userId
      final response = await _dio.get(
        '$_baseUrl/tokenTransactions',
        queryParameters: {'userId': userId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> list = response.data as List<dynamic>;
        return list
            .map((json) => TokenTransaction.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching token transactions for user $userId: $e');
      throw Exception('Failed to fetch token transactions.');
    }
  }
}

// --- Riverpod Provider ---
final gamificationRemoteDataSourceProvider = Provider<GamificationRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return GamificationRemoteDataSourceImpl(dio);
});
