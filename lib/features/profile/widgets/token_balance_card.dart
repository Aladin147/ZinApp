import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinapp_v2/router/app_routes.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A card that displays the user's token balance with visual effects.
class TokenBalanceCard extends StatelessWidget {
  final int tokenBalance;
  final VoidCallback? onManagePressed;

  const TokenBalanceCard({
    super.key,
    required this.tokenBalance,
    this.onManagePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryHighlight,
            AppColors.primaryHighlight.withAlpha(204), // 0.8 opacity
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryHighlight.withAlpha(77), // 0.3 opacity
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ZIN Tokens',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, color: Colors.white),
                onPressed: () {
                  _showTokenInfo(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Token balance
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(77), // 0.3 opacity
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.token,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tokenBalance.toString(),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Available Balance',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withAlpha(204), // 0.8 opacity
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Manage button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onManagePressed ?? () {
                context.go(AppRoutes.rewardsHub);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryHighlight,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Manage Tokens',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTokenInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About ZIN Tokens'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ZIN Tokens are the currency of the ZinApp ecosystem.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Earn tokens by booking appointments, leaving reviews, and completing challenges.'),
            SizedBox(height: 4),
            Text('• Spend tokens on premium styles, tips for stylists, and exclusive content.'),
            SizedBox(height: 4),
            Text('• Tokens expire after 6 months of inactivity.'),
            SizedBox(height: 8),
            Text(
              'Note: Tokens cannot be exchanged for real currency.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
