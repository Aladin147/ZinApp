/// Represents a user's authentication state in the ZinApp application
class AuthUser {
  /// Unique identifier for the user
  final String uid;
  
  /// User's email address
  final String email;
  
  /// Whether the user's email has been verified
  final bool isEmailVerified;
  
  /// User's display name (may be null if not set)
  final String? displayName;
  
  /// URL to the user's profile photo (may be null if not set)
  final String? photoURL;
  
  /// When the user was created
  final DateTime createdAt;
  
  /// When the user last signed in
  final DateTime lastSignInAt;
  
  /// Whether the user is a stylist
  final bool isStylist;

  const AuthUser({
    required this.uid,
    required this.email,
    required this.isEmailVerified,
    this.displayName,
    this.photoURL,
    required this.createdAt,
    required this.lastSignInAt,
    this.isStylist = false,
  });

  /// Creates an empty/anonymous user
  factory AuthUser.empty() {
    return AuthUser(
      uid: '',
      email: '',
      isEmailVerified: false,
      createdAt: DateTime.now(),
      lastSignInAt: DateTime.now(),
    );
  }

  /// Creates a copy of this AuthUser with the specified fields replaced
  AuthUser copyWith({
    String? uid,
    String? email,
    bool? isEmailVerified,
    String? displayName,
    String? photoURL,
    DateTime? createdAt,
    DateTime? lastSignInAt,
    bool? isStylist,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      isStylist: isStylist ?? this.isStylist,
    );
  }

  /// Converts the AuthUser to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'displayName': displayName,
      'photoURL': photoURL,
      'createdAt': createdAt.toIso8601String(),
      'lastSignInAt': lastSignInAt.toIso8601String(),
      'isStylist': isStylist,
    };
  }

  /// Creates an AuthUser from JSON data
  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      lastSignInAt: json['lastSignInAt'] != null
          ? DateTime.parse(json['lastSignInAt'] as String)
          : DateTime.now(),
      isStylist: json['isStylist'] as bool? ?? false,
    );
  }

  /// Whether the user is authenticated
  bool get isAuthenticated => uid.isNotEmpty;
}
