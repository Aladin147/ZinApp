import * as React from 'react';
import { View, Text, Button } from 'react-native';
import { styled } from 'nativewind';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '@types';
import { colors, spacing } from '@constants';

const StyledView = styled(View);
const StyledText = styled(Text);

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
    <StyledView className="flex-1 items-center justify-center bg-white p-4">
      <StyledText className="text-xl font-semibold mb-4 text-textMain">
        Tracking Booking {bookingId} (LiveTrackScreen)
      </StyledText>
      <StyledText className="mb-4 text-textMuted">Map Placeholder</StyledText>
      <StyledText className="mb-4 text-textMuted">ETA: 15 mins (Simulated)</StyledText>
      <StyledText className="mb-6 text-textMuted">Stylist Avatar Placeholder</StyledText>
      
      {/* Placeholder navigation button */}
      <Button
        title="Simulate Arrival"
        onPress={() => navigation.navigate('Bsse7aScreen', { bookingId: bookingId })}
        color={colors.primary}
      />
    </StyledView>
  );
};

export default LiveTrackScreen;
