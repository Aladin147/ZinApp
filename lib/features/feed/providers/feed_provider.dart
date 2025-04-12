import 'package:flutter/foundation.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/feed_service.dart';

/// Provider for managing feed data
class FeedProvider extends ChangeNotifier {
  final FeedService _feedService = FeedService();

  List<Post> _posts = [];
  Map<String, UserProfile> _postUsers = {};

  bool _isLoading = false;
  String? _error;

  /// All posts in the feed
  List<Post> get posts => _posts;

  /// User profiles for posts
  Map<String, UserProfile> get postUsers => _postUsers;

  /// Whether feed operations are in progress
  bool get isLoading => _isLoading;

  /// Current error message
  String? get error => _error;

  /// Load all posts
  Future<void> loadPosts() async {
    _setLoading(true);

    try {
      _posts = await _feedService.getAllPosts();

      // Sort by creation date (newest first)
      _posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Load user profiles for posts
      await _loadUsersForPosts();

      _setError(null);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Load posts by user ID
  Future<void> loadPostsByUserId(String userId) async {
    _setLoading(true);

    try {
      _posts = await _feedService.getPostsByUserId(userId);

      // Sort by creation date (newest first)
      _posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Load user profiles for posts
      await _loadUsersForPosts();

      _setError(null);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Create a new post
  Future<bool> createPost({
    required String userId,
    required String content,
    required List<String> imageUrls,
    required List<String> tags,
    String? location,
  }) async {
    _setLoading(true);

    try {
      final post = await _feedService.createPost(
        userId: userId,
        content: content,
        imageUrls: imageUrls,
        tags: tags,
        location: location,
      );

      // Add to posts list
      _posts.insert(0, post);

      _setError(null);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Like a post
  Future<bool> likePost(String postId) async {
    try {
      final updatedPost = await _feedService.likePost(postId);

      // Update post in list
      final index = _posts.indexWhere((post) => post.id == postId);
      if (index != -1) {
        _posts[index] = updatedPost;
        notifyListeners();
      }

      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  /// Get user profile for a post
  UserProfile? getUserForPost(String userId) {
    return _postUsers[userId];
  }

  /// Load user profiles for all posts
  Future<void> _loadUsersForPosts() async {
    final userIds = _posts.map((post) => post.userId).toSet().toList();

    for (final userId in userIds) {
      if (!_postUsers.containsKey(userId)) {
        try {
          final user = await _feedService.getUserForPost(userId);
          _postUsers[userId] = user;
        } catch (e) {
          // Skip this user
        }
      }
    }
  }

  /// Clear the current error message
  void clearError() {
    _setError(null);
  }

  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message
  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
}
