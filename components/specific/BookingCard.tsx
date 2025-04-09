import React from 'react';
import { View, Image, StyleSheet } from 'react-native';
import { Booking, Stylist, Service } from '../../types';
import { colors, spacing } from '../../constants';
import Card from '../common/Card';
import Typography from '../common/Typography';
import Button from '../common/Button';
import RatingStars from '../common/RatingStars';
import Icon from 'react-native-vector-icons/FontAwesome';

interface BookingCardProps {
  booking: Booking;
  stylist?: Stylist; // Optional: Pass stylist details if available
  service?: Service; // Optional: Pass service details if available
  onPress?: () => void;
}

/**
 * BookingCard Component
 *
 * Displays a summary of a past or upcoming booking.
 * Used in booking history, favorites, or rebooking scenarios.
 *
 * Based on the design specifications in the conceptboard:
 * - Warm background color
 * - Stylist avatar with verification badge
 * - Service details and pricing
 * - Booking date and time
 * - Status indicator
 * - Rebook button for completed bookings
 */
const BookingCard: React.FC<BookingCardProps> = ({
  booking,
  stylist,
  service,
  onPress,
}) => {
  // Format date and time for display
  const bookingDate = new Date(booking.datetime).toLocaleDateString('en-US', {
    weekday: 'short',
    month: 'short',
    day: 'numeric'
  });

  const bookingTime = new Date(booking.datetime).toLocaleTimeString('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: true
  });

  // Determine if booking is completed
  const isCompleted = booking.status === 'completed';

  // Determine if booking is active (en_route or arrived)
  const isActive = booking.status === 'en_route' || booking.status === 'arrived';

  // Get status color based on booking status
  const getStatusColor = () => {
    switch (booking.status) {
      case 'confirmed':
        return colors.info;
      case 'en_route':
      case 'arrived':
        return colors.primary;
      case 'completed':
        return colors.success;
      case 'canceled':
        return colors.error;
      default:
        return colors.textMuted;
    }
  };

  // Get status text for display
  const getStatusText = () => {
    switch (booking.status) {
      case 'confirmed':
        return 'Confirmed';
      case 'en_route':
        return 'On the way';
      case 'arrived':
        return 'Arrived';
      case 'completed':
        return 'Completed';
      case 'canceled':
        return 'Canceled';
      default:
        return booking.status;
    }
  };

  // Handle rebook action
  const handleRebook = () => {
    // Call onPress with the stylist and service IDs
    if (onPress) {
      onPress();
    }
  };

  // Placeholder image for development
  const placeholderImage = 'https://via.placeholder.com/100';
  const imageSource = stylist?.profile_picture
    ? { uri: stylist.profile_picture.startsWith('http') ? stylist.profile_picture : placeholderImage }
    : { uri: placeholderImage };

  return (
    <Card
      variant="warm"
      padding="medium"
      style={styles.card}
      onPress={onPress}
    >
      {/* Header with stylist info and status */}
      <View style={styles.header}>
        <View style={styles.stylistContainer}>
          <View style={styles.avatarContainer}>
            <Image
              source={imageSource}
              style={styles.avatar}
              resizeMode="cover"
            />
            {stylist?.verified && (
              <View style={styles.verifiedBadge}>
                <Typography variant="caption" color="white" align="center" style={styles.verifiedText}>
                  ✓
                </Typography>
              </View>
            )}
          </View>

          <View style={styles.stylistInfo}>
            <Typography variant="sectionHeader">
              {stylist?.name || `Stylist #${booking.stylist_id}`}
            </Typography>

            {stylist?.rating && (
              <View style={styles.ratingContainer}>
                <RatingStars rating={stylist.rating} size="small" />
                <Typography variant="caption" style={styles.ratingText}>
                  {stylist.rating.toFixed(1)}
                </Typography>
              </View>
            )}
          </View>
        </View>

        <View style={[styles.statusBadge, { backgroundColor: getStatusColor() }]}>
          <Typography variant="caption" color="white">
            {getStatusText()}
          </Typography>
        </View>
      </View>

      {/* Service details */}
      <View style={styles.serviceContainer}>
        <View style={styles.serviceInfo}>
          <Typography variant="body">
            {service?.name || `Service #${booking.service_id}`}
          </Typography>

          <Typography variant="caption" color={colors.textMuted}>
            {bookingDate} at {bookingTime}
          </Typography>
        </View>

        {service?.price && (
          <Typography variant="bodyMedium">
            {service.price} MAD
          </Typography>
        )}
      </View>

      {/* Footer with action buttons for completed bookings */}
      {isCompleted && (
        <View style={styles.footer}>
          <Button
            title="Rebook"
            variant="primary"
            size="small"
            iconName="refresh"
            iconPosition="left"
            onPress={handleRebook}
          />

          {!booking.rating_given && (
            <Button
              title="Rate"
              variant="outline"
              size="small"
              iconName="star"
              iconPosition="left"
              onPress={onPress}
              style={styles.rateButton}
            />
          )}
        </View>
      )}

      {/* Active booking indicator */}
      {isActive && (
        <View style={styles.activeIndicator}>
          <Icon name="location-arrow" size={14} color={colors.primary} style={styles.activeIcon} />
          <Typography variant="caption" color={colors.primary}>
            Track your stylist
          </Typography>
        </View>
      )}
    </Card>
  );
};

const styles = StyleSheet.create({
  card: {
    marginBottom: spacing.md,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: spacing.sm,
  },
  stylistContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  avatarContainer: {
    position: 'relative',
    marginRight: spacing.sm,
  },
  avatar: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: colors.gray200,
  },
  verifiedBadge: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    width: 18,
    height: 18,
    borderRadius: 9,
    backgroundColor: colors.accent,
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 2,
    borderColor: colors.warmSand,
  },
  verifiedText: {
    fontSize: 10,
    lineHeight: 14,
  },
  stylistInfo: {
    justifyContent: 'center',
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: spacing.xxs,
  },
  ratingText: {
    marginLeft: spacing.xxs,
  },
  statusBadge: {
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xxs,
    borderRadius: 12,
  },
  serviceContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: spacing.sm,
    borderTopWidth: 1,
    borderTopColor: colors.gray200,
    borderBottomWidth: 1,
    borderBottomColor: colors.gray200,
    marginBottom: spacing.sm,
  },
  serviceInfo: {
    flex: 1,
  },
  footer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  rateButton: {
    marginLeft: spacing.sm,
  },
  activeIndicator: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: spacing.xs,
    backgroundColor: 'rgba(244, 128, 93, 0.1)',
    borderRadius: 8,
    marginTop: spacing.sm,
  },
  activeIcon: {
    marginRight: spacing.xxs,
  },
});

export default BookingCard;
