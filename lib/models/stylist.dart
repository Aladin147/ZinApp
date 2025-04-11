/// Represents a stylist in the ZinApp application
class Stylist {
  /// Unique identifier for the stylist
  final String stylistId;
  
  /// Display name of the stylist
  final String name;
  
  /// URL to the stylist's profile picture
  final String profilePictureUrl;
  
  /// Stylist's average rating (0-5)
  final double rating;
  
  /// List of the stylist's specialties
  final List<String> specialties;
  
  /// List of service IDs offered by the stylist
  final List<String> servicesOffered;
  
  /// Availability schedule by day of week
  final Map<String, String> availability;
  
  /// Whether the stylist is available now
  final bool isAvailableNow;
  
  /// Stylist's location coordinates
  final StylistLocation location;

  const Stylist({
    required this.stylistId,
    required this.name,
    required this.profilePictureUrl,
    required this.rating,
    required this.specialties,
    required this.servicesOffered,
    required this.availability,
    required this.isAvailableNow,
    required this.location,
  });

  /// Creates a Stylist from JSON data
  factory Stylist.fromJson(Map<String, dynamic> json) {
    return Stylist(
      stylistId: json['stylistId'] as String? ?? 'unknown_stylist',
      name: json['name'] as String? ?? 'Unknown Stylist',
      profilePictureUrl: json['profilePictureUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      servicesOffered: (json['servicesOffered'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      availability: (json['availability'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          {},
      isAvailableNow: json['isAvailableNow'] as bool? ?? false,
      location: json['location'] != null
          ? StylistLocation.fromJson(json['location'] as Map<String, dynamic>)
          : const StylistLocation(latitude: 0.0, longitude: 0.0),
    );
  }

  /// Converts the Stylist to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'stylistId': stylistId,
      'name': name,
      'profilePictureUrl': profilePictureUrl,
      'rating': rating,
      'specialties': specialties,
      'servicesOffered': servicesOffered,
      'availability': availability,
      'isAvailableNow': isAvailableNow,
      'location': location.toJson(),
    };
  }

  /// Returns a copy of this Stylist with the specified fields replaced
  Stylist copyWith({
    String? stylistId,
    String? name,
    String? profilePictureUrl,
    double? rating,
    List<String>? specialties,
    List<String>? servicesOffered,
    Map<String, String>? availability,
    bool? isAvailableNow,
    StylistLocation? location,
  }) {
    return Stylist(
      stylistId: stylistId ?? this.stylistId,
      name: name ?? this.name,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      rating: rating ?? this.rating,
      specialties: specialties ?? this.specialties,
      servicesOffered: servicesOffered ?? this.servicesOffered,
      availability: availability ?? this.availability,
      isAvailableNow: isAvailableNow ?? this.isAvailableNow,
      location: location ?? this.location,
    );
  }
}

/// Represents a stylist's location coordinates
class StylistLocation {
  /// Latitude coordinate
  final double latitude;
  
  /// Longitude coordinate
  final double longitude;

  const StylistLocation({
    required this.latitude,
    required this.longitude,
  });

  /// Creates a StylistLocation from JSON data
  factory StylistLocation.fromJson(Map<String, dynamic> json) {
    return StylistLocation(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Converts the StylistLocation to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
