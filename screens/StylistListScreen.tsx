import React from 'react'; // Use standard import
import { View, Text, Button, FlatList } from 'react-native';
// import { styled } from 'nativewind'; // Remove NativeWind import
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types'; // Use relative path for now
import { colors, spacing } from '../constants'; // Use relative path for now
import tw from '../twrnc'; // Import twrnc

// Remove styled components
// const StyledView = styled(View);
// const StyledText = styled(Text);

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
    // Use standard View with twrnc style
    <View style={tw`flex-1 bg-white p-4`}>
      {/* Use standard Text with twrnc style + inline color */}
      <Text style={[tw`text-xl font-semibold mb-4`, { color: colors.textMain }]}>
        Available Stylists {serviceId ? `for Service ${serviceId}` : ''} (StylistListScreen)
      </Text>
      {/* Placeholder for BarberCard components */}
      {/* Standard FlatList */}
      <FlatList
        data={mockStylists}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          // Use standard View with twrnc style
          <View style={tw`mb-2 p-3 border border-gray-200 rounded`}>
            {/* Use standard Text */}
            <Text>{item.name}</Text>
            {/* Standard Button */}
            <Button
              title="View Profile"
              onPress={() => navigation.navigate('BarberProfileScreen', { stylistId: item.id })}
              color={colors.primary}
            />
          </View>
        )}
      />
    </View> // Correct closing tag
  );
};

export default StylistListScreen;
