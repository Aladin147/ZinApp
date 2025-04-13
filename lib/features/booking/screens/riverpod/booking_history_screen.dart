import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/features/booking/providers/riverpod/booking_provider.dart';
import 'package:zinapp_v2/features/booking/widgets/booking_history_dashboard.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A screen that displays the user's booking history
class BookingHistoryScreen extends ConsumerStatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  ConsumerState<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends ConsumerState<BookingHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Load booking data
    Future.microtask(() {
      final authState = ref.read(authProvider);
      if (authState.isAuthenticated && authState.user != null) {
        ref.read(bookingProviderProvider.notifier).loadUserBookings(authState.user!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    if (!authState.isAuthenticated || authState.user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please log in to view your bookings'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        backgroundColor: AppColors.baseDark,
        foregroundColor: Colors.white,
      ),
      body: const BookingHistoryDashboard(),
    );
  }
}
