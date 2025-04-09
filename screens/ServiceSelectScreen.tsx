import React, { useState } from 'react';
import { View, ScrollView } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '@types';
import { colors } from '@constants';
import tw from 'twrnc';

// Import our custom components
import Screen from '@components/layout/Screen';
import Header from '@components/layout/Header';
import Typography from '@components/common/Typography';
import Button from '@components/common/Button';
import ServiceIconBtn from '@components/specific/ServiceIconBtn';

type ServiceSelectScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'ServiceSelectScreen'
>;

type Props = {
  navigation: ServiceSelectScreenNavigationProp;
};

// Mock service data
const services = [
  { id: 1, name: 'Haircut', price: 50, icon: '✂️' },
  { id: 2, name: 'Beard Trim', price: 30, icon: '🧔' },
  { id: 3, name: 'Braids', price: 70, icon: '💇' },
  { id: 4, name: 'Full Service', price: 100, icon: '💈' },
];

const ServiceSelectScreen: React.FC<Props> = ({ navigation }) => {
  const [selectedService, setSelectedService] = useState<number | null>(null);

  const handleServiceSelect = (serviceId: number) => {
    setSelectedService(serviceId);
  };

  const handleContinue = () => {
    if (selectedService) {
      navigation.navigate('StylistListScreen', { serviceId: selectedService });
    }
  };

  return (
    <Screen>
      <Header
        title="Select Service"
        showBackButton
      />

      <View style={tw`px-4 py-2`}>
        <Typography variant="subheading" style={tw`mb-6`}>
          What do you need today?
        </Typography>

        <View style={tw`flex-row flex-wrap justify-between mb-8`}>
          {services.map((service) => (
            <ServiceIconBtn
              key={service.id}
              icon={service.icon}
              label={service.name}
              price={service.price}
              selected={selectedService === service.id}
              onPress={() => handleServiceSelect(service.id)}
            />
          ))}
        </View>

        <Button
          title="Continue"
          variant="primary"
          size="large"
          style={tw`w-full mt-4`}
          disabled={!selectedService}
          onPress={handleContinue}
        />
      </View>
    </Screen>
  );
};

export default ServiceSelectScreen;
