import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import { NavigationContainer } from '@react-navigation/native';
import { RootStackParamList } from '../types';

// Import actual screens
import LandingScreen from '../screens/LandingScreen';
import ServiceSelectScreen from '../screens/ServiceSelectScreen';
import StylistListScreen from '../screens/StylistListScreen';
import BarberProfileScreen from '../screens/BarberProfileScreen';
import BookingScreen from '../screens/BookingScreen';
import LiveTrackScreen from '../screens/LiveTrackScreen';
import Bsse7aScreen from '../screens/Bsse7aScreen';



// Create the stack navigator
const Stack = createStackNavigator<RootStackParamList>();

/**
 * Main app navigation stack
 * Implements the user flow defined in FEATURE_FLOW.md
 */
const AppNavigator = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator
        initialRouteName="LandingScreen"
        screenOptions={{
          headerShown: false,
          cardStyle: { backgroundColor: '#FFFFFF' },
          cardOverlayEnabled: true,
          // Customize transitions based on ANIMATION_INTERACTION_SYSTEM.md
          cardStyleInterpolator: ({ current }) => ({
            cardStyle: {
              opacity: current.progress,
            },
          }),
        }}
      >
        <Stack.Screen
          name="LandingScreen"
          component={LandingScreen}
        />
        <Stack.Screen
          name="ServiceSelectScreen"
          component={ServiceSelectScreen}
        />
        <Stack.Screen
          name="StylistListScreen"
          component={StylistListScreen}
        />
        <Stack.Screen
          name="BarberProfileScreen"
          component={BarberProfileScreen}
        />
        <Stack.Screen
          name="BookingScreen"
          component={BookingScreen}
        />
        <Stack.Screen
          name="LiveTrackScreen"
          component={LiveTrackScreen}
        />
        <Stack.Screen
          name="Bsse7aScreen"
          component={Bsse7aScreen}
        />

      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default AppNavigator;
