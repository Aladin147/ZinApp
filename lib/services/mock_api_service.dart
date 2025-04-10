import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'api_service.dart';

// TODO: Replace placeholder models with actual model imports
// import '../models/models.dart';

/// Mock implementation of the ApiService using local data (initially placeholders).
/// Simulates network delays and basic success/failure scenarios.
class MockApiService implements ApiService {
  // TODO: Implement loading and caching of mock JSON data from assets
  // For now, using placeholder data and simulated delays.
  final Random _random = Random();

  Future<void> _simulateDelay({int minMillis = 200, int maxMillis = 800}) async {
    final delay = minMillis + _random.nextInt(maxMillis - minMillis);
    await Future.delayed(Duration(milliseconds: delay));
  }

  // --- Method Implementations ---

  @override
  Future<UserProfile> getUserProfile(String userId) async {
    await _simulateDelay();
    print('MockApiService: Fetching profile for $userId');
    // TODO: Load from users.json and return actual UserProfile model
    if (userId == 'user123') { // Example user
      return const UserProfile(/* Mock data here */);
    } else {
      throw Exception('Mock User not found'); // Simulate not found
    }
  }

  @override
  Future<List<Stylist>> getNearbyStylists(double lat, double lon) async {
    await _simulateDelay();
    print('MockApiService: Fetching nearby stylists for $lat, $lon');
    // TODO: Load from stylists.json and return List<Stylist>
    // Simulate returning a list of 1-5 stylists
    final count = 1 + _random.nextInt(5);
    return List.generate(count, (_) => const Stylist(/* Mock data */));
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
    // TODO: Simulate adding to bookings.json
    // Simulate success/failure randomly or based on input
    return _random.nextBool(); // 50% chance of success
  }

  @override
  Future<void> updateUserXP(String userId, int xpGained) async {
    await _simulateDelay(minMillis: 50, maxMillis: 200);
    print('MockApiService: Updating XP for user $userId by $xpGained');
    // TODO: Implement logic to update mock users.json (in memory or file)
    // This would likely involve calling a GamificationService internally
  }

  @override
  Future<void> updateUserTokens(String userId, int tokensGained) async {
    await _simulateDelay(minMillis: 50, maxMillis: 200);
    print('MockApiService: Updating Tokens for user $userId by $tokensGained');
    // TODO: Implement logic to update mock users.json (in memory or file)
    // This would likely involve calling a GamificationService internally
  }

  @override
  Future<List<Post>> getFeedPosts(String userId) async {
    await _simulateDelay();
    print('MockApiService: Fetching feed posts for $userId');
    // TODO: Load from posts.json and return List<Post>
    final count = 5 + _random.nextInt(10); // Simulate 5-14 posts
    return List.generate(count, (_) => const Post(/* Mock data */));
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
    // TODO: Simulate adding to ratings.json
    // TODO: Trigger XP update via updateUserXP
    return true; // Assume success for now
  }

  // --- Helper to load JSON (Example - needs refinement for actual use) ---
  // Future<Map<String, dynamic>> _loadJsonAsset(String assetPath) async {
  //   try {
  //     final String jsonString = await rootBundle.loadString(assetPath);
  //     return jsonDecode(jsonString) as Map<String, dynamic>;
  //   } catch (e) {
  //     print("Error loading mock JSON asset $assetPath: $e");
  //     return {};
  //   }
  // }
}
