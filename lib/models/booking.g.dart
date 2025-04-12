// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
  id: json['id'] as String,
  userId: json['userId'] as String,
  stylistId: json['stylistId'] as String,
  stylistName: json['stylistName'] as String,
  serviceName: json['serviceName'] as String,
  services:
      (json['services'] as List<dynamic>).map((e) => e as String).toList(),
  status: $enumDecode(_$BookingStatusEnumMap, json['status']),
  appointmentTime: DateTime.parse(json['appointmentTime'] as String),
  duration: (json['duration'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  location: json['location'] as String,
  notes: json['notes'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  review: json['review'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'stylistId': instance.stylistId,
  'stylistName': instance.stylistName,
  'serviceName': instance.serviceName,
  'services': instance.services,
  'status': _$BookingStatusEnumMap[instance.status]!,
  'appointmentTime': instance.appointmentTime.toIso8601String(),
  'duration': instance.duration,
  'price': instance.price,
  'location': instance.location,
  'notes': instance.notes,
  'rating': instance.rating,
  'review': instance.review,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$BookingStatusEnumMap = {
  BookingStatus.pending: 'pending',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.completed: 'completed',
  BookingStatus.cancelled: 'cancelled',
  BookingStatus.noShow: 'no_show',
};
