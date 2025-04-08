import React from 'react'; // Use standard import
import { View, Text, Button } from 'react-native';
// import { styled } from 'nativewind'; // Remove NativeWind import
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '@types'; // Use path alias
import { colors, spacing } from '@constants'; // Use path alias
import tw from 'twrnc'; // Import directly from library

// Remove styled components
// const StyledView = styled(View);
// const StyledText = styled(Text);

type LandingScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'LandingScreen'
>;

type Props = {
  navigation: LandingScreenNavigationProp;
};

const LandingScreen: React.FC<Props> = ({ navigation }) => {
  return (
    // Use standard View with twrnc style
    <View style={tw`flex-1 items-center justify-center bg-white p-4`}>
      {/* Use standard Text with twrnc style */}
      {/* Combine twrnc style with inline style for custom color */}
      <Text style={[tw`text-2xl font-bold mb-8`, { color: colors.textMain }]}>
        Welcome to ZinApp (LandingScreen)
      </Text>
      {/* Standard Button, color prop is fine */}
      <Button
        title="Let's Book"
        onPress={() => navigation.navigate('ServiceSelectScreen')}
        color={colors.primary}
      />
    </View> // Correct closing tag
  );
};

export default LandingScreen;
