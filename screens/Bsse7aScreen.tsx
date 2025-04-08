import * as React from 'react';
import { View, Text, Button } from 'react-native';
import { styled } from 'nativewind';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '@types';
import { colors, spacing } from '@constants';

const StyledView = styled(View);
const StyledText = styled(Text);

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
    <StyledView className="flex-1 items-center justify-center bg-white p-4">
      <StyledText className="text-2xl font-bold mb-4 text-textMain">
        Bse7a! (Bsse7aScreen)
      </StyledText>
      <StyledText className="mb-4 text-textMuted">Booking {bookingId} Complete</StyledText>
      <StyledText className="mb-2 text-textMuted">Tip Placeholder</StyledText>
      <StyledText className="mb-6 text-textMuted">Rating Placeholder</StyledText>

      {/* Placeholder navigation button */}
      <Button
        title="Done (Back to Service Select)"
        onPress={() => navigation.navigate('ServiceSelectScreen')} // Or pop to top/reset stack
        color={colors.primary}
      />
    </StyledView>
  );
};

export default Bsse7aScreen;
