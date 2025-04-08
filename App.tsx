import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { View, Text } from 'react-native';
import { AuthProvider } from './state/AuthContext'; // Use relative import for now
import AppNavigator from './navigation/AppNavigator'; // Use relative import for now
import tw from 'twrnc'; // Import directly from the library

/**
 * Root component of the ZinApp application.
 * Sets up global providers (Auth, Navigation, SafeArea).
 */
export default function App() {
  return (
    // Test twrnc with a simple style
    <SafeAreaProvider style={tw`bg-white`}>
      {/* Add a test view to verify twrnc is working */}
      <View style={tw`p-4 m-2 bg-gray-100 rounded-md`}>
        <Text>Minimal twrnc test</Text>
      </View>
      
      <AuthProvider>
        <AppNavigator />
        <StatusBar style="auto" />
      </AuthProvider>
    </SafeAreaProvider>
  );
}
