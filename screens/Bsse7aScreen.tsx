import React from 'react'; // Use standard import
import { View, Text, Button } from 'react-native';
// import { styled } from 'nativewind'; // Remove NativeWind import
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '@types'; // Use path alias
import { colors, spacing } from '@constants'; // Use path alias
import tw from 'twrnc'; // Import directly from library

// Remove styled components
// const StyledView = styled(View);
// const StyledText = styled(Text);

type Bsse7aScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'Bsse7aScreen'
>;
type Bsse7aScreenRouteProp = RouteProp<RootStackParamList, 'Bsse7aScreen'>;

type Props = {
  navigation: Bsse7aScreenNavigationProp;
  route: Bsse7aScreenRouteProp;
};

const Bsse7aScreen: React.FC<Props> = ({ navigation, route }) => {
  const bookingId = route.params?.bookingId;

  // Placeholder - Add confetti, avatar, summary, tip buttons, rating stars later
  return (
    // Use standard View with twrnc style
    <View style={tw`flex-1 items-center justify-center bg-white p-4`}>
      {/* Use standard Text with twrnc style + inline color */}
      <Text style={[tw`text-2xl font-bold mb-4`, { color: colors.textMain }]}>
        Bse7a! (Bsse7aScreen)
      </Text>
      {/* Use standard Text with twrnc style + inline color */}
      <Text style={[tw`mb-4`, { color: colors.textMuted }]}>Booking {bookingId} Complete</Text>
      <Text style={[tw`mb-2`, { color: colors.textMuted }]}>Tip Placeholder</Text>
      <Text style={[tw`mb-6`, { color: colors.textMuted }]}>Rating Placeholder</Text>

      {/* Standard Button */}
      <Button
        title="Done (Back to Service Select)"
        onPress={() => navigation.navigate('ServiceSelectScreen')} // Or pop to top/reset stack
        color={colors.primary}
      />
    </View> // Correct closing tag
  );
};

export default Bsse7aScreen;
