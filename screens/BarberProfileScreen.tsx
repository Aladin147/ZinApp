import React from 'react'; // Use standard import
import { View, Text, Button, ScrollView } from 'react-native';
// import { styled } from 'nativewind'; // Remove NativeWind import
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '@types'; // Use path alias
import { colors, spacing } from '@constants'; // Use path alias
import tw from 'twrnc'; // Import directly from library

// Remove styled components
// const StyledView = styled(View);
// const StyledText = styled(Text);
// const StyledScrollView = styled(ScrollView);

type BarberProfileScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'BarberProfileScreen'
>;
type BarberProfileScreenRouteProp = RouteProp<
  RootStackParamList,
  'BarberProfileScreen'
>;

type Props = {
  navigation: BarberProfileScreenNavigationProp;
  route: BarberProfileScreenRouteProp;
};

const BarberProfileScreen: React.FC<Props> = ({ navigation, route }) => {
  const stylistId = route.params?.stylistId;
  const isQrSource = route.params?.qrSource;

  // Placeholder data - replace with API call later
  const mockStylist = { id: stylistId, name: 'Mock Stylist Name', bio: 'Bio...' };

  return (
    // Use standard ScrollView with twrnc style
    <ScrollView style={tw`flex-1 bg-white p-4`}>
      {/* Use standard Text with twrnc style + inline color */}
      <Text style={[tw`text-xl font-semibold mb-4`, { color: colors.textMain }]}>
        {mockStylist.name} (BarberProfileScreen)
      </Text>
      {/* Use standard Text with twrnc style + inline color */}
      <Text style={[tw`mb-4`, { color: colors.textMuted }]}>{mockStylist.bio}</Text>
      {isQrSource && (
        // Use standard Text with twrnc style + inline color
        <Text style={[tw`text-sm mb-4`, { color: colors.info }]}> {/* Assuming blue-500 maps to info */}
          (Came from QR Scan)
        </Text>
      )}
      {/* Placeholder for AvatarBadge, Gallery, Service List */}
      {/* Standard Button */}
      <Button
        title="Book This Stylist"
        onPress={() => navigation.navigate('BookingScreen', { stylistId: stylistId, serviceId: 1 })} // Example serviceId
        color={colors.primary}
      />
    </ScrollView> // Correct closing tag
  );
};

export default BarberProfileScreen;
