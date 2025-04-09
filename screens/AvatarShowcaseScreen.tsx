import React from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { Screen, Typography, Card, Avatar, Button } from '../components';

type AvatarShowcaseScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'AvatarShowcaseScreen'
>;

type Props = {
  navigation: AvatarShowcaseScreenNavigationProp;
};

/**
 * Screen to showcase the Avatar component
 */
const AvatarShowcaseScreen: React.FC<Props> = ({ navigation }) => {
  // Placeholder image for development
  const placeholderImage = { uri: 'https://via.placeholder.com/100' };
  
  return (
    <Screen scrollable>
      <View style={styles.container}>
        <Typography variant="screenTitle" style={styles.title}>
          Avatar Component
        </Typography>
        
        <Typography variant="body" style={styles.description}>
          This screen demonstrates the Avatar component with different sizes and variants.
        </Typography>
        
        {/* Size Variants */}
        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Size Variants
          </Typography>
          <Typography variant="caption" color={colors.textMuted} style={styles.cardSubtitle}>
            Small, Medium, and Large
          </Typography>
          
          <View style={styles.rowContainer}>
            <View style={styles.avatarContainer}>
              <Avatar source={placeholderImage} size="small" />
              <Typography variant="caption" style={styles.label}>
                Small
              </Typography>
            </View>
            
            <View style={styles.avatarContainer}>
              <Avatar source={placeholderImage} size="medium" />
              <Typography variant="caption" style={styles.label}>
                Medium
              </Typography>
            </View>
            
            <View style={styles.avatarContainer}>
              <Avatar source={placeholderImage} size="large" />
              <Typography variant="caption" style={styles.label}>
                Large
              </Typography>
            </View>
          </View>
        </Card>
        
        {/* Verification Badge */}
        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Verification Badge
          </Typography>
          <Typography variant="caption" color={colors.textMuted} style={styles.cardSubtitle}>
            With and without verification
          </Typography>
          
          <View style={styles.rowContainer}>
            <View style={styles.avatarContainer}>
              <Avatar source={placeholderImage} size="medium" verified={false} />
              <Typography variant="caption" style={styles.label}>
                Not Verified
              </Typography>
            </View>
            
            <View style={styles.avatarContainer}>
              <Avatar source={placeholderImage} size="medium" verified={true} />
              <Typography variant="caption" style={styles.label}>
                Verified
              </Typography>
            </View>
          </View>
        </Card>
        
        {/* Custom Styling */}
        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Custom Styling
          </Typography>
          <Typography variant="caption" color={colors.textMuted} style={styles.cardSubtitle}>
            With custom border and background colors
          </Typography>
          
          <View style={styles.rowContainer}>
            <View style={styles.avatarContainer}>
              <Avatar 
                source={placeholderImage} 
                size="medium" 
                borderColor={colors.primary}
              />
              <Typography variant="caption" style={styles.label}>
                Primary Border
              </Typography>
            </View>
            
            <View style={styles.avatarContainer}>
              <Avatar 
                source={placeholderImage} 
                size="medium" 
                backgroundColor={colors.warmSand}
              />
              <Typography variant="caption" style={styles.label}>
                Warm Background
              </Typography>
            </View>
            
            <View style={styles.avatarContainer}>
              <Avatar 
                source={placeholderImage} 
                size="medium" 
                verified={true}
                borderColor={colors.accent}
              />
              <Typography variant="caption" style={styles.label}>
                Accent Border
              </Typography>
            </View>
          </View>
        </Card>
        
        <Button
          title="Back to Home"
          variant="primary"
          onPress={() => navigation.goBack()}
          style={styles.button}
        />
      </View>
    </Screen>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: spacing.md,
  },
  title: {
    marginBottom: spacing.sm,
  },
  description: {
    marginBottom: spacing.lg,
  },
  card: {
    marginBottom: spacing.md,
  },
  cardTitle: {
    marginBottom: spacing.xxs,
  },
  cardSubtitle: {
    marginBottom: spacing.md,
  },
  rowContainer: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
    flexWrap: 'wrap',
  },
  avatarContainer: {
    alignItems: 'center',
    marginBottom: spacing.md,
    marginHorizontal: spacing.sm,
  },
  label: {
    marginTop: spacing.xs,
  },
  button: {
    marginTop: spacing.md,
  },
});

export default AvatarShowcaseScreen;
