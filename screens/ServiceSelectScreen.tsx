import React from 'react'; // Use standard import
import { View, Text, Button } from 'react-native';
// import { styled } from 'nativewind'; // Remove NativeWind import
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types'; // Use relative path for now
import { colors, spacing } from '../constants'; // Use relative path for now
import tw from '../twrnc'; // Import twrnc

// Remove styled components
// const StyledView = styled(View);
// const StyledText = styled(Text);

type ServiceSelectScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'ServiceSelectScreen'
>;

type Props = {
  navigation: ServiceSelectScreenNavigationProp;
};

const ServiceSelectScreen: React.FC<Props> = ({ navigation }) => {
  return (
    // Use standard View with twrnc style
    <View style={tw`flex-1 items-center justify-center bg-white p-4`}>
      {/* Use standard Text with twrnc style */}
      <Text style={[tw`text-xl font-semibold mb-6`, { color: colors.textMain }]}>
        What do you need today? (ServiceSelectScreen)
      </Text>
      {/* Placeholder for ServiceIconBtn components */}
      {/* Standard Button, color prop is fine */}
      <Button
        title="Select Haircut (Navigate)" // Placeholder action
        onPress={() => navigation.navigate('StylistListScreen', { serviceId: 1 })} // Pass example serviceId
        color={colors.primary}
      />
    </View> // Correct closing tag
  );
};

export default ServiceSelectScreen;
