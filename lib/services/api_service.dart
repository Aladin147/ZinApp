// Define models path - adjust if models are structured differently
// It's often good practice to have a barrel file (e.g., models.dart)
// import '../models/models.dart';
// For now, assume models will be imported directly or via a barrel file later.
// Placeholder imports:
import '../models/user_profile.dart'; // Placeholder
import '../models/stylist.dart'; // Placeholder
import '../models/post.dart'; // Placeholder

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

// Define placeholder models for compilation - replace with actual models later
class UserProfile { const UserProfile(); }
class Stylist { const Stylist(); }
class Post { const Post(); }
