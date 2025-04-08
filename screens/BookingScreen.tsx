import React from 'react'; // Use standard import
import { View, Text, Button, ScrollView } from 'react-native'; // Added ScrollView
// import { styled } from 'nativewind'; // Remove NativeWind import
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types'; // Use relative path for now
import { colors, spacing } from '../constants'; // Use relative path for now
import { useAuth } from '../state/AuthContext'; // Use relative path for now
import tw from '../twrnc'; // Import twrnc

// Remove styled components
// const StyledView = styled(View);
// const StyledText = styled(Text);

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

  // Use ScrollView in case content overflows
  return (
    <ScrollView contentContainerStyle={tw`flex-grow items-center justify-center bg-white p-4`}>
      <Text style={[tw`text-xl font-semibold mb-4`, { color: colors.textMain }]}>
        Confirm Booking (BookingScreen)
      </Text>
      <Text style={[tw`mb-2`, { color: colors.textMuted }]}>Stylist ID: {stylistId}</Text>
      <Text style={[tw`mb-6`, { color: colors.textMuted }]}>Service ID: {serviceId}</Text>

      {/* Placeholder for Date/Time Picker */}
      <Text style={[tw`mb-4`, { color: colors.textMain }]}>Date/Time Picker Placeholder</Text>

      {/* Conditional Payment Info */}
      <View style={tw`mb-6 p-3 border border-gray-200 rounded w-full items-center`}>
        <Text style={[tw`text-base font-medium mb-2`, { color: colors.textMain }]}>Payment</Text>
        {isVerified ? (
          <Text style={[tw`text-sm`, { color: colors.success }]}> {/* Assuming green-600 maps to success */}
            Verified User: Pay now or select 'Pay Later' (Toggle Placeholder)
          </Text>
        ) : (
          <Text style={[tw`text-sm`, { color: colors.error }]}> {/* Assuming red-600 maps to error */}
            Guest User: Add card to continue (Input Placeholder)
          </Text>
        )}
      </View>

      <Button
        title="Confirm Booking"
        onPress={() => navigation.navigate('LiveTrackScreen', { bookingId: 101 })} // Example bookingId
        color={colors.primary}
      />
    </ScrollView>
  );
};

export default BookingScreen;
