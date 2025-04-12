import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zinapp_v2/models/user.dart';

part 'user_profile.g.dart';

/// Extended User Profile model with gamification elements
@JsonSerializable()
class UserProfile extends User {
  final int xp;
  final int level;
  final int tokens;
  final List<String> achievements;
  final List<String> badges;
  final String rank;
  final String? bio;
  final String? location;
  final List<String>? favoriteStyles;
  final List<String>? favoriteStylistIds;
  final int postsCount;
  final int bookingsCount;
  final int followersCount;
  final int followingCount;
  final Map<String, dynamic>? preferences;
  final StylistProfile? stylistProfile;

  const UserProfile({
    required super.id,
    required super.email,
    required super.username,
    super.profilePictureUrl,
    required super.userType,
    required super.createdAt,
    required super.lastLogin,
    required this.xp,
    required this.level,
    required this.tokens,
    required this.achievements,
    required this.badges,
    required this.rank,
    this.bio,
    this.location,
    this.favoriteStyles,
    this.favoriteStylistIds,
    required this.postsCount,
    required this.bookingsCount,
    required this.followersCount,
    required this.followingCount,
    this.preferences,
    this.stylistProfile,
  });

  /// Creates a UserProfile from JSON data
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object?> get props => [
        ...super.props,
        xp,
        level,
        tokens,
        achievements,
        badges,
        rank,
        bio,
        location,
        favoriteStyles,
        favoriteStylistIds,
        postsCount,
        bookingsCount,
        followersCount,
        followingCount,
        preferences,
        stylistProfile,
      ];

  /// Creates a copy of this UserProfile with the given fields replaced with new values
  @override
  UserProfile copyWith({
    String? id,
    String? email,
    String? username,
    String? profilePictureUrl,
    UserType? userType,
    DateTime? createdAt,
    DateTime? lastLogin,
    int? xp,
    int? level,
    int? tokens,
    List<String>? achievements,
    List<String>? badges,
    String? rank,
    String? bio,
    String? location,
    List<String>? favoriteStyles,
    List<String>? favoriteStylistIds,
    int? postsCount,
    int? bookingsCount,
    int? followersCount,
    int? followingCount,
    Map<String, dynamic>? preferences,
    StylistProfile? stylistProfile,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      tokens: tokens ?? this.tokens,
      achievements: achievements ?? this.achievements,
      badges: badges ?? this.badges,
      rank: rank ?? this.rank,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      favoriteStyles: favoriteStyles ?? this.favoriteStyles,
      favoriteStylistIds: favoriteStylistIds ?? this.favoriteStylistIds,
      postsCount: postsCount ?? this.postsCount,
      bookingsCount: bookingsCount ?? this.bookingsCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      preferences: preferences ?? this.preferences,
      stylistProfile: stylistProfile ?? this.stylistProfile,
    );
  }
}

/// Stylist-specific profile information
@JsonSerializable()
class StylistProfile extends Equatable {
  final String specialization;
  final List<String> services;
  final double rating;
  final int reviewCount;
  final String? businessName;
  final String? businessAddress;
  final Map<String, dynamic>? businessHours;
  final List<String>? portfolioUrls;
  final bool isAvailable;
  final int completedBookings;
  final int clientCount;

  const StylistProfile({
    required this.specialization,
    required this.services,
    required this.rating,
    required this.reviewCount,
    this.businessName,
    this.businessAddress,
    this.businessHours,
    this.portfolioUrls,
    required this.isAvailable,
    required this.completedBookings,
    required this.clientCount,
  });

  /// Creates a StylistProfile from JSON data
  factory StylistProfile.fromJson(Map<String, dynamic> json) =>
      _$StylistProfileFromJson(json);

  /// Converts StylistProfile to JSON
  Map<String, dynamic> toJson() => _$StylistProfileToJson(this);

  @override
  List<Object?> get props => [
        specialization,
        services,
        rating,
        reviewCount,
        businessName,
        businessAddress,
        businessHours,
        portfolioUrls,
        isAvailable,
        completedBookings,
        clientCount,
      ];

  /// Creates a copy of this StylistProfile with the given fields replaced with new values
  StylistProfile copyWith({
    String? specialization,
    List<String>? services,
    double? rating,
    int? reviewCount,
    String? businessName,
    String? businessAddress,
    Map<String, dynamic>? businessHours,
    List<String>? portfolioUrls,
    bool? isAvailable,
    int? completedBookings,
    int? clientCount,
  }) {
    return StylistProfile(
      specialization: specialization ?? this.specialization,
      services: services ?? this.services,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      businessHours: businessHours ?? this.businessHours,
      portfolioUrls: portfolioUrls ?? this.portfolioUrls,
      isAvailable: isAvailable ?? this.isAvailable,
      completedBookings: completedBookings ?? this.completedBookings,
      clientCount: clientCount ?? this.clientCount,
    );
  }
}
