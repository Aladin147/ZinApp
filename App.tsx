import React, { useState, useEffect, useCallback } from 'react';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { View, StyleSheet, TouchableOpacity } from 'react-native';
import { AuthProvider } from '@state/AuthContext';
import AppNavigator from '@navigation/AppNavigator';
import * as SplashScreen from 'expo-splash-screen';
import * as Font from 'expo-font';
import { colors } from './constants';
import { Typography } from './components';

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
  sanityContainer: {
    flex: 1,
    backgroundColor: colors.bgLight,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
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
  backButton: {
    marginTop: 20,
    backgroundColor: colors.primary,
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 12,
    alignItems: 'center',
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
        style={styles.sanityContainer}
        onLayout={onLayoutRootView}
      >
        <Typography variant="screenTitle" align="center" style={{ marginBottom: 8 }}>
          ZinApp is alive ✅
        </Typography>

        <Typography variant="body" align="center" color={colors.textMuted} style={{ marginBottom: 20 }}>
          Fonts loaded successfully
        </Typography>

        <TouchableOpacity
          style={styles.backButton}
          onPress={() => setUseSanityTest(false)}
        >
          <Typography variant="button" color={colors.bgLight}>
            Back to App
          </Typography>
        </TouchableOpacity>

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
          <TouchableOpacity
            style={styles.debugButton}
            onPress={() => setUseSanityTest(true)}
          >
            <Typography variant="caption" color={colors.textPrimary}>
              Debug
            </Typography>
          </TouchableOpacity>
        </AuthProvider>
      </View>
    </SafeAreaProvider>
  );
}
