import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

/// Status of a booking
enum BookingStatus {
  @JsonValue('pending')
  pending,
  
  @JsonValue('confirmed')
  confirmed,
  
  @JsonValue('completed')
  completed,
  
  @JsonValue('cancelled')
  cancelled,
  
  @JsonValue('no_show')
  noShow,
}

/// Represents a booking in the application
@JsonSerializable()
class Booking extends Equatable {
  final String id;
  final String userId;
  final String stylistId;
  final String stylistName;
  final String serviceName;
  final List<String> services;
  final BookingStatus status;
  final DateTime appointmentTime;
  final int duration;
  final double price;
  final String location;
  final String? notes;
  final int? rating;
  final String? review;
  final DateTime createdAt;

  const Booking({
    required this.id,
    required this.userId,
    required this.stylistId,
    required this.stylistName,
    required this.serviceName,
    required this.services,
    required this.status,
    required this.appointmentTime,
    required this.duration,
    required this.price,
    required this.location,
    this.notes,
    this.rating,
    this.review,
    required this.createdAt,
  });

  /// Creates a Booking from JSON data
  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  /// Converts Booking to JSON
  Map<String, dynamic> toJson() => _$BookingToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        stylistId,
        stylistName,
        serviceName,
        services,
        status,
        appointmentTime,
        duration,
        price,
        location,
        notes,
        rating,
        review,
        createdAt,
      ];
}
