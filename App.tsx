import React, { useState, useEffect, useCallback } from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { View, Text, StyleSheet } from 'react-native';
import { AuthProvider } from '@state/AuthContext';
import AppNavigator from '@navigation/AppNavigator';
import tw from 'twrnc';
import * as SplashScreen from 'expo-splash-screen';
import * as Font from 'expo-font';
import { colors } from './constants';

// Keep the splash screen visible while we fetch resources
SplashScreen.preventAutoHideAsync();

/**
 * Root component of the ZinApp application.
 *
 * TEMPORARY SANITY TEST:
 * This version includes a simple render test to verify that the basic styling and
 * rendering pipeline is working correctly. Once confirmed, we'll restore the full navigation.
 */
// Define styles for the app
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.bgLight,
  },
  title: {
    fontFamily: 'Inter-Bold',
    fontSize: 24,
    lineHeight: 32,
    textAlign: 'center',
    marginVertical: 20,
    color: colors.textMain,
  },
  subtitle: {
    fontFamily: 'Inter',
    fontSize: 14,
    lineHeight: 20,
    textAlign: 'center',
    marginBottom: 20,
    color: colors.textMuted,
  },
  debugButton: {
    position: 'absolute',
    top: 40,
    right: 16,
    backgroundColor: 'rgba(0,0,0,0.1)',
    padding: 8,
    borderRadius: 4,
    zIndex: 999,
  },
  debugText: {
    fontFamily: 'Inter',
    fontSize: 12,
    color: colors.textMain,
  },
  backButton: {
    marginTop: 20,
    backgroundColor: colors.primary,
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 12,
  },
  backButtonText: {
    fontFamily: 'Inter-Medium',
    fontSize: 16,
    color: 'white',
  },
});

export default function App() {
  // State for font loading and sanity test
  const [appIsReady, setAppIsReady] = useState(false);
  const [useSanityTest, setUseSanityTest] = useState(false);

  // Load fonts and other resources
  useEffect(() => {
    async function prepare() {
      try {
        // Pre-load fonts
        await Font.loadAsync({
          'Inter': require('./assets/fonts/Inter-Regular.ttf'),
          'Inter-Medium': require('./assets/fonts/Inter-Medium.ttf'),
          'Inter-SemiBold': require('./assets/fonts/Inter-SemiBold.ttf'),
          'Inter-Bold': require('./assets/fonts/Inter-Bold.ttf'),
        });
        console.log('Fonts loaded successfully');
      } catch (e) {
        console.warn('Error loading assets:', e);
      } finally {
        // Tell the application to render
        setAppIsReady(true);
      }
    }

    prepare();
  }, []);

  // Handle layout effect to hide splash screen
  const onLayoutRootView = useCallback(async () => {
    if (appIsReady) {
      // This tells the splash screen to hide immediately
      await SplashScreen.hideAsync();
    }
  }, [appIsReady]);

  // Show nothing while loading fonts
  if (!appIsReady) {
    return null;
  }

  // Sanity test component
  if (useSanityTest) {
    return (
      <View
        style={[tw`flex-1 bg-white items-center justify-center`, styles.container]}
        onLayout={onLayoutRootView}
      >
        <Text style={styles.title}>ZinApp is alive ✅</Text>
        <Text style={styles.subtitle}>Fonts loaded successfully</Text>
        <View style={styles.backButton}>
          <Text
            style={styles.backButtonText}
            onPress={() => setUseSanityTest(false)}
          >
            Back to App
          </Text>
        </View>
        <StatusBar style="auto" />
      </View>
    );
  }

  // Main app with navigation
  return (
    <SafeAreaProvider>
      <View style={styles.container} onLayout={onLayoutRootView}>
        <AuthProvider>
          <AppNavigator />
          <StatusBar style="auto" />
          {/* Debug button to toggle sanity test */}
          <View style={styles.debugButton}>
            <Text
              style={styles.debugText}
              onPress={() => setUseSanityTest(true)}
            >
              Debug
            </Text>
          </View>
        </AuthProvider>
      </View>
    </SafeAreaProvider>
  );
}
