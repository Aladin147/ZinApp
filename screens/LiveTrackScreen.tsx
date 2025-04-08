import React from 'react'; // Use standard import
import { View, Text, Button } from 'react-native';
// import { styled } from 'nativewind'; // Remove NativeWind import
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types'; // Use relative path for now
import { colors, spacing } from '../constants'; // Use relative path for now
import tw from '../twrnc'; // Import twrnc

// Remove styled components
// const StyledView = styled(View);
// const StyledText = styled(Text);

type LiveTrackScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'LiveTrackScreen'
>;
type LiveTrackScreenRouteProp = RouteProp<
  RootStackParamList,
  'LiveTrackScreen'
>;

type Props = {
  navigation: LiveTrackScreenNavigationProp;
  route: LiveTrackScreenRouteProp;
};

const LiveTrackScreen: React.FC<Props> = ({ navigation, route }) => {
  const bookingId = route.params?.bookingId;

  // Placeholder - Add map view, ETA, avatar animation later
  return (
    // Use standard View with twrnc style
    <View style={tw`flex-1 items-center justify-center bg-white p-4`}>
      {/* Use standard Text with twrnc style + inline color */}
      <Text style={[tw`text-xl font-semibold mb-4`, { color: colors.textMain }]}>
        Tracking Booking {bookingId} (LiveTrackScreen)
      </Text>
      {/* Use standard Text with twrnc style + inline color */}
      <Text style={[tw`mb-4`, { color: colors.textMuted }]}>Map Placeholder</Text>
      <Text style={[tw`mb-4`, { color: colors.textMuted }]}>ETA: 15 mins (Simulated)</Text>
      <Text style={[tw`mb-6`, { color: colors.textMuted }]}>Stylist Avatar Placeholder</Text>

      {/* Standard Button */}
      <Button
        title="Simulate Arrival"
        onPress={() => navigation.navigate('Bsse7aScreen', { bookingId: bookingId })}
        color={colors.primary}
      />
    </View> // Correct closing tag
  );
};

export default LiveTrackScreen;
