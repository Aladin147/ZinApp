import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/models/user.dart'; // Import UserType

void main() {
  group('Post', () {
    // Correctly instantiate UserProfile with all required fields
    final testUser = UserProfile(
      id: 'user123',
      username: 'TestUser', // Use username
      email: 'test@example.com',
      profilePictureUrl: 'https://example.com/profile.jpg',
      level: 5,
      xp: 1200,
      tokens: 50,
      userType: UserType.regular, // Add required field
      createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'), // Add required field
      lastLogin: DateTime.parse('2023-01-10T00:00:00.000Z'), // Add required field
      achievements: [], // Add required field
      badges: [], // Add required field
      rank: 'Bronze', // Add required field
      postsCount: 10, // Add required field
      bookingsCount: 2, // Add required field
      followersCount: 15, // Add required field
      followingCount: 20, // Add required field
    );

    test('fromJson creates a Post instance correctly', () {
      // Arrange
      final json = {
        'id': 'post123',
        'userId': 'user123',
        'authorName': 'TestUser', // Use authorName
        'authorProfilePictureUrl': 'https://example.com/profile.jpg', // Add author profile pic
        'text': 'This is a test post', // Use text instead of content
        'imageUrl': 'https://example.com/post.jpg',
        'tags': ['test', 'flutter'], // Add required field
        'likes': 10,
        'comments': 5,
        'shares': 2, // Add required field
        'isLiked': true,
        'timestamp': '2023-01-01T00:00:00.000Z', // Use timestamp instead of createdAt
      };

      // Act
      final post = Post.fromJson(json);

      // Assert
      expect(post.id, 'post123');
      expect(post.userId, 'user123');
      expect(post.authorName, 'TestUser'); // Assert authorName
      expect(post.authorProfilePictureUrl, 'https://example.com/profile.jpg'); // Assert author profile pic
      expect(post.text, 'This is a test post'); // Assert text
      expect(post.imageUrl, 'https://example.com/post.jpg');
      expect(post.tags, ['test', 'flutter']); // Assert tags
      expect(post.likes, 10);
      expect(post.comments, 5);
      expect(post.shares, 2); // Assert shares
      expect(post.isLiked, true);
      expect(post.timestamp, DateTime.parse('2023-01-01T00:00:00.000Z')); // Assert timestamp
    });

    test('toJson converts a Post instance to JSON correctly', () {
      // Arrange
      final post = Post(
        id: 'post123',
        userId: 'user123',
        authorName: 'TestUser', // Use authorName
        authorProfilePictureUrl: 'https://example.com/profile.jpg', // Add author profile pic
        text: 'This is a test post', // Use text
        imageUrl: 'https://example.com/post.jpg',
        tags: ['test', 'flutter'], // Add required field
        likes: 10,
        comments: 5,
        shares: 2, // Add required field
        isLiked: true,
        timestamp: DateTime.parse('2023-01-01T00:00:00.000Z'), // Use timestamp
      );

      // Act
      final json = post.toJson();

      // Assert
      expect(json['id'], 'post123');
      expect(json['userId'], 'user123');
      expect(json['authorName'], 'TestUser'); // Assert authorName
      expect(json['authorProfilePictureUrl'], 'https://example.com/profile.jpg'); // Assert author profile pic
      expect(json['text'], 'This is a test post'); // Assert text
      expect(json['imageUrl'], 'https://example.com/post.jpg');
      expect(json['tags'], ['test', 'flutter']); // Assert tags
      expect(json['likes'], 10);
      expect(json['comments'], 5);
      expect(json['shares'], 2); // Assert shares
      expect(json['isLiked'], true);
      expect(json['timestamp'], '2023-01-01T00:00:00.000Z'); // Assert timestamp
    });

    test('copyWith creates a new instance with updated values', () {
      // Arrange
      final post = Post(
        id: 'post123',
        userId: 'user123',
        authorName: 'TestUser',
        authorProfilePictureUrl: 'https://example.com/profile.jpg',
        text: 'This is a test post',
        imageUrl: 'https://example.com/post.jpg',
        tags: ['test', 'flutter'],
        likes: 10,
        comments: 5,
        shares: 2,
        isLiked: true,
        timestamp: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      // Act
      final updatedPost = post.copyWith(
        text: 'Updated content', // Use text
        likes: 15,
        comments: 8,
        shares: 3, // Update shares
        isLiked: false,
        tags: ['updated'], // Update tags
      );

      // Assert
      expect(updatedPost.id, 'post123'); // Unchanged
      expect(updatedPost.userId, 'user123'); // Unchanged
      expect(updatedPost.authorName, 'TestUser'); // Unchanged
      expect(updatedPost.authorProfilePictureUrl, 'https://example.com/profile.jpg'); // Unchanged
      expect(updatedPost.text, 'Updated content'); // Changed
      expect(updatedPost.imageUrl, 'https://example.com/post.jpg'); // Unchanged
      expect(updatedPost.tags, ['updated']); // Changed
      expect(updatedPost.likes, 15); // Changed
      expect(updatedPost.comments, 8); // Changed
      expect(updatedPost.shares, 3); // Changed
      expect(updatedPost.isLiked, false); // Changed
      expect(updatedPost.timestamp, DateTime.parse('2023-01-01T00:00:00.000Z')); // Unchanged
    });

    test('equality works correctly', () {
      // Arrange
      final post1 = Post(
        id: 'post123',
        userId: 'user123',
        authorName: 'TestUser',
        authorProfilePictureUrl: 'https://example.com/profile.jpg',
        text: 'This is a test post',
        imageUrl: 'https://example.com/post.jpg',
        tags: ['test', 'flutter'],
        likes: 10,
        comments: 5,
        shares: 2,
        isLiked: true,
        timestamp: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final post2 = Post(
        id: 'post123',
        userId: 'user123',
        authorName: 'TestUser',
        authorProfilePictureUrl: 'https://example.com/profile.jpg',
        text: 'This is a test post',
        imageUrl: 'https://example.com/post.jpg',
        tags: ['test', 'flutter'],
        likes: 10,
        comments: 5,
        shares: 2,
        isLiked: true,
        timestamp: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final post3 = Post(
        id: 'post456',
        userId: 'user456',
        authorName: 'AnotherUser', // Different author
        authorProfilePictureUrl: 'https://example.com/another.jpg',
        text: 'This is another post',
        imageUrl: 'https://example.com/another.jpg',
        tags: ['another'], // Different tags
        likes: 20,
        comments: 15,
        shares: 5, // Different shares
        isLiked: false,
        timestamp: DateTime.parse('2023-02-01T00:00:00.000Z'), // Different timestamp
      );

      // Assert
      expect(post1, post2); // Same values, should be equal
      expect(post1, isNot(post3)); // Different values, should not be equal
    });
  });
}
