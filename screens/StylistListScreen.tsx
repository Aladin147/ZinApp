import React, { useState, useEffect } from 'react';
import { View, FlatList, ActivityIndicator } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors } from '../constants';
import tw from 'twrnc';

// Import our custom components
import { Screen, Header, Typography, BarberCard } from '../components';

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

// Mock stylist data
const mockStylists = [
  {
    id: 1,
    name: 'Hassan the Barber',
    rating: 4.9,
    distance_km: 2.1,
    verified: true,
    profile_picture: 'https://randomuser.me/api/portraits/men/32.jpg'
  },
  {
    id: 2,
    name: 'Yasin Styles',
    rating: 4.7,
    distance_km: 3.4,
    verified: false,
    profile_picture: 'https://randomuser.me/api/portraits/men/44.jpg'
  },
  {
    id: 3,
    name: 'Fatima Braids',
    rating: 4.8,
    distance_km: 1.8,
    verified: true,
    profile_picture: 'https://randomuser.me/api/portraits/women/65.jpg'
  },
];

const StylistListScreen: React.FC<Props> = ({ navigation, route }) => {
  const serviceId = route.params?.serviceId;
  const [loading, setLoading] = useState(true);
  const [stylists, setStylists] = useState<typeof mockStylists>([]);

  // Simulate API call
  useEffect(() => {
    // Simulate network delay
    const timer = setTimeout(() => {
      setStylists(mockStylists);
      setLoading(false);
    }, 1000);

    return () => clearTimeout(timer);
  }, []);

  const handleStylistSelect = (stylistId: number) => {
    navigation.navigate('BarberProfileScreen', { stylistId });
  };

  return (
    <Screen>
      <Header
        title={`Available Stylists${serviceId ? ` for Service ${serviceId}` : ''}`}
        showBackButton
      />

      <View style={tw`px-4 flex-1`}>
        {loading ? (
          <View style={tw`flex-1 items-center justify-center`}>
            <ActivityIndicator size="large" color={colors.primary} />
            <Typography variant="caption" style={tw`mt-2`}>
              Finding stylists near you...
            </Typography>
          </View>
        ) : (
          <>
            <Typography variant="body" style={tw`mb-4`}>
              {stylists.length} stylists available in your area
            </Typography>

            <FlatList
              data={stylists}
              keyExtractor={(item) => item.id.toString()}
              renderItem={({ item }) => (
                <BarberCard
                  id={item.id}
                  name={item.name}
                  rating={item.rating}
                  distance_km={item.distance_km}
                  verified={item.verified}
                  profile_picture={item.profile_picture}
                  onPress={handleStylistSelect}
                />
              )}
              showsVerticalScrollIndicator={false}
              contentContainerStyle={tw`pb-4`}
            />
          </>
        )}
      </View>
    </Screen>
  );
};

export default StylistListScreen;
