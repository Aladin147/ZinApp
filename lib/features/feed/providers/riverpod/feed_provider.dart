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

  /// Like a post (legacy method, use toggleLike instead)
  Future<bool> likePost(String postId) async {
    try {
      // Find the post
      final postIndex = state.posts.indexWhere((post) => post.id == postId);
      if (postIndex == -1) return false; // Post not found

      final post = state.posts[postIndex];

      // Only like if not already liked
      if (!post.isLiked) {
        await toggleLike(postId);
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

  /// Toggle like status for a post
  Future<void> toggleLike(String postId) async {
    try {
      // Find the post in the current state
      final postIndex = state.posts.indexWhere((post) => post.id == postId);
      if (postIndex == -1) {
        state = state.copyWith(error: 'Post not found');
        return; // Post not found
      }

      final post = state.posts[postIndex];
      final isCurrentlyLiked = post.isLiked;

      // Create a new list with the updated post
      final updatedPosts = List<Post>.from(state.posts);
      updatedPosts[postIndex] = post.copyWith(
        isLiked: !isCurrentlyLiked,
        likesCount: isCurrentlyLiked ? post.likesCount - 1 : post.likesCount + 1,
      );

      // Update state optimistically
      state = state.copyWith(posts: updatedPosts, error: null);

      try {
        // Call the API to update the like status
        await ref.read(feedServiceProvider).toggleLike(postId, !isCurrentlyLiked);
      } catch (apiError) {
        // If the API call fails, revert the optimistic update but keep the UI responsive
        final revertedPosts = List<Post>.from(state.posts);
        revertedPosts[postIndex] = post; // Revert to original post
        state = state.copyWith(
          posts: revertedPosts,
          error: 'Failed to update like status: ${apiError.toString()}',
        );
      }
    } catch (e) {
      // Handle any other errors
      state = state.copyWith(error: 'Error processing like action: ${e.toString()}');
    }
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
