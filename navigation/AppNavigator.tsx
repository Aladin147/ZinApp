import React from 'react';
import { createStackNavigator, CardStyleInterpolators } from '@react-navigation/stack'; // Import interpolators
import { NavigationContainer } from '@react-navigation/native';
import { RootStackParamList } from '@types'; // Use alias

// Import actual screens
import LandingScreen from '@screens/LandingScreen'; // Use alias
import ServiceSelectScreen from '@screens/ServiceSelectScreen'; // Use alias
import StylistListScreen from '@screens/StylistListScreen'; // Use alias
import BarberProfileScreen from '@screens/BarberProfileScreen'; // Use alias
import BookingScreen from '@screens/BookingScreen'; // Use alias
import LiveTrackScreen from '@screens/LiveTrackScreen'; // Use alias
import Bsse7aScreen from '@screens/Bsse7aScreen'; // Use alias



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
          // Use a standard slide-from-right animation as default
          // Specific screens can override this if needed
          cardStyleInterpolator: CardStyleInterpolators.forHorizontalIOS,
          gestureEnabled: true,
          gestureDirection: 'horizontal',
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
          // Example: Override transition for specific screen if needed
          // options={{ cardStyleInterpolator: CardStyleInterpolators.forVerticalIOS }}
        />
        <Stack.Screen
          name="LiveTrackScreen"
          component={LiveTrackScreen}
          options={{ cardStyleInterpolator: CardStyleInterpolators.forFadeFromBottomAndroid }} // Example fade
        />
        <Stack.Screen
          name="Bsse7aScreen"
          component={Bsse7aScreen}
          options={{ cardStyleInterpolator: CardStyleInterpolators.forScaleFromCenterAndroid }} // Example scale
        />

      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default AppNavigator;
