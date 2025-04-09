import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { View, Text } from 'react-native';
import { AuthProvider } from '@state/AuthContext';
import AppNavigator from '@navigation/AppNavigator';
import tw from 'twrnc';

/**
 * Root component of the ZinApp application.
 *
 * TEMPORARY SANITY TEST:
 * This version includes a simple render test to verify that the basic styling and
 * rendering pipeline is working correctly. Once confirmed, we'll restore the full navigation.
 */
export default function App() {
  // Sanity test passed! Restoring full navigation
  const useSanityTest = false; // Sanity test passed, full navigation restored

  if (useSanityTest) {
    return (
      <View style={tw`flex-1 bg-white items-center justify-center`}>
        <Text style={tw`text-lg text-black`}>ZinApp is alive ✅</Text>
        <StatusBar style="auto" />
      </View>
    );
  }

  // Original structure - will be restored after sanity test passes
  return (
    <SafeAreaProvider>
      <AuthProvider>
        <AppNavigator />
        <StatusBar style="auto" />
      </AuthProvider>
    </SafeAreaProvider>
  );
}
