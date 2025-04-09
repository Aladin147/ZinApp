import React from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { Screen, Typography, Card, Logo, Button } from '../components';

type LogoShowcaseScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'LogoShowcaseScreen'
>;

type Props = {
  navigation: LogoShowcaseScreenNavigationProp;
};

/**
 * Screen to showcase all logo variants
 */
const LogoShowcaseScreen: React.FC<Props> = ({ navigation }) => {
  return (
    <Screen scrollable>
      <View style={styles.container}>
        <Typography variant="screenTitle" style={styles.title}>
          Logo Showcase
        </Typography>
        
        <Typography variant="body" style={styles.description}>
          This screen demonstrates all available logo variants and sizes.
        </Typography>
        
        {/* Normal Logo */}
        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Normal Logo
          </Typography>
          <Typography variant="caption" color={colors.textMuted} style={styles.cardSubtitle}>
            For light backgrounds
          </Typography>
          
          <View style={styles.logoContainer}>
            <Logo variant="normal" width={200} />
          </View>
        </Card>
        
        {/* Inverted Logo */}
        <Card style={styles.card} variant="elevated">
          <View style={styles.darkBackground}>
            <Typography variant="sectionHeader" style={[styles.cardTitle, styles.lightText]}>
              Inverted Logo
            </Typography>
            <Typography variant="caption" color={colors.bgLight} style={styles.cardSubtitle}>
              For dark backgrounds
            </Typography>
            
            <View style={styles.logoContainer}>
              <Logo variant="inverted" width={200} />
            </View>
          </View>
        </Card>
        
        {/* Standalone Logo */}
        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Standalone Logo
          </Typography>
          <Typography variant="caption" color={colors.textMuted} style={styles.cardSubtitle}>
            Just the icon, no text
          </Typography>
          
          <View style={styles.logoContainer}>
            <Logo variant="standalone" width={100} />
          </View>
        </Card>
        
        {/* Different Sizes */}
        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Different Sizes
          </Typography>
          
          <View style={styles.sizesContainer}>
            <View style={styles.sizeItem}>
              <Logo variant="normal" width={100} />
              <Typography variant="caption" style={styles.sizeLabel}>
                Small (100px)
              </Typography>
            </View>
            
            <View style={styles.sizeItem}>
              <Logo variant="normal" width={150} />
              <Typography variant="caption" style={styles.sizeLabel}>
                Medium (150px)
              </Typography>
            </View>
            
            <View style={styles.sizeItem}>
              <Logo variant="normal" width={200} />
              <Typography variant="caption" style={styles.sizeLabel}>
                Large (200px)
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
  logoContainer: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: spacing.md,
  },
  darkBackground: {
    backgroundColor: colors.darkSlate,
    borderRadius: 16,
    padding: spacing.md,
  },
  lightText: {
    color: colors.bgLight,
  },
  sizesContainer: {
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  sizeItem: {
    alignItems: 'center',
    marginBottom: spacing.md,
  },
  sizeLabel: {
    marginTop: spacing.xs,
  },
  button: {
    marginTop: spacing.md,
  },
});

export default LogoShowcaseScreen;
