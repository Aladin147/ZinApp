import * as React from 'react';
import { View, Text, Button, FlatList } from 'react-native';
import { styled } from 'nativewind';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '@types';
import { colors, spacing } from '@constants';

const StyledView = styled(View);
const StyledText = styled(Text);

type StylistListScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'StylistListScreen'
>;
type StylistListScreenRouteProp = RouteProp<
  RootStackParamList,
  'StylistListScreen'
>;

type Props = {
  navigation: StylistListScreenNavigationProp;
  route: StylistListScreenRouteProp;
};

const StylistListScreen: React.FC<Props> = ({ navigation, route }) => {
  const serviceId = route.params?.serviceId;

  // Placeholder data - replace with API call later
  const mockStylists = [
    { id: 1, name: 'Hassan' },
    { id: 2, name: 'Yasin' },
  ];

  return (
    <StyledView className="flex-1 bg-white p-4">
      <StyledText className="text-xl font-semibold mb-4 text-textMain">
        Available Stylists {serviceId ? `for Service ${serviceId}` : ''} (StylistListScreen)
      </StyledText>
      {/* Placeholder for BarberCard components */}
      <FlatList
        data={mockStylists}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <StyledView className="mb-2 p-3 border border-gray-200 rounded">
            <StyledText>{item.name}</StyledText>
            <Button 
              title="View Profile" 
              onPress={() => navigation.navigate('BarberProfileScreen', { stylistId: item.id })}
              color={colors.primary}
            />
          </StyledView>
        )}
      />
    </StyledView>
  );
};

export default StylistListScreen;
