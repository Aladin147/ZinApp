import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zinapp_v2/app/models/user.dart';
import 'package:zinapp_v2/app/models/user_profile.dart';

part 'stylist.g.dart';

/// Represents a stylist in the application
@JsonSerializable()
class Stylist extends Equatable {
  final String id;
  final String username;
  final String? profilePictureUrl;
  final String? bio;
  final String? location;
  final StylistProfile stylistProfile;
  final int level;
  final String rank;
  final List<String> badges;

  const Stylist({
    required this.id,
    required this.username,
    this.profilePictureUrl,
    this.bio,
    this.location,
    required this.stylistProfile,
    required this.level,
    required this.rank,
    required this.badges,
  });

  /// Creates a Stylist from JSON data
  factory Stylist.fromJson(Map<String, dynamic> json) => _$StylistFromJson(json);

  /// Converts Stylist to JSON
  Map<String, dynamic> toJson() => _$StylistToJson(this);

  /// Creates a Stylist from a UserProfile
  factory Stylist.fromUserProfile(UserProfile profile) {
    if (profile.userType != UserType.stylist || profile.stylistProfile == null) {
      throw ArgumentError('UserProfile must be a stylist with stylistProfile');
    }

    return Stylist(
      id: profile.id,
      username: profile.username,
      profilePictureUrl: profile.profilePictureUrl,
      bio: profile.bio,
      location: profile.location,
      stylistProfile: profile.stylistProfile!,
      level: profile.level,
      rank: profile.rank,
      badges: profile.badges,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        profilePictureUrl,
        bio,
        location,
        stylistProfile,
        level,
        rank,
        badges,
      ];
}
