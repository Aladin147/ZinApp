import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// Enum representing the type of user
enum UserType {
  @JsonValue('regular')
  regular,
  @JsonValue('stylist')
  stylist,
}

/// Base User model containing core authentication and identity information
@JsonSerializable()
class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final String? profilePictureUrl;
  final UserType userType;
  final DateTime createdAt;
  final DateTime lastLogin;

  const User({
    required this.id,
    required this.email,
    required this.username,
    this.profilePictureUrl,
    required this.userType,
    required this.createdAt,
    required this.lastLogin,
  });

  /// Creates a User from JSON data
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts User to JSON
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        profilePictureUrl,
        userType,
        createdAt,
        lastLogin,
      ];

  /// Creates a copy of this User with the given fields replaced with new values
  User copyWith({
    String? id,
    String? email,
    String? username,
    String? profilePictureUrl,
    UserType? userType,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}
