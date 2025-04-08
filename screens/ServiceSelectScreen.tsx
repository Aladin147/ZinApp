import * as React from 'react';
import { View, Text, Button } from 'react-native';
import { styled } from 'nativewind';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '@types';
import { colors, spacing } from '@constants';

const StyledView = styled(View);
const StyledText = styled(Text);

type ServiceSelectScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'ServiceSelectScreen'
>;

type Props = {
  navigation: ServiceSelectScreenNavigationProp;
};

const ServiceSelectScreen: React.FC<Props> = ({ navigation }) => {
  return (
    <StyledView className="flex-1 items-center justify-center bg-white p-4">
      <StyledText className="text-xl font-semibold mb-6 text-textMain">
        What do you need today? (ServiceSelectScreen)
      </StyledText>
      {/* Placeholder for ServiceIconBtn components */}
      <Button
        title="Select Haircut (Navigate)" // Placeholder action
        onPress={() => navigation.navigate('StylistListScreen', { serviceId: 1 })} // Pass example serviceId
        color={colors.primary}
      />
    </StyledView>
  );
};

export default ServiceSelectScreen;
