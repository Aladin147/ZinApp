import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/models/user_profile.dart';

void main() {
  group('UserProfile', () {
    test('fromJson creates a UserProfile instance correctly', () {
      // Arrange
      final json = {
        'id': 'user123',
        'name': 'Test User',
        'email': 'test@example.com',
        'profilePictureUrl': 'https://example.com/profile.jpg',
        'bio': 'This is a test bio',
        'level': 5,
        'xp': 1200,
        'tokens': 50,
        'isVerified': true,
        'createdAt': '2023-01-01T00:00:00.000Z',
      };

      // Act
      final userProfile = UserProfile.fromJson(json);

      // Assert
      expect(userProfile.id, 'user123');
      expect(userProfile.name, 'Test User');
      expect(userProfile.email, 'test@example.com');
      expect(userProfile.profilePictureUrl, 'https://example.com/profile.jpg');
      expect(userProfile.bio, 'This is a test bio');
      expect(userProfile.level, 5);
      expect(userProfile.xp, 1200);
      expect(userProfile.tokens, 50);
      expect(userProfile.isVerified, true);
      expect(userProfile.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
    });

    test('toJson converts a UserProfile instance to JSON correctly', () {
      // Arrange
      final userProfile = UserProfile(
        id: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        profilePictureUrl: 'https://example.com/profile.jpg',
        bio: 'This is a test bio',
        level: 5,
        xp: 1200,
        tokens: 50,
        isVerified: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      // Act
      final json = userProfile.toJson();

      // Assert
      expect(json['id'], 'user123');
      expect(json['name'], 'Test User');
      expect(json['email'], 'test@example.com');
      expect(json['profilePictureUrl'], 'https://example.com/profile.jpg');
      expect(json['bio'], 'This is a test bio');
      expect(json['level'], 5);
      expect(json['xp'], 1200);
      expect(json['tokens'], 50);
      expect(json['isVerified'], true);
      expect(json['createdAt'], '2023-01-01T00:00:00.000Z');
    });

    test('copyWith creates a new instance with updated values', () {
      // Arrange
      final userProfile = UserProfile(
        id: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        profilePictureUrl: 'https://example.com/profile.jpg',
        bio: 'This is a test bio',
        level: 5,
        xp: 1200,
        tokens: 50,
        isVerified: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      // Act
      final updatedUserProfile = userProfile.copyWith(
        name: 'Updated User',
        level: 6,
        xp: 1500,
        tokens: 75,
      );

      // Assert
      expect(updatedUserProfile.id, 'user123'); // Unchanged
      expect(updatedUserProfile.name, 'Updated User'); // Changed
      expect(updatedUserProfile.email, 'test@example.com'); // Unchanged
      expect(updatedUserProfile.profilePictureUrl, 'https://example.com/profile.jpg'); // Unchanged
      expect(updatedUserProfile.bio, 'This is a test bio'); // Unchanged
      expect(updatedUserProfile.level, 6); // Changed
      expect(updatedUserProfile.xp, 1500); // Changed
      expect(updatedUserProfile.tokens, 75); // Changed
      expect(updatedUserProfile.isVerified, true); // Unchanged
      expect(updatedUserProfile.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z')); // Unchanged
    });

    test('equality works correctly', () {
      // Arrange
      final userProfile1 = UserProfile(
        id: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        profilePictureUrl: 'https://example.com/profile.jpg',
        bio: 'This is a test bio',
        level: 5,
        xp: 1200,
        tokens: 50,
        isVerified: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final userProfile2 = UserProfile(
        id: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        profilePictureUrl: 'https://example.com/profile.jpg',
        bio: 'This is a test bio',
        level: 5,
        xp: 1200,
        tokens: 50,
        isVerified: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final userProfile3 = UserProfile(
        id: 'user456',
        name: 'Another User',
        email: 'another@example.com',
        profilePictureUrl: 'https://example.com/another.jpg',
        bio: 'This is another bio',
        level: 10,
        xp: 2500,
        tokens: 100,
        isVerified: false,
        createdAt: DateTime.parse('2023-02-01T00:00:00.000Z'),
      );

      // Assert
      expect(userProfile1, userProfile2); // Same values, should be equal
      expect(userProfile1, isNot(userProfile3)); // Different values, should not be equal
    });
  });
}
