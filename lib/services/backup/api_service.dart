import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/models/stylist.dart';
import 'package:zinapp_v2/models/post.dart';

/// Abstract interface for all data fetching and manipulation services.
/// This allows swapping between mock and real implementations.
abstract class ApiService {
  /// Fetches the user profile for the given [userId].
  Future<UserProfile> getUserProfile(String userId);

  /// Fetches a list of stylists near the given coordinates.
  Future<List<Stylist>> getNearbyStylists(double lat, double lon);

  /// Submits a new booking request.
  /// Returns true on success, false otherwise.
  Future<bool> submitBooking({
    required String userId,
    required String stylistId,
    required String serviceId,
    required DateTime bookingTime,
  });

  /// Updates the user's XP. Typically called by GamificationService.
  Future<void> updateUserXP(String userId, int xpGained);

  /// Updates the user's Zin Token balance. Typically called by GamificationService.
  Future<void> updateUserTokens(String userId, int tokensGained);

  /// Fetches the social feed posts for the given user.
  Future<List<Post>> getFeedPosts(String userId);

  /// Submits a rating for a completed booking.
  /// Returns true on success, false otherwise.
  Future<bool> submitRating({
    required String bookingId,
    required String userId,
    required String stylistId,
    required int score,
    String? comment,
  });

  // --- Add other necessary methods ---
  // e.g., getServices(), getBookingDetails(bookingId), createPost(), likePost() etc.
}

// Models are now imported from their respective files
