import * as React from 'react';
import { View, Text, Button } from 'react-native';
import { styled } from 'nativewind';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '@types';
import { colors, spacing } from '@constants'; // Example import

const StyledView = styled(View);
const StyledText = styled(Text);

type LandingScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'LandingScreen'
>;

type Props = {
  navigation: LandingScreenNavigationProp;
};

const LandingScreen: React.FC<Props> = ({ navigation }) => {
  return (
    <StyledView className="flex-1 items-center justify-center bg-white p-4">
      <StyledText className="text-2xl font-bold mb-8 text-textMain">
        Welcome to ZinApp (LandingScreen)
      </StyledText>
      {/* Placeholder navigation button */}
      <Button
        title="Let's Book"
        onPress={() => navigation.navigate('ServiceSelectScreen')}
        color={colors.primary}
      />
    </StyledView>
  );
};

export default LandingScreen;
