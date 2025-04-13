import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/models/booking.dart'; // Assuming Booking model exists
import 'package:zinapp_v2/data/datasources/remote/user_remote_data_source.dart'; // For dioProvider

/// Abstract class for remote booking data operations.
abstract class BookingRemoteDataSource {
  /// Fetches bookings, potentially filtered by userId or stylistId.
  Future<List<Booking>> getBookings({Map<String, dynamic>? queryParams});
  Future<Booking> getBookingById(String bookingId);
  Future<Booking> createBooking(Booking booking);
  Future<Booking> updateBooking(Booking booking); // e.g., change status, add review
  Future<void> cancelBooking(String bookingId);
}

/// Implementation of [BookingRemoteDataSource] using Dio.
class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final Dio _dio;
  final String _baseUrl = 'http://127.0.0.1:3000';

  BookingRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Booking>> getBookings({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/bookings',
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        final List<dynamic> bookingList = response.data as List<dynamic>;
        return bookingList
            .map((json) => Booking.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      throw Exception('Failed to fetch bookings.');
    }
  }

  @override
  Future<Booking> getBookingById(String bookingId) async {
    try {
      final response = await _dio.get('$_baseUrl/bookings/$bookingId');
      if (response.statusCode == 200) {
        return Booking.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error fetching booking $bookingId: $e');
      throw Exception('Failed to fetch booking.');
    }
  }

  @override
  Future<Booking> createBooking(Booking booking) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/bookings',
        data: booking.toJson(),
      );
      if (response.statusCode == 201) {
        return Booking.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error creating booking: $e');
      throw Exception('Failed to create booking.');
    }
  }

  @override
  Future<Booking> updateBooking(Booking booking) async {
    try {
      // Use PATCH for partial updates (e.g., just status or review)
      // Use PUT for full replacement
      final response = await _dio.patch( // Using PATCH as example
        '$_baseUrl/bookings/${booking.id}',
        data: booking.toJson(), // Send full object, json-server handles it
      );
      if (response.statusCode == 200) {
        return Booking.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      print('Error updating booking ${booking.id}: $e');
      throw Exception('Failed to update booking.');
    }
  }

   @override
  Future<void> cancelBooking(String bookingId) async {
     // Option 1: Delete the booking
     // Option 2: Update status to 'cancelled' (requires PATCH/PUT)
    try {
      // Example using PATCH to update status
       final response = await _dio.patch(
         '$_baseUrl/bookings/$bookingId',
         data: {'status': 'cancelled'}, // Only send the changed field
       );
       if (response.statusCode != 200) {
         throw DioException(
             requestOptions: response.requestOptions, response: response);
       }
    } catch (e) {
      print('Error cancelling booking $bookingId: $e');
      throw Exception('Failed to cancel booking.');
    }
  }
}

// --- Riverpod Provider ---
final bookingRemoteDataSourceProvider = Provider<BookingRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return BookingRemoteDataSourceImpl(dio);
});
