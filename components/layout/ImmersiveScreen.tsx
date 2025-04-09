import React from 'react';
import {
  View,
  SafeAreaView,
  StatusBar,
  StyleSheet,
  ViewStyle,
  ScrollView,
  KeyboardAvoidingView,
  Platform
} from 'react-native';
import { colors, spacing } from '@constants';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

interface ImmersiveScreenProps {
  children: React.ReactNode;
  style?: ViewStyle;
  scrollable?: boolean;
  safeArea?: boolean;
  keyboardAvoiding?: boolean;
  backgroundColor?: string;
  statusBarStyle?: 'light-content' | 'dark-content';
  contentPadding?: number;
  withDots?: boolean;
}

/**
 * ImmersiveScreen component for playful, full-color layouts
 *
 * This component extends the standard Screen component with:
 * - Full-color background (default: coral primary)
 * - Decorative dots for visual interest
 * - Reduced padding for more immersive feel
 * - Light status bar for dark backgrounds
 */
const ImmersiveScreen: React.FC<ImmersiveScreenProps> = ({
  children,
  style,
  scrollable = false,
  safeArea = true,
  keyboardAvoiding = false,
  backgroundColor = colors.primary,
  statusBarStyle = 'light-content',
  contentPadding = 16,
  withDots = true,
}) => {
  const insets = useSafeAreaInsets();

  // Base container styles
  const containerStyle = [
    styles.container,
    { backgroundColor },
    style,
  ];

  // Decorative elements for visual interest
  const renderDecorations = () => {
    if (!withDots) return null;

    return (
      <>
        {/* Small dots */}
        <View style={[styles.dot, styles.dot1]} />
        <View style={[styles.dot, styles.dot2]} />
        <View style={[styles.dot, styles.dot3]} />
        <View style={[styles.dot, styles.dot4]} />
        <View style={[styles.dot, styles.dot5]} />
        <View style={[styles.dot, styles.dot6]} />
        <View style={[styles.dot, styles.dot7]} />
        <View style={[styles.dot, styles.dot8]} />

        {/* Larger decorative circles */}
        <View style={[styles.circle, styles.circle1]} />
        <View style={[styles.circle, styles.circle2]} />
        <View style={[styles.circle, styles.circle3]} />
      </>
    );
  };

  // Content to render
  const content = (
    <>
      <StatusBar
        barStyle={statusBarStyle}
        backgroundColor="transparent"
        translucent
      />
      {renderDecorations()}
      {scrollable ? (
        <ScrollView
          style={styles.scrollView}
          contentContainerStyle={{
            flexGrow: 1,
            padding: contentPadding,
            paddingTop: scrollable ? 24 : contentPadding,
          }}
          showsVerticalScrollIndicator={false}
        >
          {children}
        </ScrollView>
      ) : (
        <View style={{ flex: 1, padding: contentPadding }}>
          {children}
        </View>
      )}
    </>
  );

  // Wrap in KeyboardAvoidingView if needed
  const wrappedContent = keyboardAvoiding ? (
    <KeyboardAvoidingView
      style={styles.flexOne}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      {content}
    </KeyboardAvoidingView>
  ) : (
    content
  );

  // Wrap in SafeAreaView if needed
  if (safeArea) {
    return (
      <SafeAreaView style={containerStyle}>
        <View style={[styles.flexOne, { paddingTop: insets.top }]}>
          {wrappedContent}
        </View>
      </SafeAreaView>
    );
  }

  return (
    <View style={containerStyle}>
      {wrappedContent}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    position: 'relative',
    overflow: 'hidden', // Ensure decorations don't overflow
  },
  flexOne: {
    flex: 1,
  },
  scrollView: {
    flex: 1,
  },
  // Small decorative dots
  dot: {
    position: 'absolute',
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: 'rgba(255, 255, 255, 0.3)',
  },
  dot1: {
    top: '10%',
    left: '15%',
  },
  dot2: {
    top: '25%',
    right: '10%',
  },
  dot3: {
    bottom: '30%',
    left: '8%',
  },
  dot4: {
    bottom: '15%',
    right: '20%',
  },
  dot5: {
    top: '50%',
    left: '50%',
  },
  dot6: {
    top: '70%',
    right: '25%',
  },
  dot7: {
    top: '35%',
    left: '30%',
  },
  dot8: {
    bottom: '40%',
    right: '35%',
  },
  // Larger decorative circles
  circle: {
    position: 'absolute',
    borderWidth: 1,
    borderColor: 'rgba(255, 255, 255, 0.15)',
    backgroundColor: 'transparent',
  },
  circle1: {
    width: 120,
    height: 120,
    borderRadius: 60,
    top: -30,
    right: -30,
  },
  circle2: {
    width: 180,
    height: 180,
    borderRadius: 90,
    bottom: -50,
    left: -50,
  },
  circle3: {
    width: 100,
    height: 100,
    borderRadius: 50,
    top: '40%',
    right: -30,
  },
});

export default ImmersiveScreen;
