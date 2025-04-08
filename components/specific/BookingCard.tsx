import * as React from 'react'; // Use namespace import
import { View, Text, Image, TouchableOpacity } from 'react-native';
import { styled } from 'nativewind';
import { Booking, Stylist, Service } from '@types'; // Assuming we'll pass related data
import { colors, spacing, typography } from '@constants';

// Apply NativeWind styling to React Native components
const StyledView = styled(View);
const StyledText = styled(Text);
const StyledImage = styled(Image);
const StyledTouchableOpacity = styled(TouchableOpacity);

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
 */
const BookingCard: React.FC<BookingCardProps> = ({
  booking,
  stylist,
  service,
  onPress,
}: BookingCardProps) => { // Add explicit type annotation here
  // Placeholder content - needs actual data mapping and styling
  const bookingDate = new Date(booking.datetime).toLocaleDateString();
  const bookingTime = new Date(booking.datetime).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

  return (
    <StyledTouchableOpacity
      className="bg-white p-4 rounded-lg shadow-md mb-4 border border-gray-100"
      onPress={onPress}
      activeOpacity={0.8}
    >
      <StyledView className="flex-row items-center mb-2">
        {stylist?.profile_picture && (
          <StyledImage
            source={{ uri: stylist.profile_picture }} // Placeholder - needs actual image handling
            className="w-10 h-10 rounded-full mr-3"
          />
        )}
        <StyledView className="flex-1">
          <StyledText className="text-base font-semibold text-textMain">
            {stylist?.name || `Stylist ID: ${booking.stylist_id}`}
          </StyledText>
          <StyledText className="text-sm text-textMuted">
            {service?.name || `Service ID: ${booking.service_id}`}
          </StyledText>
        </StyledView>
        <StyledText className="text-xs font-medium text-primary">
          {booking.status.toUpperCase()}
        </StyledText>
      </StyledView>

      <StyledView className="border-t border-gray-200 pt-2">
        <StyledText className="text-sm text-textMuted">
          Date: {bookingDate} at {bookingTime}
        </StyledText>
        {/* Add more details like price, rebook button etc. later */}
      </StyledView>
    </StyledTouchableOpacity>
  );
};

export default BookingCard;
