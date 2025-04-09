import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { View, Text } from 'react-native'; // Keep View/Text for potential future use if needed
import { AuthProvider } from '@state/AuthContext'; // Use path alias
import AppNavigator from '@navigation/AppNavigator'; // Use path alias
import tw from 'twrnc'; // Keep direct import

/**
 * Root component of the ZinApp application.
 * Sets up global providers (Auth, Navigation, SafeArea).
 */
export default function App() {
  // Restore original structure
  return (
    <SafeAreaProvider>
      <AuthProvider>
        <AppNavigator />
        <StatusBar style="auto" />
      </AuthProvider>
    </SafeAreaProvider>
  );
}
