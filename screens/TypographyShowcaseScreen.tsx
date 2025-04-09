import React from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types';
import { colors, spacing, typography } from '../constants';
import { Screen, Typography, Button, Card } from '../components';

type TypographyShowcaseScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'TypographyShowcaseScreen'
>;

type Props = {
  navigation: TypographyShowcaseScreenNavigationProp;
};

/**
 * Screen to showcase the Typography component and all its variants
 */
const TypographyShowcaseScreen: React.FC<Props> = ({ navigation }) => {
  // Get all typography variants
  const variants = Object.keys(typography.variants) as Array<keyof typeof typography.variants>;
  
  return (
    <Screen>
      <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
        <Typography variant="screenTitle" style={styles.title}>
          Typography System
        </Typography>
        
        <Typography variant="body" style={styles.description}>
          This screen demonstrates all typography variants available in the ZinApp design system.
          Each variant has specific font properties like size, weight, and line height.
        </Typography>
        
        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Font Family
          </Typography>
          
          <Typography variant="body" style={styles.fontInfo}>
            Primary: Inter (fallback for Uber Move)
          </Typography>
          
          <View style={styles.divider} />
          
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            All Typography Variants
          </Typography>
          
          {variants.map((variant) => (
            <View key={variant} style={styles.variantContainer}>
              <View style={styles.variantHeader}>
                <Typography variant="bodyBold" color={colors.primary}>
                  {variant}
                </Typography>
                
                <Typography variant="caption" style={styles.variantDetails}>
                  {typography.variants[variant].fontSize}px • 
                  {variant.includes('Bold') || variant === 'screenTitle' || variant === 'heading' || variant === 'sectionHeader' || variant === 'subheading' 
                    ? ' Bold' 
                    : variant.includes('Medium') 
                      ? ' Medium' 
                      : ' Regular'} • 
                  {typography.variants[variant].lineHeight}px line height
                </Typography>
              </View>
              
              <Typography variant={variant} style={styles.variantSample}>
                The quick brown fox jumps over the lazy dog
              </Typography>
              
              <View style={styles.separator} />
            </View>
          ))}
        </Card>
        
        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Text Colors
          </Typography>
          
          <View style={styles.colorContainer}>
            <Typography variant="body" color={colors.textPrimary} style={styles.colorSample}>
              Primary Text Color
            </Typography>
            
            <Typography variant="caption" style={styles.colorCode}>
              {colors.textPrimary}
            </Typography>
          </View>
          
          <View style={styles.colorContainer}>
            <Typography variant="body" color={colors.textMuted} style={styles.colorSample}>
              Muted Text Color
            </Typography>
            
            <Typography variant="caption" style={styles.colorCode}>
              {colors.textMuted}
            </Typography>
          </View>
          
          <View style={styles.colorContainer}>
            <View style={styles.darkBackground}>
              <Typography variant="body" color={colors.bgLight} style={styles.colorSample}>
                Light Text on Dark Background
              </Typography>
            </View>
            
            <Typography variant="caption" style={styles.colorCode}>
              {colors.bgLight}
            </Typography>
          </View>
          
          <View style={styles.colorContainer}>
            <Typography variant="body" color={colors.primary} style={styles.colorSample}>
              Primary Brand Color
            </Typography>
            
            <Typography variant="caption" style={styles.colorCode}>
              {colors.primary}
            </Typography>
          </View>
        </Card>
        
        <Button
          title="Back to Home"
          variant="secondary"
          onPress={() => navigation.goBack()}
          style={styles.backButton}
        />
      </ScrollView>
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
    padding: spacing.md,
  },
  cardTitle: {
    marginBottom: spacing.sm,
  },
  fontInfo: {
    marginBottom: spacing.sm,
  },
  divider: {
    height: 1,
    backgroundColor: colors.gray200,
    marginVertical: spacing.md,
  },
  variantContainer: {
    marginBottom: spacing.sm,
  },
  variantHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: spacing.xxs,
  },
  variantDetails: {
    color: colors.textMuted,
  },
  variantSample: {
    marginBottom: spacing.xs,
  },
  separator: {
    height: 1,
    backgroundColor: colors.gray100,
    marginVertical: spacing.sm,
  },
  colorContainer: {
    marginBottom: spacing.md,
  },
  colorSample: {
    marginBottom: spacing.xxs,
  },
  colorCode: {
    color: colors.textMuted,
  },
  darkBackground: {
    backgroundColor: colors.darkSlate,
    padding: spacing.sm,
    borderRadius: 8,
  },
  backButton: {
    marginTop: spacing.md,
    marginBottom: spacing.xl,
  },
});

export default TypographyShowcaseScreen;
