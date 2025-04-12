import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/rewards/widgets/rewards_dashboard.dart';

/// A hub screen that provides access to all reward-related features
class RewardsHubScreen extends ConsumerWidget {
  const RewardsHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards Hub'),
      ),
      body: const RewardsDashboard(),
    );
  }
}
