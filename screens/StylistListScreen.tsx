import React, { useState, useEffect } from 'react';
import { View, FlatList, ActivityIndicator } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import { colors } from '../constants';
import tw from 'twrnc';
import { MotiView } from 'moti';

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
      <MotiView
        from={{ opacity: 0, translateY: -10 }}
        animate={{ opacity: 1, translateY: 0 }}
        transition={{ type: 'timing', duration: 500 }}
      >
        <Header
          title={`Available Stylists${serviceId ? ` for Service ${serviceId}` : ''}`}
          showBackButton
        />
      </MotiView>

      <View style={tw`px-4 flex-1`}>
        {loading ? (
          <MotiView
            from={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ type: 'spring', damping: 15 }}
            style={tw`flex-1 items-center justify-center`}
          >
            <ActivityIndicator size="large" color={colors.primary} />
            <Typography variant="caption" style={tw`mt-2`}>
              Finding stylists near you...
            </Typography>
          </MotiView>
        ) : (
          <>
            <MotiView
              from={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ type: 'timing', duration: 500 }}
            >
              <Typography variant="body" style={tw`mb-4`}>
                {stylists.length} stylists available in your area
              </Typography>
            </MotiView>

            <FlatList
              data={stylists}
              keyExtractor={(item) => item.id.toString()}
              renderItem={({ item, index }) => (
                <MotiView
                  from={{ opacity: 0, translateY: 20 }}
                  animate={{ opacity: 1, translateY: 0 }}
                  transition={{ type: 'timing', duration: 500, delay: 100 + (index * 100) }}
                >
                  <BarberCard
                    id={item.id}
                    name={item.name}
                    rating={item.rating}
                    distance_km={item.distance_km}
                    verified={item.verified}
                    profile_picture={item.profile_picture}
                    onPress={handleStylistSelect}
                  />
                </MotiView>
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
