import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zinapp_v2/app/models/token_transaction.dart';
import 'package:zinapp_v2/app/models/user.dart';
import 'package:zinapp_v2/app/models/user_profile.dart';
import 'package:zinapp_v2/app/services/api_config.dart';

/// Exception thrown when user profile operations fail
class UserProfileException implements Exception {
  final String message;
  UserProfileException(this.message);

  @override
  String toString() => 'UserProfileException: $message';
}

/// Service responsible for user profile operations
class UserProfileService {
  final String baseUrl = ApiConfig.baseUrl;

  /// Get user profile by ID
  Future<UserProfile> getUserProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId'),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return UserProfile.fromJson(userData);
      } else {
        throw UserProfileException(
            'Failed to get user profile: ${response.statusCode}');
      }
    } catch (e) {
      if (e is UserProfileException) rethrow;
      throw UserProfileException('Error getting user profile: $e');
    }
  }

  /// Update user profile
  Future<UserProfile> updateUserProfile(
      String userId, Map<String, dynamic> updates) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return UserProfile.fromJson(userData);
      } else {
        throw UserProfileException(
            'Failed to update user profile: ${response.statusCode}');
      }
    } catch (e) {
      if (e is UserProfileException) rethrow;
      throw UserProfileException('Error updating user profile: $e');
    }
  }

  /// Add XP to user
  Future<UserProfile> addXp(String userId, int amount, String reason) async {
    try {
      // Get current user profile
      final userProfile = await getUserProfile(userId);

      // Calculate new XP and level
      final newXp = userProfile.xp + amount;
      final newLevel = _calculateLevel(newXp);
      final levelUp = newLevel > userProfile.level;

      // Update user profile
      final Map<String, dynamic> updates = {
        'xp': newXp,
        'level': newLevel,
      };

      // If level up, update rank
      if (levelUp) {
        final newRank = _getRankForLevel(newLevel, userProfile.userType);
        updates['rank'] = newRank;
      }

      return await updateUserProfile(userId, updates);
    } catch (e) {
      if (e is UserProfileException) rethrow;
      throw UserProfileException('Error adding XP: $e');
    }
  }

  /// Add or remove tokens
  Future<UserProfile> updateTokens(
    String userId,
    int amount,
    TokenTransactionType type,
    String description, {
    String? relatedEntityId,
  }) async {
    try {
      // Get current user profile
      final userProfile = await getUserProfile(userId);

      // Calculate new token balance
      final newTokens = userProfile.tokens + amount;

      // Create token transaction
      final transaction = {
        'id': 'transaction${DateTime.now().millisecondsSinceEpoch}',
        'userId': userId,
        'amount': amount,
        'type': type.toString().split('.').last,
        'description': description,
        'timestamp': DateTime.now().toIso8601String(),
        'relatedEntityId': relatedEntityId,
      };

      // Add transaction to database
      await http.post(
        Uri.parse('$baseUrl/tokenTransactions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transaction),
      );

      // Update user profile
      return await updateUserProfile(userId, {'tokens': newTokens});
    } catch (e) {
      if (e is UserProfileException) rethrow;
      throw UserProfileException('Error updating tokens: $e');
    }
  }

  /// Unlock achievement
  Future<UserProfile> unlockAchievement(String userId, String achievementId) async {
    try {
      // Get current user profile
      final userProfile = await getUserProfile(userId);

      // Check if achievement already unlocked
      if (userProfile.achievements.contains(achievementId)) {
        return userProfile;
      }

      // Get achievement details
      final achievementResponse = await http.get(
        Uri.parse('$baseUrl/achievements/$achievementId'),
      );

      if (achievementResponse.statusCode != 200) {
        throw UserProfileException('Achievement not found');
      }

      final achievementData = jsonDecode(achievementResponse.body);
      final xpReward = achievementData['xpReward'] as int;
      final tokenReward = achievementData['tokenReward'] as int;

      // Add achievement to user's list
      final newAchievements = List<String>.from(userProfile.achievements)
        ..add(achievementId);

      // Update user profile
      final updatedUser = await updateUserProfile(
          userId, {'achievements': newAchievements});

      // Add XP and tokens
      if (xpReward > 0) {
        await addXp(userId, xpReward, 'Achievement: ${achievementData['title']}');
      }

      if (tokenReward > 0) {
        await updateTokens(
          userId,
          tokenReward,
          TokenTransactionType.earned,
          'Achievement: ${achievementData['title']}',
          relatedEntityId: achievementId,
        );
      }

      return updatedUser;
    } catch (e) {
      if (e is UserProfileException) rethrow;
      throw UserProfileException('Error unlocking achievement: $e');
    }
  }

  /// Get token transaction history
  Future<List<TokenTransaction>> getTokenHistory(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tokenTransactions?userId=$userId'),
      );

      if (response.statusCode == 200) {
        final transactionsData = jsonDecode(response.body) as List;
        return transactionsData
            .map((data) => TokenTransaction.fromJson(data))
            .toList();
      } else {
        throw UserProfileException(
            'Failed to get token history: ${response.statusCode}');
      }
    } catch (e) {
      if (e is UserProfileException) rethrow;
      throw UserProfileException('Error getting token history: $e');
    }
  }

  /// Calculate level based on XP
  int _calculateLevel(int xp) {
    if (xp < 100) return 1;
    if (xp < 250) return 2;
    if (xp < 500) return 3;
    if (xp < 1000) return 4;
    if (xp < 2000) return 5;
    if (xp < 3500) return 6;
    if (xp < 5000) return 7;
    if (xp < 7500) return 8;
    if (xp < 10000) return 9;
    if (xp < 15000) return 10;
    if (xp < 20000) return 11;
    if (xp < 25000) return 12;
    if (xp < 30000) return 13;
    if (xp < 40000) return 14;
    if (xp < 50000) return 15;
    if (xp < 75000) return 16;
    if (xp < 100000) return 17;
    if (xp < 150000) return 18;
    if (xp < 200000) return 19;
    if (xp < 250000) return 20;
    if (xp < 300000) return 21;
    if (xp < 400000) return 22;
    if (xp < 500000) return 23;
    if (xp < 600000) return 24;
    if (xp < 750000) return 25;
    if (xp < 900000) return 26;
    if (xp < 1000000) return 27;
    if (xp < 1250000) return 28;
    if (xp < 1500000) return 29;
    return 30;
  }

  /// Get rank title based on level and user type
  String _getRankForLevel(int level, UserType userType) {
    if (userType == UserType.stylist) {
      if (level < 5) return 'Apprentice Stylist';
      if (level < 10) return 'Established Stylist';
      if (level < 15) return 'Expert Stylist';
      if (level < 20) return 'Master Stylist';
      if (level < 25) return 'Elite Stylist';
      if (level < 30) return 'Celebrity Stylist';
      return 'Legendary Stylist';
    } else {
      if (level < 5) return 'Style Novice';
      if (level < 10) return 'Style Enthusiast';
      if (level < 15) return 'Style Explorer';
      if (level < 20) return 'Style Connoisseur';
      if (level < 25) return 'Style Maven';
      if (level < 30) return 'Style Guru';
      return 'Style Legend';
    }
  }
}
