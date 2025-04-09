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
import { colors } from '@constants';

interface ScreenProps {
  children: React.ReactNode;
  style?: ViewStyle;
  scrollable?: boolean;
  safeArea?: boolean;
  keyboardAvoiding?: boolean;
  backgroundColor?: string;
  statusBarStyle?: 'light-content' | 'dark-content';
  contentPadding?: number;
}

/**
 * Screen component for consistent layouts
 *
 * Based on the specifications in the design documentation:
 * - 4pt spacing grid
 * - 16px margin baseline
 * - 24px header padding for vertical scroll sections
 */
const Screen: React.FC<ScreenProps> = ({
  children,
  style,
  scrollable = false,
  safeArea = true,
  keyboardAvoiding = false,
  backgroundColor = colors.bgLight,
  statusBarStyle = 'dark-content',
  contentPadding = 16, // Default to 16px margin baseline from design specs
}) => {
  // Base container styles
  const containerStyle = [
    styles.container,
    { backgroundColor },
    style,
  ];

  // Content to render
  const content = (
    <>
      <StatusBar
        barStyle={statusBarStyle}
        backgroundColor="transparent"
        translucent
      />
      {scrollable ? (
        <ScrollView
          style={styles.scrollView}
          contentContainerStyle={{
            flexGrow: 1,
            padding: contentPadding,
            paddingTop: scrollable ? 24 : contentPadding, // 24px header padding for scroll sections
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
        <View style={[styles.flexOne, styles.statusBarPadding]}>
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
  },
  flexOne: {
    flex: 1,
  },
  scrollView: {
    flex: 1,
  },
  statusBarPadding: {
    paddingTop: StatusBar.currentHeight || 0,
  },
});

export default Screen;
