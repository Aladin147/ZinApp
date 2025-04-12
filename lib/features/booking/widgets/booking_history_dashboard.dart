import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/booking/providers/riverpod/booking_provider.dart';
import 'package:zinapp_v2/features/booking/widgets/favorite_styles_card.dart';
import 'package:zinapp_v2/features/booking/widgets/past_bookings_card.dart';
import 'package:zinapp_v2/features/booking/widgets/rebook_card.dart';
import 'package:zinapp_v2/features/home/widgets/upcoming_bookings_card.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/widgets/dashboard/dashboard_container.dart';

/// A dashboard widget for the Booking History screen
class BookingHistoryDashboard extends ConsumerWidget {
  const BookingHistoryDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final bookingState = ref.watch(bookingProviderProvider);
    final user = authState.user;

    if (user == null) {
      return const Center(
        child: Text('User not found'),
      );
    }

    if (bookingState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (bookingState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              bookingState.error ?? 'An error occurred',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(bookingProviderProvider.notifier).loadUserBookings(user.id);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return DashboardContainer(
      children: [
        // Upcoming bookings card
        UpcomingBookingsCard(
          bookings: bookingState.upcomingBookings,
          onBookingTap: (booking) {
            // TODO: Navigate to booking details
          },
          onViewAllTap: () {
            // Already on the booking history screen
          },
          onBookNowTap: () => context.go(AppRoutes.booking),
        ),
        
        // Past bookings card
        PastBookingsCard(
          bookings: bookingState.pastBookings,
          onBookingTap: (booking) {
            // TODO: Navigate to booking details
          },
        ),
        
        // Favorite styles card
        FavoriteStylesCard(
          favoriteStyles: bookingState.favoriteStyles,
          onStyleTap: (style) {
            // TODO: Navigate to style details
          },
        ),
        
        // Rebook card
        RebookCard(
          favoriteStylists: bookingState.favoriteStylists,
          onStylistTap: (stylistId) {
            context.go(AppRoutes.stylistDetail.replaceFirst(':id', stylistId));
          },
          onBookNowTap: () => context.go(AppRoutes.booking),
        ),
      ],
    );
  }
}
