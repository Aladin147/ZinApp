import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zinapp_v2/models/comment.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/api_config.dart';
import 'package:zinapp_v2/services/mock_data.dart';

/// Exception thrown when feed operations fail
class FeedException implements Exception {
  final String message;
  FeedException(this.message);

  @override
  String toString() => 'FeedException: $message';
}

/// Service responsible for feed operations
class FeedService {
  final String baseUrl = ApiConfig.baseUrl;

  /// Get all posts
  Future<List<Post>> getAllPosts() async {
    try {
      if (ApiConfig.useMockData) {
        // Use mock data
        return MockData.posts.map((data) => Post.fromJson(data)).toList();
      } else {
        final response = await http.get(
          Uri.parse('$baseUrl/posts'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> postsData = jsonDecode(response.body);
          return postsData.map((data) => Post.fromJson(data)).toList();
        } else {
          throw FeedException('Failed to get posts: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting posts: $e');
    }
  }

  /// Get posts by user ID
  Future<List<Post>> getPostsByUserId(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts?userId=$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> postsData = jsonDecode(response.body);
        return postsData.map((data) => Post.fromJson(data)).toList();
      } else {
        throw FeedException(
            'Failed to get posts by user: ${response.statusCode}',);
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting posts by user: $e');
    }
  }

  /// Get post by ID
  Future<Post> getPostById(String id) async {
    try {
      if (ApiConfig.useMockData) {
        // Find post in mock data
        final postMatch = MockData.posts.where((p) => p['id'] == id).toList();
        if (postMatch.isEmpty) {
          throw FeedException('Post not found in mock data: $id');
        }
        return Post.fromJson(postMatch.first);
      } else {
        final response = await http.get(
          Uri.parse('$baseUrl/posts/$id'),
        );

        if (response.statusCode == 200) {
          final postData = jsonDecode(response.body);
          return Post.fromJson(postData);
        } else {
          throw FeedException('Failed to get post: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting post: $e');
    }
  }

  /// Create a new post
  Future<Post> createPost({
    required String userId,
    required String content,
    required List<String> imageUrls,
    required List<String> tags,
    String? location,
  }) async {
    try {
      final postData = {
        'id': 'post${DateTime.now().millisecondsSinceEpoch}',
        'userId': userId,
        'authorName': 'User', // Default author name
        'authorProfilePictureUrl': 'assets/images/avatars/default.png',
        'text': content,
        'imageUrl': imageUrls.isNotEmpty ? imageUrls.first : null,
        'tags': tags,
        'location': location,
        'likes': 0,
        'comments': 0,
        'shares': 0,
        'timestamp': DateTime.now().toIso8601String(),
        'isLiked': false,
        'type': 'general',
      };

      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 201) {
        final createdPostData = jsonDecode(response.body);
        return Post.fromJson(createdPostData);
      } else {
        throw FeedException('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error creating post: $e');
    }
  }

  /// Toggle like status for a post
  Future<Post> toggleLike(String postId, bool isLiked) async {
    try {
      if (ApiConfig.useMockData) {
        try {
          // Get current post
          final post = await getPostById(postId);

          // Update likes count based on the action
          final updatedLikesCount = isLiked ? post.likes + 1 : post.likes - 1;

          // Create updated post
          final updatedPost = post.copyWith(
            likes: updatedLikesCount >= 0 ? updatedLikesCount : 0,
            isLiked: isLiked,
          );

          // Simulate API delay
          await Future.delayed(const Duration(milliseconds: 300));

          // Update the mock data
          final postIndex = MockData.posts.indexWhere((p) => p['id'] == postId);
          if (postIndex != -1) {
            MockData.posts[postIndex]['likes'] = updatedPost.likes;
            MockData.posts[postIndex]['isLiked'] = updatedPost.isLiked;
          }

          return updatedPost;
        } catch (e) {
          throw FeedException('Error toggling like in mock data: $e');
        }
      } else {
        // Get current post
        final post = await getPostById(postId);

        // Update likes count based on the action
        final updatedLikesCount = isLiked ? post.likes + 1 : post.likes - 1;

        // Prepare data for API
        final updatedPostData = {
          'likesCount': updatedLikesCount >= 0 ? updatedLikesCount : 0,
          'isLiked': isLiked,
        };

        final response = await http.patch(
          Uri.parse('$baseUrl/posts/$postId'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(updatedPostData),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          return Post.fromJson(responseData);
        } else {
          throw FeedException('Failed to update like status: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error toggling like: $e');
    }
  }

  /// Get user profile for a post
  Future<UserProfile> getUserForPost(String userId) async {
    try {
      if (ApiConfig.useMockData) {
        // Check users collection
        final userMatch = MockData.users.where((u) => u['id'] == userId).toList();
        if (userMatch.isNotEmpty) {
          return UserProfile.fromJson(userMatch.first);
        }

        // Check stylists collection
        final stylistMatch = MockData.stylists.where((s) => s['id'] == userId).toList();
        if (stylistMatch.isNotEmpty) {
          return UserProfile.fromJson(stylistMatch.first);
        }

        throw FeedException('User not found for post');
      } else {
        final response = await http.get(
          Uri.parse('$baseUrl/users/$userId'),
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body);
          return UserProfile.fromJson(userData);
        } else {
          // Try stylists collection
          final stylistResponse = await http.get(
            Uri.parse('$baseUrl/stylists/$userId'),
          );

          if (stylistResponse.statusCode == 200) {
            final stylistData = jsonDecode(stylistResponse.body);
            return UserProfile.fromJson(stylistData);
          } else {
            throw FeedException(
                'Failed to get user for post: ${response.statusCode}',);
          }
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting user for post: $e');
    }
  }

  /// Get comments for a post
  Future<List<Comment>> getCommentsForPost(String postId) async {
    try {
      if (ApiConfig.useMockData) {
        // Use mock data
        final comments = MockData.comments
            .where((comment) => comment['postId'] == postId)
            .map((data) => Comment(
                  commentId: data['id'],
                  userId: data['userId'],
                  text: data['content'],
                  timestamp: DateTime.parse(data['createdAt']),
                ),)
            .toList();

        // Sort by timestamp (newest first)
        comments.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        return comments;
      } else {
        final response = await http.get(
          Uri.parse('$baseUrl/comments?postId=$postId'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> commentsData = jsonDecode(response.body);
          final comments = commentsData
              .map((data) => Comment(
                    commentId: data['id'],
                    userId: data['userId'],
                    text: data['content'],
                    timestamp: DateTime.parse(data['createdAt']),
                  ),)
              .toList();

          // Sort by timestamp (newest first)
          comments.sort((a, b) => b.timestamp.compareTo(a.timestamp));

          return comments;
        } else {
          throw FeedException(
              'Failed to get comments: ${response.statusCode}',);
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error getting comments: $e');
    }
  }

  /// Add a comment to a post
  Future<Comment> addComment({
    required String postId,
    required String userId,
    required String text,
  }) async {
    try {
      final commentData = {
        'id': 'comment${DateTime.now().millisecondsSinceEpoch}',
        'postId': postId,
        'userId': userId,
        'content': text,
        'likesCount': 0,
        'createdAt': DateTime.now().toIso8601String(),
      };

      if (ApiConfig.useMockData) {
        // Add to mock data
        MockData.comments.add(commentData);

        // Update post comment count
        final postIndex = MockData.posts.indexWhere((p) => p['id'] == postId);
        if (postIndex != -1) {
          MockData.posts[postIndex]['comments'] =
              (MockData.posts[postIndex]['comments'] as int) + 1;
        }

        // Simulate API delay
        await Future.delayed(const Duration(milliseconds: 300));

        return Comment(
          commentId: commentData['id'] as String,
          userId: commentData['userId'] as String,
          text: commentData['content'] as String,
          timestamp: DateTime.parse(commentData['createdAt'] as String),
        );
      } else {
        final response = await http.post(
          Uri.parse('$baseUrl/comments'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(commentData),
        );

        if (response.statusCode == 201) {
          final createdCommentData = jsonDecode(response.body);

          // Update post comment count
          await http.patch(
            Uri.parse('$baseUrl/posts/$postId'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'comments': await _getUpdatedCommentCount(postId),
            }),
          );

          return Comment(
            commentId: createdCommentData['id'],
            userId: createdCommentData['userId'],
            text: createdCommentData['content'],
            timestamp: DateTime.parse(createdCommentData['createdAt']),
          );
        } else {
          throw FeedException('Failed to add comment: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error adding comment: $e');
    }
  }

  /// Delete a comment
  Future<bool> deleteComment(String commentId, String postId) async {
    try {
      if (ApiConfig.useMockData) {
        // Remove from mock data
        final commentIndex = MockData.comments.indexWhere((c) => c['id'] == commentId);
        if (commentIndex != -1) {
          MockData.comments.removeAt(commentIndex);

          // Update post comment count
          final postIndex = MockData.posts.indexWhere((p) => p['id'] == postId);
          if (postIndex != -1) {
            final currentCount = MockData.posts[postIndex]['commentsCount'] as int;
            MockData.posts[postIndex]['commentsCount'] = currentCount > 0 ? currentCount - 1 : 0;
          }

          // Simulate API delay
          await Future.delayed(const Duration(milliseconds: 300));

          return true;
        }
        return false;
      } else {
        final response = await http.delete(
          Uri.parse('$baseUrl/comments/$commentId'),
        );

        if (response.statusCode == 200) {
          // Update post comment count
          await http.patch(
            Uri.parse('$baseUrl/posts/$postId'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'commentsCount': await _getUpdatedCommentCount(postId),
            }),
          );

          return true;
        } else {
          throw FeedException('Failed to delete comment: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (e is FeedException) rethrow;
      throw FeedException('Error deleting comment: $e');
    }
  }

  /// Get updated comment count for a post
  Future<int> _getUpdatedCommentCount(String postId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/comments?postId=$postId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> comments = jsonDecode(response.body);
        return comments.length;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
