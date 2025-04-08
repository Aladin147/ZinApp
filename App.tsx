import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { AuthProvider } from '@state/AuthContext';
import AppNavigator from '@navigation/AppNavigator';
import './global.css'; // Import NativeWind global styles

/**
 * Root component of the ZinApp application.
 * Sets up global providers (Auth, Navigation, SafeArea).
 */
export default function App() {
  return (
    <SafeAreaProvider>
      <AuthProvider>
        <AppNavigator />
        <StatusBar style="auto" />
      </AuthProvider>
    </SafeAreaProvider>
  );
}
