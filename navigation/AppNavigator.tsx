import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import { NavigationContainer } from '@react-navigation/native';
import { RootStackParamList } from '../types';
import {
  slideUpWithFade,
  revealFromCenter,
  slideFromRightWithBounce,
  fadeWithZoom,
  celebrationTransition,
  mapFocusedTransition,
  bookingTransition
} from './transitions';

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
          // Use our custom slide animation as default
          cardStyleInterpolator: slideFromRightWithBounce,
          gestureEnabled: true,
          gestureDirection: 'horizontal',
          // Add shared transition options for all screens
          transitionSpec: {
            open: {
              animation: 'spring',
              config: {
                stiffness: 1000,
                damping: 500,
                mass: 3,
                overshootClamping: true,
                restDisplacementThreshold: 0.01,
                restSpeedThreshold: 0.01,
              },
            },
            close: {
              animation: 'spring',
              config: {
                stiffness: 1000,
                damping: 500,
                mass: 3,
                overshootClamping: true,
                restDisplacementThreshold: 0.01,
                restSpeedThreshold: 0.01,
              },
            },
          },
        }}
      >
        <Stack.Screen
          name="LandingScreen"
          component={LandingScreen}
          options={{
            cardStyleInterpolator: fadeWithZoom,
          }}
        />
        <Stack.Screen
          name="ServiceSelectScreen"
          component={ServiceSelectScreen}
          options={{
            cardStyleInterpolator: slideUpWithFade,
          }}
        />
        <Stack.Screen
          name="StylistListScreen"
          component={StylistListScreen}
          options={{
            cardStyleInterpolator: slideFromRightWithBounce,
          }}
        />
        <Stack.Screen
          name="BarberProfileScreen"
          component={BarberProfileScreen}
          options={{
            cardStyleInterpolator: revealFromCenter,
          }}
        />
        <Stack.Screen
          name="BookingScreen"
          component={BookingScreen}
          options={{
            cardStyleInterpolator: bookingTransition,
          }}
        />
        <Stack.Screen
          name="LiveTrackScreen"
          component={LiveTrackScreen}
          options={{
            cardStyleInterpolator: mapFocusedTransition,
          }}
        />
        <Stack.Screen
          name="Bsse7aScreen"
          component={Bsse7aScreen}
          options={{
            cardStyleInterpolator: celebrationTransition,
          }}
        />

      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default AppNavigator;
