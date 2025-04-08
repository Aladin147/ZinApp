import * as React from 'react';
import { View, Text, Button, ScrollView } from 'react-native';
import { styled } from 'nativewind';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '@types';
import { colors, spacing } from '@constants';

const StyledView = styled(View);
const StyledText = styled(Text);
const StyledScrollView = styled(ScrollView);

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
    <StyledScrollView className="flex-1 bg-white p-4">
      <StyledText className="text-xl font-semibold mb-4 text-textMain">
        {mockStylist.name} (BarberProfileScreen)
      </StyledText>
      <StyledText className="mb-4 text-textMuted">{mockStylist.bio}</StyledText>
      {isQrSource && (
        <StyledText className="text-sm text-blue-500 mb-4">
          (Came from QR Scan)
        </StyledText>
      )}
      {/* Placeholder for AvatarBadge, Gallery, Service List */}
      <Button
        title="Book This Stylist"
        onPress={() => navigation.navigate('BookingScreen', { stylistId: stylistId, serviceId: 1 })} // Example serviceId
        color={colors.primary}
      />
    </StyledScrollView>
  );
};

export default BarberProfileScreen;
