import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zinapp_v2/models/booking.dart';
import 'package:zinapp_v2/services/booking_service.dart';

// Generate the provider code
part 'booking_provider.g.dart';

/// Provider for the BookingService
@riverpod
BookingService bookingService(Ref ref) {
  return BookingService();
}

/// State class for the booking provider
class BookingState {
  final List<Booking> allBookings;
  final List<Booking> upcomingBookings;
  final List<Booking> pastBookings;
  final List<String> favoriteStyles;
  final List<String> favoriteStylists;
  final bool isLoading;
  final String? error;

  const BookingState({
    this.allBookings = const [],
    this.upcomingBookings = const [],
    this.pastBookings = const [],
    this.favoriteStyles = const [],
    this.favoriteStylists = const [],
    this.isLoading = false,
    this.error,
  });

  /// Create a copy of this BookingState with the given fields replaced with new values
  BookingState copyWith({
    List<Booking>? allBookings,
    List<Booking>? upcomingBookings,
    List<Booking>? pastBookings,
    List<String>? favoriteStyles,
    List<String>? favoriteStylists,
    bool? isLoading,
    String? error,
  }) {
    return BookingState(
      allBookings: allBookings ?? this.allBookings,
      upcomingBookings: upcomingBookings ?? this.upcomingBookings,
      pastBookings: pastBookings ?? this.pastBookings,
      favoriteStyles: favoriteStyles ?? this.favoriteStyles,
      favoriteStylists: favoriteStylists ?? this.favoriteStylists,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Provider for managing booking data
@riverpod
class BookingProvider extends _$BookingProvider {
  @override
  BookingState build() {
    return const BookingState();
  }

  /// Load all bookings for the current user
  Future<void> loadUserBookings(String userId) async {
    state = state.copyWith(isLoading: true);

    try {
      final bookings = await ref.read(bookingServiceProvider).getUserBookings(userId);
      
      // Sort bookings by date
      final now = DateTime.now();
      
      // Filter upcoming and past bookings
      final upcomingBookings = bookings
          .where((booking) => booking.appointmentTime.isAfter(now))
          .toList()
        ..sort((a, b) => a.appointmentTime.compareTo(b.appointmentTime));
      
      final pastBookings = bookings
          .where((booking) => booking.appointmentTime.isBefore(now))
          .toList()
        ..sort((a, b) => b.appointmentTime.compareTo(a.appointmentTime)); // Most recent first
      
      // Extract favorite styles and stylists from past bookings
      final favoriteStyles = _extractFavoriteStyles(pastBookings);
      final favoriteStylists = _extractFavoriteStylists(pastBookings);
      
      state = state.copyWith(
        allBookings: bookings,
        upcomingBookings: upcomingBookings,
        pastBookings: pastBookings,
        favoriteStyles: favoriteStyles,
        favoriteStylists: favoriteStylists,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
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
    state = state.copyWith(isLoading: true);

    try {
      final success = await ref.read(bookingServiceProvider).submitBooking(
        userId: userId,
        stylistId: stylistId,
        stylistName: stylistName,
        serviceName: serviceName,
        services: services,
        appointmentTime: appointmentTime,
        duration: duration,
        price: price,
        location: location,
        notes: notes,
      );

      if (success) {
        // Reload bookings to get the new one
        await loadUserBookings(userId);
      }

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Cancel a booking
  Future<bool> cancelBooking(String bookingId, String userId) async {
    state = state.copyWith(isLoading: true);

    try {
      final success = await ref.read(bookingServiceProvider).cancelBooking(bookingId);

      if (success) {
        // Reload bookings to update the list
        await loadUserBookings(userId);
      }

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Rate a booking
  Future<bool> rateBooking(String bookingId, int rating, String? review, String userId) async {
    state = state.copyWith(isLoading: true);

    try {
      final success = await ref.read(bookingServiceProvider).rateBooking(
        bookingId: bookingId,
        rating: rating,
        review: review,
      );

      if (success) {
        // Reload bookings to update the list
        await loadUserBookings(userId);
      }

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Extract favorite styles from past bookings
  List<String> _extractFavoriteStyles(List<Booking> pastBookings) {
    // Count occurrences of each service
    final serviceCount = <String, int>{};
    
    for (final booking in pastBookings) {
      for (final service in booking.services) {
        serviceCount[service] = (serviceCount[service] ?? 0) + 1;
      }
    }
    
    // Sort by count (descending)
    final sortedServices = serviceCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Return top services (up to 5)
    return sortedServices
        .take(5)
        .map((entry) => entry.key)
        .toList();
  }

  /// Extract favorite stylists from past bookings
  List<String> _extractFavoriteStylists(List<Booking> pastBookings) {
    // Count occurrences of each stylist
    final stylistCount = <String, int>{};
    
    for (final booking in pastBookings) {
      stylistCount[booking.stylistId] = (stylistCount[booking.stylistId] ?? 0) + 1;
    }
    
    // Sort by count (descending)
    final sortedStylists = stylistCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Return top stylists (up to 3)
    return sortedStylists
        .take(3)
        .map((entry) => entry.key)
        .toList();
  }
}
