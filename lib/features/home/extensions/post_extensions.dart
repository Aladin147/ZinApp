import 'package:zinapp_v2/features/home/models/dashboard_post.dart';
import 'package:zinapp_v2/models/post.dart';

/// Extension methods for Post model
extension PostExtensions on Post {
  /// Converts a Post to a DashboardPost
  DashboardPost toDashboardPost() {
    return DashboardPost(
      id: id,
      userId: userId,
      authorName: authorName,
      authorProfilePictureUrl: authorProfilePictureUrl,
      text: text,
      imageUrl: imageUrl,
      tags: tags,
      location: location,
      likes: likes,
      comments: comments,
      shares: shares,
      timestamp: timestamp,
      isLiked: isLiked,
      type: type,
    );
  }
}

/// Extension methods for DashboardPost model
extension DashboardPostExtensions on DashboardPost {
  /// Converts a DashboardPost to a Post
  Post toPost() {
    return Post(
      id: id,
      userId: userId,
      authorName: authorName,
      authorProfilePictureUrl: authorProfilePictureUrl,
      text: text,
      imageUrl: imageUrl,
      tags: tags,
      location: location,
      likes: likes,
      comments: comments,
      shares: shares,
      timestamp: timestamp,
      isLiked: isLiked,
      type: type,
    );
  }
}
