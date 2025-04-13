import 'package:equatable/equatable.dart';

/// A simplified post model for use in the dashboard
/// This avoids conflicts with the existing Post model
class DashboardPost extends Equatable {
  /// Unique identifier for the post
  final String id;
  
  /// ID of the user who created the post
  final String userId;
  
  /// Name of the author
  final String authorName;
  
  /// URL to the author's profile picture
  final String? authorProfilePictureUrl;
  
  /// Text content of the post
  final String? text;
  
  /// URL to the post's image
  final String? imageUrl;
  
  /// Tags associated with the post
  final List<String> tags;
  
  /// Location where the post was created
  final String? location;
  
  /// Number of likes on the post
  final int likes;
  
  /// Number of comments on the post
  final int comments;
  
  /// Number of shares of the post
  final int shares;
  
  /// When the post was created
  final DateTime timestamp;
  
  /// Whether the current user has liked the post
  final bool isLiked;
  
  /// Type of post (e.g., 'style', 'before_after', 'review')
  final String? type;

  /// Creates a dashboard post
  const DashboardPost({
    required this.id,
    required this.userId,
    required this.authorName,
    this.authorProfilePictureUrl,
    this.text,
    this.imageUrl,
    required this.tags,
    this.location,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.timestamp,
    this.isLiked = false,
    this.type,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        authorName,
        authorProfilePictureUrl,
        text,
        imageUrl,
        tags,
        location,
        likes,
        comments,
        shares,
        timestamp,
        isLiked,
        type,
      ];
}
