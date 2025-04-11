/// Represents a user profile in the ZinApp application
class UserProfile {
  /// Unique identifier for the user
  final String userId;
  
  /// Display name of the user
  final String username;
  
  /// URL to the user's profile picture
  final String profilePictureUrl;
  
  /// User's experience points
  final int xp;
  
  /// User's Zin token balance
  final int zinTokens;
  
  /// User's current level (Bronze, Silver, Gold, etc.)
  final String level;
  
  /// List of stylist IDs the user is following
  final List<String> followingStylists;
  
  /// List of user IDs the user is following
  final List<String> followingUsers;
  
  /// List of booking IDs in the user's booking history
  final List<String> bookingHistory;

  const UserProfile({
    required this.userId,
    required this.username,
    required this.profilePictureUrl,
    required this.xp,
    required this.zinTokens,
    required this.level,
    this.followingStylists = const [],
    this.followingUsers = const [],
    this.bookingHistory = const [],
  });

  /// Creates a UserProfile from JSON data
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] as String? ?? 'unknown_user',
      username: json['username'] as String? ?? 'Unknown User',
      profilePictureUrl: json['profilePictureUrl'] as String? ?? '',
      xp: json['xp'] as int? ?? 0,
      zinTokens: json['zinTokens'] as int? ?? 0,
      level: json['level'] as String? ?? 'Bronze',
      followingStylists: (json['followingStylists'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      followingUsers: (json['followingUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      bookingHistory: (json['bookingHistory'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
    );
  }

  /// Converts the UserProfile to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'xp': xp,
      'zinTokens': zinTokens,
      'level': level,
      'followingStylists': followingStylists,
      'followingUsers': followingUsers,
      'bookingHistory': bookingHistory,
    };
  }

  /// Returns a copy of this UserProfile with the specified fields replaced
  UserProfile copyWith({
    String? userId,
    String? username,
    String? profilePictureUrl,
    int? xp,
    int? zinTokens,
    String? level,
    List<String>? followingStylists,
    List<String>? followingUsers,
    List<String>? bookingHistory,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      xp: xp ?? this.xp,
      zinTokens: zinTokens ?? this.zinTokens,
      level: level ?? this.level,
      followingStylists: followingStylists ?? this.followingStylists,
      followingUsers: followingUsers ?? this.followingUsers,
      bookingHistory: bookingHistory ?? this.bookingHistory,
    );
  }
}
