import 'package:zinapp_v2/models/booking.dart';
import 'package:zinapp_v2/services/mock_data.dart';
import 'package:uuid/uuid.dart';

/// Service for managing bookings
class BookingService {
  final _uuid = const Uuid();

  /// Get all bookings for a user
  Future<List<Booking>> getUserBookings(String userId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, this would fetch from an API
    // For now, we'll use mock data
    final List<Booking> bookings = [];

    // Create some mock bookings
    final now = DateTime.now();
    
    // Past bookings
    bookings.add(
      Booking(
        id: 'booking1',
        userId: userId,
        stylistId: 'stylist1',
        stylistName: 'Alex Johnson',
        serviceName: 'Haircut',
        services: ['Haircut', 'Styling'],
        status: BookingStatus.completed,
        appointmentTime: now.subtract(const Duration(days: 14)),
        duration: 60,
        price: 45.0,
        location: 'Downtown Salon',
        rating: 5,
        review: 'Great service!',
        createdAt: now.subtract(const Duration(days: 20)),
      ),
    );
    
    bookings.add(
      Booking(
        id: 'booking2',
        userId: userId,
        stylistId: 'stylist2',
        stylistName: 'Jamie Smith',
        serviceName: 'Color',
        services: ['Color', 'Treatment'],
        status: BookingStatus.completed,
        appointmentTime: now.subtract(const Duration(days: 7)),
        duration: 120,
        price: 85.0,
        location: 'Uptown Beauty',
        rating: 4,
        review: 'Very good, but took longer than expected',
        createdAt: now.subtract(const Duration(days: 10)),
      ),
    );
    
    // Upcoming bookings
    bookings.add(
      Booking(
        id: 'booking3',
        userId: userId,
        stylistId: 'stylist1',
        stylistName: 'Alex Johnson',
        serviceName: 'Haircut & Style',
        services: ['Haircut', 'Styling'],
        status: BookingStatus.confirmed,
        appointmentTime: now.add(const Duration(days: 3)),
        duration: 60,
        price: 45.0,
        location: 'Downtown Salon',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
    );
    
    bookings.add(
      Booking(
        id: 'booking4',
        userId: userId,
        stylistId: 'stylist3',
        stylistName: 'Taylor Wilson',
        serviceName: 'Full Treatment',
        services: ['Color', 'Treatment', 'Styling'],
        status: BookingStatus.confirmed,
        appointmentTime: now.add(const Duration(days: 10)),
        duration: 150,
        price: 120.0,
        location: 'Luxury Spa & Salon',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    );

    return bookings;
  }

  /// Submit a new booking
  Future<bool> submitBooking({
    required String userId,
    required String stylistId,
    required String stylistName,
    required String serviceName,
    required List<String> services,
    required DateTime appointmentTime,
    required int duration,
    required double price,
    required String location,
    String? notes,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 1200));

    // In a real app, this would submit to an API
    // For now, we'll just return success
    return true;
  }

  /// Cancel a booking
  Future<bool> cancelBooking(String bookingId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, this would submit to an API
    // For now, we'll just return success
    return true;
  }

  /// Rate a booking
  Future<bool> rateBooking({
    required String bookingId,
    required int rating,
    String? review,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, this would submit to an API
    // For now, we'll just return success
    return true;
  }
}
