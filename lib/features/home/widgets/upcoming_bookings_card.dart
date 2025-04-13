import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zinapp_v2/models/booking.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/dashboard/expandable_dashboard_card.dart';

/// A card that displays upcoming bookings
class UpcomingBookingsCard extends StatelessWidget {
  /// List of upcoming bookings
  final List<Booking> bookings;
  
  /// Callback when a booking is tapped
  final Function(Booking)? onBookingTap;
  
  /// Callback when the view all button is tapped
  final VoidCallback? onViewAllTap;
  
  /// Callback when the book now button is tapped
  final VoidCallback? onBookNowTap;
  
  /// Initial state of the card
  final DashboardCardState initialState;

  /// Creates an upcoming bookings card
  const UpcomingBookingsCard({
    super.key,
    required this.bookings,
    this.onBookingTap,
    this.onViewAllTap,
    this.onBookNowTap,
    this.initialState = DashboardCardState.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Removed unused variable
    
    // Sort bookings by date
    final sortedBookings = List<Booking>.from(bookings)
      ..sort((a, b) => a.appointmentTime.compareTo(b.appointmentTime));
    
    // Get upcoming bookings (future dates only)
    final upcomingBookings = sortedBookings
        .where((booking) => booking.appointmentTime.isAfter(DateTime.now()))
        .toList();
    
    return ExpandableDashboardCard(
      title: 'Upcoming Bookings',
      subtitle: upcomingBookings.isEmpty
          ? 'No upcoming bookings'
          : 'Next: ${_formatDate(upcomingBookings.first.appointmentTime)}',
      icon: Icons.calendar_today,
      accentColor: Colors.green,
      initialState: initialState,
      onViewAllTap: onViewAllTap,
      
      // Collapsed view - next booking or empty state
      collapsedChild: upcomingBookings.isEmpty
          ? _buildEmptyState(context)
          : _buildNextBooking(context, upcomingBookings.first),
      
      // Expanded view - list of upcoming bookings
      expandedChild: upcomingBookings.isEmpty
          ? _buildEmptyState(context)
          : Column(
              children: [
                ...upcomingBookings
                    .take(3)
                    .map((booking) => _buildBookingItem(context, booking))
                    .toList(),
                
                if (upcomingBookings.length > 3) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton.icon(
                      onPressed: onViewAllTap,
                      icon: const Icon(Icons.calendar_month),
                      label: Text('View All ${upcomingBookings.length} Bookings'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 16),
                
                // Book now button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onBookNowTap,
                    icon: const Icon(Icons.add),
                    label: const Text('Book New Appointment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.white.withOpacity(0.5),
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'No upcoming bookings',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onBookNowTap,
            icon: const Icon(Icons.add),
            label: const Text('Book Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNextBooking(BuildContext context, Booking booking) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () => onBookingTap?.call(booking),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.green.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Date column
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd').format(booking.appointmentTime),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('MMM').format(booking.appointmentTime),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Booking details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.stylistName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking.serviceName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white.withOpacity(0.5),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('h:mm a').format(booking.appointmentTime),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.location_on,
                        color: Colors.white.withOpacity(0.5),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          booking.location,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Status indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Confirmed',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBookingItem(BuildContext context, Booking booking) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onBookingTap?.call(booking),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.baseDarkAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Date column
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('dd').format(booking.appointmentTime),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('MMM').format(booking.appointmentTime),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Booking details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.stylistName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      booking.serviceName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white.withOpacity(0.5),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('h:mm a').format(booking.appointmentTime),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Status indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Confirmed',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final bookingDate = DateTime(date.year, date.month, date.day);
    
    if (bookingDate == today) {
      return 'Today, ${DateFormat('h:mm a').format(date)}';
    } else if (bookingDate == tomorrow) {
      return 'Tomorrow, ${DateFormat('h:mm a').format(date)}';
    } else {
      return DateFormat('MMM d, h:mm a').format(date);
    }
  }
}
