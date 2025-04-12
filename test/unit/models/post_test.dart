import 'package:flutter_test/flutter_test.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/user_profile.dart';

void main() {
  group('Post', () {
    final testUser = UserProfile(
      id: 'user123',
      name: 'Test User',
      email: 'test@example.com',
      profilePictureUrl: 'https://example.com/profile.jpg',
      level: 5,
      xp: 1200,
      tokens: 50,
    );

    test('fromJson creates a Post instance correctly', () {
      // Arrange
      final json = {
        'id': 'post123',
        'userId': 'user123',
        'user': {
          'id': 'user123',
          'name': 'Test User',
          'email': 'test@example.com',
          'profilePictureUrl': 'https://example.com/profile.jpg',
          'level': 5,
          'xp': 1200,
          'tokens': 50,
        },
        'content': 'This is a test post',
        'imageUrl': 'https://example.com/post.jpg',
        'likes': 10,
        'comments': 5,
        'isLiked': true,
        'createdAt': '2023-01-01T00:00:00.000Z',
      };

      // Act
      final post = Post.fromJson(json);

      // Assert
      expect(post.id, 'post123');
      expect(post.userId, 'user123');
      expect(post.user, testUser);
      expect(post.content, 'This is a test post');
      expect(post.imageUrl, 'https://example.com/post.jpg');
      expect(post.likes, 10);
      expect(post.comments, 5);
      expect(post.isLiked, true);
      expect(post.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
    });

    test('toJson converts a Post instance to JSON correctly', () {
      // Arrange
      final post = Post(
        id: 'post123',
        userId: 'user123',
        user: testUser,
        content: 'This is a test post',
        imageUrl: 'https://example.com/post.jpg',
        likes: 10,
        comments: 5,
        isLiked: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      // Act
      final json = post.toJson();

      // Assert
      expect(json['id'], 'post123');
      expect(json['userId'], 'user123');
      expect(json['user'], testUser.toJson());
      expect(json['content'], 'This is a test post');
      expect(json['imageUrl'], 'https://example.com/post.jpg');
      expect(json['likes'], 10);
      expect(json['comments'], 5);
      expect(json['isLiked'], true);
      expect(json['createdAt'], '2023-01-01T00:00:00.000Z');
    });

    test('copyWith creates a new instance with updated values', () {
      // Arrange
      final post = Post(
        id: 'post123',
        userId: 'user123',
        user: testUser,
        content: 'This is a test post',
        imageUrl: 'https://example.com/post.jpg',
        likes: 10,
        comments: 5,
        isLiked: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      // Act
      final updatedPost = post.copyWith(
        content: 'Updated content',
        likes: 15,
        comments: 8,
        isLiked: false,
      );

      // Assert
      expect(updatedPost.id, 'post123'); // Unchanged
      expect(updatedPost.userId, 'user123'); // Unchanged
      expect(updatedPost.user, testUser); // Unchanged
      expect(updatedPost.content, 'Updated content'); // Changed
      expect(updatedPost.imageUrl, 'https://example.com/post.jpg'); // Unchanged
      expect(updatedPost.likes, 15); // Changed
      expect(updatedPost.comments, 8); // Changed
      expect(updatedPost.isLiked, false); // Changed
      expect(updatedPost.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z')); // Unchanged
    });

    test('equality works correctly', () {
      // Arrange
      final post1 = Post(
        id: 'post123',
        userId: 'user123',
        user: testUser,
        content: 'This is a test post',
        imageUrl: 'https://example.com/post.jpg',
        likes: 10,
        comments: 5,
        isLiked: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final post2 = Post(
        id: 'post123',
        userId: 'user123',
        user: testUser,
        content: 'This is a test post',
        imageUrl: 'https://example.com/post.jpg',
        likes: 10,
        comments: 5,
        isLiked: true,
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
      );

      final post3 = Post(
        id: 'post456',
        userId: 'user456',
        user: testUser.copyWith(id: 'user456', name: 'Another User'),
        content: 'This is another post',
        imageUrl: 'https://example.com/another.jpg',
        likes: 20,
        comments: 15,
        isLiked: false,
        createdAt: DateTime.parse('2023-02-01T00:00:00.000Z'),
      );

      // Assert
      expect(post1, post2); // Same values, should be equal
      expect(post1, isNot(post3)); // Different values, should not be equal
    });
  });
}
