import React from 'react';
import { View, StyleSheet } from 'react-native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../types';
import { colors, spacing } from '../constants';
import { Screen, Typography, Button, Card } from '../components';

type QRScannerShowcaseScreenNavigationProp = StackNavigationProp<
  RootStackParamList,
  'QRScannerShowcaseScreen'
>;

type Props = {
  navigation: QRScannerShowcaseScreenNavigationProp;
};

/**
 * Placeholder screen for QR Scanner functionality
 */
const QRScannerShowcaseScreen: React.FC<Props> = ({ navigation }) => {
  return (
    <Screen>
      <View style={styles.container}>
        <Typography variant="screenTitle" style={styles.title}>
          QR Scanner (Coming Soon)
        </Typography>

        <Typography variant="body" style={styles.description}>
          The QR Scanner functionality is currently under development. This feature will allow users to scan stylist QR codes to quickly view their profiles.
        </Typography>

        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            How It Will Work
          </Typography>

          <Typography variant="body" style={styles.cardDescription}>
            When implemented, the QR Scanner will use your device's camera to scan QR codes. It will provide a visual frame to help you position the QR code correctly.
          </Typography>


        </Card>

        <Card style={styles.card}>
          <Typography variant="sectionHeader" style={styles.cardTitle}>
            Use Cases
          </Typography>

          <Typography variant="body" style={styles.cardDescription}>
            • Quickly access stylist profiles by scanning their QR code
            • Verify stylist identity for added security
            • Share your favorite stylists with friends
          </Typography>
        </Card>

        <Button
          title="Back to Home"
          variant="secondary"
          onPress={() => navigation.goBack()}
          style={styles.backButton}
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
    marginBottom: spacing.xs,
  },
  cardDescription: {
    marginBottom: spacing.md,
  },

  backButton: {
    marginTop: spacing.md,
  },
});

export default QRScannerShowcaseScreen;
