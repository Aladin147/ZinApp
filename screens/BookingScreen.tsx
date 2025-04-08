import * as React from 'react';
import { View, Text, Button } from 'react-native';
import { styled } from 'nativewind';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '@types';
import { colors, spacing } from '@constants';
import { useAuth } from '@state/AuthContext'; // Import useAuth hook

const StyledView = styled(View);
const StyledText = styled(Text);

type BookingScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'BookingScreen'
>;
type BookingScreenRouteProp = RouteProp<RootStackParamList, 'BookingScreen'>;

type Props = {
  navigation: BookingScreenNavigationProp;
  route: BookingScreenRouteProp;
};

const BookingScreen: React.FC<Props> = ({ navigation, route }) => {
  const { stylistId, serviceId } = route.params;
  const { isVerified } = useAuth(); // Get verification status

  return (
    <StyledView className="flex-1 items-center justify-center bg-white p-4">
      <StyledText className="text-xl font-semibold mb-4 text-textMain">
        Confirm Booking (BookingScreen)
      </StyledText>
      <StyledText className="mb-2 text-textMuted">Stylist ID: {stylistId}</StyledText>
      <StyledText className="mb-6 text-textMuted">Service ID: {serviceId}</StyledText>

      {/* Placeholder for Date/Time Picker */}
      <StyledText className="mb-4 text-textMain">Date/Time Picker Placeholder</StyledText>

      {/* Conditional Payment Info */}
      <StyledView className="mb-6 p-3 border border-gray-200 rounded w-full items-center">
        <StyledText className="text-base font-medium mb-2 text-textMain">Payment</StyledText>
        {isVerified ? (
          <StyledText className="text-sm text-green-600">
            Verified User: Pay now or select 'Pay Later' (Toggle Placeholder)
          </StyledText>
        ) : (
          <StyledText className="text-sm text-red-600">
            Guest User: Add card to continue (Input Placeholder)
          </StyledText>
        )}
      </StyledView>

      <Button
        title="Confirm Booking"
        onPress={() => navigation.navigate('LiveTrackScreen', { bookingId: 101 })} // Example bookingId
        color={colors.primary}
      />
    </StyledView>
  );
};

export default BookingScreen;
