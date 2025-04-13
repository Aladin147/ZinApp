import 'package:zinapp_v2/models/stylist.dart';

/// Extension methods for the Stylist class to provide convenient accessors
extension StylistExtensions on Stylist {
  /// Get the stylist's name (alias for username)
  String get name => username;

  /// Get the stylist's profile image URL (alias for profilePictureUrl)
  String? get profileImageUrl => profilePictureUrl;

  /// Get the stylist's rating
  double get rating => stylistProfile.rating;

  /// Get the stylist's review count
  int get reviewCount => stylistProfile.reviewCount;

  /// Get the stylist's specialties (alias for services)
  List<String> get specialties => stylistProfile.services;

  /// Check if the stylist is available
  bool get isAvailable => stylistProfile.isAvailable;

  /// Get the stylist's specialization
  String get specialization => stylistProfile.specialization;
}
