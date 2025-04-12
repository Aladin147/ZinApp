import 'dart:convert';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zinapp_v2/services/api_service.dart';

// import 'package:zinapp_v2/models/comment.dart'; // Unused import removed
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/user_profile.dart';
// --- End Placeholder Models ---


/// Mock implementation of the ApiService using local JSON data.
/// Simulates network delays and basic success/failure scenarios.
class MockApiService implements ApiService {
  final Random _random = Random();
  static const String _mockDataPath = 'assets/mock_data';

  // Cache for loaded mock data to avoid repeated file reads
  final Map<String, List<dynamic>> _mockDataCache = {};

  Future<void> _simulateDelay({int minMillis = 200, int maxMillis = 800}) async {
    final delay = minMillis + _random.nextInt(maxMillis - minMillis);
    await Future.delayed(Duration(milliseconds: delay));
  }

  /// Loads and caches a JSON file from the assets/mock_data directory.
  Future<List<dynamic>> _loadJsonList(String fileName) async {
    if (_mockDataCache.containsKey(fileName)) {
      print("Using cached data for $fileName");
      return _mockDataCache[fileName]!;
    }
    try {
      print("Loading mock data from $fileName");
      final String jsonString = await rootBundle.loadString('$_mockDataPath/$fileName');
      print("Successfully loaded JSON string from $fileName");
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      print("Successfully decoded JSON from $fileName: ${jsonList.length} items");
      _mockDataCache[fileName] = jsonList;
      return jsonList;
    } catch (e) {
      print("Error loading mock JSON asset $fileName: $e");
      // Create some fallback data for testing
      if (fileName == 'users.json') {
        print("Creating fallback user data");
        final fallbackData = [
          {
            "userId": "user123",
            "username": "Hassan",
            "profilePictureUrl": "",
            "xp": 150,
            "zinTokens": 50,
            "level": "Silver",
            "followingStylists": ["stylist456"],
            "followingUsers": [],
            "bookingHistory": []
          }
        ];
        _mockDataCache[fileName] = fallbackData;
        return fallbackData;
      } else if (fileName == 'posts.json') {
        print("Creating fallback post data");
        final fallbackData = [
          {
            "postId": "post001",
            "userId": "user123",
            "type": "general",
            "imageUrl": "",
            "caption": "This is a test post",
            "timestamp": DateTime.now().toIso8601String(),
            "likes": [],
            "comments": []
          }
        ];
        _mockDataCache[fileName] = fallbackData;
        return fallbackData;
      } else if (fileName == 'stylists.json') {
        print("Creating fallback stylist data");
        final fallbackData = [
          {
            "stylistId": "stylist456",
            "name": "Sarah J.",
            "profilePictureUrl": "",
            "rating": 4.8,
            "specialties": ["Fades", "Braids"],
            "servicesOffered": [],
            "availability": { "Monday": "9am-5pm" },
            "isAvailableNow": true,
            "location": { "latitude": 34.0, "longitude": -6.8 }
          }
        ];
        _mockDataCache[fileName] = fallbackData;
        return fallbackData;
      }
      return []; // Return empty list on error
    }
  }

  // --- Method Implementations ---

  @override
  Future<UserProfile> getUserProfile(String userId) async {
    await _simulateDelay();
    print('MockApiService: Fetching profile for $userId');
    final users = await _loadJsonList('users.json');
    final userData = users.firstWhere(
      (user) => user is Map<String, dynamic> && user['userId'] == userId,
      orElse: () => null,
    );

    if (userData != null) {
      return UserProfile.fromJson(userData as Map<String, dynamic>);
    } else {
      throw Exception('Mock User not found: $userId'); // Simulate not found
    }
  }

  @override
  Future<List<Stylist>> getNearbyStylists(double lat, double lon) async {
    await _simulateDelay();
    print('MockApiService: Fetching nearby stylists for $lat, $lon');
    final stylists = await _loadJsonList('stylists.json');
    // TODO: Implement actual location filtering if needed for mock
    return stylists
        .whereType<Map<String, dynamic>>()
        .map((data) => Stylist.fromJson(data))
        .toList();
  }

  @override
  Future<bool> submitBooking({
    required String userId,
    required String stylistId,
    required String serviceId,
    required DateTime bookingTime,
  }) async {
    await _simulateDelay(maxMillis: 1200);
    print('MockApiService: Submitting booking for user $userId, stylist $stylistId');
    // TODO: Simulate adding to bookings.json (in-memory cache update?)
    print('WARN: Mock booking submission always returns random success/fail.');
    return _random.nextBool(); // 50% chance of success
  }

  @override
  Future<void> updateUserXP(String userId, int xpGained) async {
    await _simulateDelay(minMillis: 50, maxMillis: 200);
    print('MockApiService: Simulating XP update for user $userId by $xpGained');
    // TODO: Implement logic to update mock users.json (in-memory cache update?)
    // This would likely involve calling a separate GamificationService internally
    // For now, just log it.
  }

  @override
  Future<void> updateUserTokens(String userId, int tokensGained) async {
    await _simulateDelay(minMillis: 50, maxMillis: 200);
    print('MockApiService: Simulating Token update for user $userId by $tokensGained');
    // TODO: Implement logic to update mock users.json (in-memory cache update?)
    // This would likely involve calling a separate GamificationService internally
    // For now, just log it.
  }

  @override
  Future<List<Post>> getFeedPosts(String userId) async {
    await _simulateDelay();
    print('MockApiService: Fetching feed posts for $userId');
    final posts = await _loadJsonList('posts.json');
     // TODO: Implement filtering/sorting based on userId if needed
    return posts
        .whereType<Map<String, dynamic>>()
        .map((data) => Post.fromJson(data))
        .toList();
  }

  @override
  Future<bool> submitRating({
    required String bookingId,
    required String userId,
    required String stylistId,
    required int score,
    String? comment,
  }) async {
    await _simulateDelay(maxMillis: 600);
    print('MockApiService: Submitting rating for booking $bookingId by user $userId');
    // TODO: Simulate adding to ratings.json (in-memory cache update?)
    // TODO: Trigger XP update via updateUserXP call
    print('WARN: Mock rating submission always returns true.');
    // Simulate calling XP update
    updateUserXP(userId, 5); // Example XP for rating
    return true; // Assume success for now
  }

}
