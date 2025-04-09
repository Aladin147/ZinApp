import React from 'react';
import { View, Text } from 'react-native';
import tw from 'twrnc';

/**
 * Debug screen for testing rendering and twrnc functionality
 * This screen can be used to verify that the basic styling and rendering pipeline is working
 */
export default function DebugScreen() {
  return (
    <View style={tw`bg-yellow-100 flex-1 items-center justify-center`}>
      <Text style={tw`text-lg text-black`}>ZinApp is rendering correctly ✅</Text>
    </View>
  );
}
