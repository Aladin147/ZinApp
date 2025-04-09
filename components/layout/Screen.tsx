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
import tw from 'twrnc';

interface ScreenProps {
  children: React.ReactNode;
  style?: ViewStyle;
  scrollable?: boolean;
  safeArea?: boolean;
  keyboardAvoiding?: boolean;
  backgroundColor?: string;
  statusBarStyle?: 'light-content' | 'dark-content';
}

/**
 * Screen component for consistent layouts
 */
const Screen: React.FC<ScreenProps> = ({
  children,
  style,
  scrollable = false,
  safeArea = true,
  keyboardAvoiding = false,
  backgroundColor = colors.bgLight,
  statusBarStyle = 'dark-content',
}) => {
  // Base container styles
  const containerStyle = [
    tw`flex-1`,
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
          style={tw`flex-1`}
          contentContainerStyle={tw`grow`}
          showsVerticalScrollIndicator={false}
        >
          {children}
        </ScrollView>
      ) : (
        children
      )}
    </>
  );

  // Wrap in KeyboardAvoidingView if needed
  const wrappedContent = keyboardAvoiding ? (
    <KeyboardAvoidingView 
      style={tw`flex-1`} 
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
        <View style={[tw`flex-1 pt-6`, styles.statusBarPadding]}>
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
  statusBarPadding: {
    paddingTop: StatusBar.currentHeight || 0,
  },
});

export default Screen;
