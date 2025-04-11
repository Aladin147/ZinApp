/// Represents a comment on a post in the ZinApp social feed
class Comment {
  /// Unique identifier for the comment
  final String commentId;
  
  /// ID of the user who created the comment
  final String userId;
  
  /// Text content of the comment
  final String text;
  
  /// Timestamp when the comment was created
  final DateTime timestamp;

  const Comment({
    required this.commentId,
    required this.userId,
    required this.text,
    required this.timestamp,
  });

  /// Creates a Comment from JSON data
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'] as String? ?? 'unknown_comment',
      userId: json['userId'] as String? ?? 'unknown_user',
      text: json['text'] as String? ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
    );
  }

  /// Converts the Comment to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'userId': userId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Returns a copy of this Comment with the specified fields replaced
  Comment copyWith({
    String? commentId,
    String? userId,
    String? text,
    DateTime? timestamp,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
