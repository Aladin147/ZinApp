import React from 'react'; // Use standard import
import { View, Text, Image, TouchableOpacity } from 'react-native';
// import { styled } from 'nativewind'; // Remove NativeWind import
import { Booking, Stylist, Service } from '@types'; // Use path alias
import { colors, spacing, typography } from '@constants'; // Use path alias
import tw from 'twrnc'; // Import directly from library

// Remove styled components
// const StyledView = styled(View);
// const StyledText = styled(Text);
// const StyledImage = styled(Image);
// const StyledTouchableOpacity = styled(TouchableOpacity);

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
}: BookingCardProps) => {
  // Placeholder content - needs actual data mapping and styling
  const bookingDate = new Date(booking.datetime).toLocaleDateString();
  const bookingTime = new Date(booking.datetime).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

  // Define shadow style separately for clarity
  const shadowStyle = {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3, // for Android
  };

  return (
    // Use standard TouchableOpacity with twrnc style + shadow
    <TouchableOpacity
      style={[
        tw`bg-white p-4 rounded-lg mb-4 border border-gray-100`,
        shadowStyle, // Apply shadow
      ]}
      onPress={onPress}
      activeOpacity={0.8}
    >
      {/* Use standard View with twrnc style */}
      <View style={tw`flex-row items-center mb-2`}>
        {stylist?.profile_picture && (
          // Use standard Image with twrnc style
          <Image
            source={{ uri: stylist.profile_picture }} // Placeholder - needs actual image handling
            style={tw`w-10 h-10 rounded-full mr-3`}
          />
        )}
        {/* Use standard View with twrnc style */}
        <View style={tw`flex-1`}>
          {/* Use standard Text with twrnc style + inline color */}
          <Text style={[tw`text-base font-semibold`, { color: colors.textMain }]}>
            {stylist?.name || `Stylist ID: ${booking.stylist_id}`}
          </Text>
          {/* Use standard Text with twrnc style + inline color */}
          <Text style={[tw`text-sm`, { color: colors.textMuted }]}>
            {service?.name || `Service ID: ${booking.service_id}`}
          </Text>
        </View>
        {/* Use standard Text with twrnc style + inline color */}
        <Text style={[tw`text-xs font-medium`, { color: colors.primary }]}>
          {booking.status.toUpperCase()}
        </Text>
      </View>

      {/* Use standard View with twrnc style */}
      <View style={tw`border-t border-gray-200 pt-2`}>
        {/* Use standard Text with twrnc style + inline color */}
        <Text style={[tw`text-sm`, { color: colors.textMuted }]}>
          Date: {bookingDate} at {bookingTime}
        </Text>
        {/* Add more details like price, rebook button etc. later */}
      </View>
    </TouchableOpacity>
  );
};

export default BookingCard;
