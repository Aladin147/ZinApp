import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zinapp_v2/models/post.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/services/feed_service.dart';

// Generate the provider code
part 'feed_provider.g.dart';

/// Provider for the FeedService
@riverpod
FeedService feedService(FeedServiceRef ref) {
  return FeedService();
}

/// Provider for feed state
@riverpod
class Feed extends _$Feed {
  @override
  FeedState build() {
    return FeedState.initial();
  }

  /// Load all posts
  Future<void> loadPosts() async {
    state = state.copyWith(isLoading: true);

    try {
      final posts = await ref.read(feedServiceProvider).getAllPosts();

      // Sort by creation date (newest first)
      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Load user profiles for posts
      final postUsers = await _loadUsersForPosts(posts);

      state = state.copyWith(
        posts: posts,
        postUsers: postUsers,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load posts by user ID
  Future<void> loadPostsByUserId(String userId) async {
    state = state.copyWith(isLoading: true);

    try {
      final posts = await ref.read(feedServiceProvider).getPostsByUserId(userId);

      // Sort by creation date (newest first)
      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Load user profiles for posts
      final postUsers = await _loadUsersForPosts(posts);

      state = state.copyWith(
        posts: posts,
        postUsers: postUsers,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
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
    state = state.copyWith(isLoading: true);

    try {
      final post = await ref.read(feedServiceProvider).createPost(
            userId: userId,
            content: content,
            imageUrls: imageUrls,
            tags: tags,
            location: location,
          );

      // Add to posts list
      final updatedPosts = [post, ...state.posts];

      // Update user profiles if needed
      final updatedPostUsers = Map<String, UserProfile>.from(state.postUsers);
      if (!updatedPostUsers.containsKey(userId)) {
        try {
          final user = await ref.read(feedServiceProvider).getUserForPost(userId);
          updatedPostUsers[userId] = user;
        } catch (_) {
          // Skip if user can't be loaded
        }
      }

      state = state.copyWith(
        posts: updatedPosts,
        postUsers: updatedPostUsers,
        isLoading: false,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Like a post
  Future<bool> likePost(String postId) async {
    try {
      final updatedPost = await ref.read(feedServiceProvider).likePost(postId);

      // Update post in list
      final updatedPosts = [...state.posts];
      final index = updatedPosts.indexWhere((post) => post.id == postId);
      if (index != -1) {
        updatedPosts[index] = updatedPost;
        state = state.copyWith(posts: updatedPosts);
      }

      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Get user profile for a post
  UserProfile? getUserForPost(String userId) {
    return state.postUsers[userId];
  }

  /// Load user profiles for all posts
  Future<Map<String, UserProfile>> _loadUsersForPosts(List<Post> posts) async {
    final userIds = posts.map((post) => post.userId).toSet().toList();
    final postUsers = Map<String, UserProfile>.from(state.postUsers);

    for (final userId in userIds) {
      if (!postUsers.containsKey(userId)) {
        try {
          final user = await ref.read(feedServiceProvider).getUserForPost(userId);
          postUsers[userId] = user;
        } catch (_) {
          // Skip this user
        }
      }
    }

    return postUsers;
  }

  /// Clear the current error message
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// State class for feed operations
class FeedState {
  final List<Post> posts;
  final Map<String, UserProfile> postUsers;
  final bool isLoading;
  final String? error;

  const FeedState({
    required this.posts,
    required this.postUsers,
    required this.isLoading,
    this.error,
  });

  /// Initial state
  factory FeedState.initial() {
    return const FeedState(
      posts: [],
      postUsers: {},
      isLoading: false,
    );
  }

  /// Creates a copy of this state with the given fields replaced with new values
  FeedState copyWith({
    List<Post>? posts,
    Map<String, UserProfile>? postUsers,
    bool? isLoading,
    String? error,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      postUsers: postUsers ?? this.postUsers,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
