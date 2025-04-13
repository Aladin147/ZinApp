import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/models/user.dart'; // Import UserType

void main() {
  group('UserProfile', () {
    // Helper function to create a valid UserProfile instance
    UserProfile createTestUserProfile({
      String id = 'user123',
      String username = 'TestUser',
      String email = 'test@example.com',
      String? profilePictureUrl = 'https://example.com/profile.jpg',
      UserType userType = UserType.regular,
      DateTime? createdAt,
      DateTime? lastLogin,
      int xp = 1200,
      int level = 5,
      int tokens = 50,
      List<String> achievements = const [],
      List<String> badges = const [],
      String rank = 'Bronze',
      String? bio = 'This is a test bio',
      String? location = 'Test Location',
      List<String>? favoriteStyles = const ['style1'],
      List<String>? favoriteStylistIds = const ['stylist1'],
      int postsCount = 10,
      int bookingsCount = 2,
      int followersCount = 15,
      int followingCount = 20,
      Map<String, dynamic>? preferences,
      StylistProfile? stylistProfile,
    }) {
      return UserProfile(
        id: id,
        username: username,
        email: email,
        profilePictureUrl: profilePictureUrl,
        userType: userType,
        createdAt: createdAt ?? DateTime.parse('2023-01-01T00:00:00.000Z'),
        lastLogin: lastLogin ?? DateTime.parse('2023-01-10T00:00:00.000Z'),
        xp: xp,
        level: level,
        tokens: tokens,
        achievements: achievements,
        badges: badges,
        rank: rank,
        bio: bio,
        location: location,
        favoriteStyles: favoriteStyles,
        favoriteStylistIds: favoriteStylistIds,
        postsCount: postsCount,
        bookingsCount: bookingsCount,
        followersCount: followersCount,
        followingCount: followingCount,
        preferences: preferences,
        stylistProfile: stylistProfile,
      );
    }

    test('fromJson creates a UserProfile instance correctly', () {
      // Arrange
      final json = {
        'id': 'user123',
        'username': 'TestUser', // Use username
        'email': 'test@example.com',
        'profilePictureUrl': 'https://example.com/profile.jpg',
        'userType': 'regular', // Use enum value string
        'createdAt': '2023-01-01T00:00:00.000Z',
        'lastLogin': '2023-01-10T00:00:00.000Z',
        'xp': 1200,
        'level': 5,
        'tokens': 50,
        'achievements': <String>[],
        'badges': <String>[],
        'rank': 'Bronze',
        'bio': 'This is a test bio',
        'location': 'Test Location',
        'favoriteStyles': ['style1'],
        'favoriteStylistIds': ['stylist1'],
        'postsCount': 10,
        'bookingsCount': 2,
        'followersCount': 15,
        'followingCount': 20,
        'preferences': null,
        'stylistProfile': null,
      };

      // Act
      final userProfile = UserProfile.fromJson(json);

      // Assert
      expect(userProfile.id, 'user123');
      expect(userProfile.username, 'TestUser'); // Check username
      expect(userProfile.email, 'test@example.com');
      expect(userProfile.profilePictureUrl, 'https://example.com/profile.jpg');
      expect(userProfile.userType, UserType.regular); // Check enum
      expect(userProfile.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(userProfile.lastLogin, DateTime.parse('2023-01-10T00:00:00.000Z'));
      expect(userProfile.xp, 1200);
      expect(userProfile.level, 5);
      expect(userProfile.tokens, 50);
      expect(userProfile.achievements, []);
      expect(userProfile.badges, []);
      expect(userProfile.rank, 'Bronze');
      expect(userProfile.bio, 'This is a test bio');
      expect(userProfile.location, 'Test Location');
      expect(userProfile.favoriteStyles, ['style1']);
      expect(userProfile.favoriteStylistIds, ['stylist1']);
      expect(userProfile.postsCount, 10);
      expect(userProfile.bookingsCount, 2);
      expect(userProfile.followersCount, 15);
      expect(userProfile.followingCount, 20);
      expect(userProfile.preferences, null);
      expect(userProfile.stylistProfile, null);
    });

    test('toJson converts a UserProfile instance to JSON correctly', () {
      // Arrange
      final userProfile = createTestUserProfile(); // Use helper

      // Act
      final json = userProfile.toJson();

      // Assert
      expect(json['id'], 'user123');
      expect(json['username'], 'TestUser');
      expect(json['email'], 'test@example.com');
      expect(json['profilePictureUrl'], 'https://example.com/profile.jpg');
      expect(json['userType'], 'regular'); // Check enum string value
      expect(json['createdAt'], '2023-01-01T00:00:00.000Z');
      expect(json['lastLogin'], '2023-01-10T00:00:00.000Z');
      expect(json['xp'], 1200);
      expect(json['level'], 5);
      expect(json['tokens'], 50);
      expect(json['achievements'], []);
      expect(json['badges'], []);
      expect(json['rank'], 'Bronze');
      expect(json['bio'], 'This is a test bio');
      expect(json['location'], 'Test Location');
      expect(json['favoriteStyles'], ['style1']);
      expect(json['favoriteStylistIds'], ['stylist1']);
      expect(json['postsCount'], 10);
      expect(json['bookingsCount'], 2);
      expect(json['followersCount'], 15);
      expect(json['followingCount'], 20);
      expect(json['preferences'], null);
      expect(json['stylistProfile'], null);
    });

    test('copyWith creates a new instance with updated values', () {
      // Arrange
      final userProfile = createTestUserProfile(); // Use helper

      // Act
      final updatedUserProfile = userProfile.copyWith(
        username: 'UpdatedUser', // Use username
        level: 6,
        xp: 1500,
        tokens: 75,
        rank: 'Silver', // Update rank
        bio: 'Updated bio', // Update bio
      );

      // Assert
      expect(updatedUserProfile.id, 'user123'); // Unchanged
      expect(updatedUserProfile.username, 'UpdatedUser'); // Changed
      expect(updatedUserProfile.email, 'test@example.com'); // Unchanged
      expect(updatedUserProfile.profilePictureUrl, 'https://example.com/profile.jpg'); // Unchanged
      expect(updatedUserProfile.userType, UserType.regular); // Unchanged
      expect(updatedUserProfile.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z')); // Unchanged
      expect(updatedUserProfile.lastLogin, DateTime.parse('2023-01-10T00:00:00.000Z')); // Unchanged
      expect(updatedUserProfile.xp, 1500); // Changed
      expect(updatedUserProfile.level, 6); // Changed
      expect(updatedUserProfile.tokens, 75); // Changed
      expect(updatedUserProfile.achievements, []); // Unchanged
      expect(updatedUserProfile.badges, []); // Unchanged
      expect(updatedUserProfile.rank, 'Silver'); // Changed
      expect(updatedUserProfile.bio, 'Updated bio'); // Changed
      expect(updatedUserProfile.location, 'Test Location'); // Unchanged
      expect(updatedUserProfile.favoriteStyles, ['style1']); // Unchanged
      expect(updatedUserProfile.favoriteStylistIds, ['stylist1']); // Unchanged
      expect(updatedUserProfile.postsCount, 10); // Unchanged
      expect(updatedUserProfile.bookingsCount, 2); // Unchanged
      expect(updatedUserProfile.followersCount, 15); // Unchanged
      expect(updatedUserProfile.followingCount, 20); // Unchanged
      expect(updatedUserProfile.preferences, null); // Unchanged
      expect(updatedUserProfile.stylistProfile, null); // Unchanged
    });

    test('equality works correctly', () {
      // Arrange
      final userProfile1 = createTestUserProfile(); // Use helper
      final userProfile2 = createTestUserProfile(); // Use helper for identical instance

      final userProfile3 = createTestUserProfile( // Use helper for different instance
        id: 'user456',
        username: 'AnotherUser',
        email: 'another@example.com',
        level: 10,
        xp: 2500,
        tokens: 100,
        rank: 'Gold',
        createdAt: DateTime.parse('2023-02-01T00:00:00.000Z'),
      );

      // Assert
      expect(userProfile1, userProfile2); // Same values, should be equal
      expect(userProfile1, isNot(userProfile3)); // Different values, should not be equal
    });
  });
}
