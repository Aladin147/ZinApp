import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/profile/widgets/expandable_profile_widget.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
import 'package:zinapp_v2/models/user_profile.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A widget that displays the user's token balance
/// Shows a summary when collapsed and transaction history when expanded
class TokenBalanceWidget extends StatelessWidget {
  /// The user profile to display
  final UserProfile user;

  /// List of token transactions
  final List<TokenTransaction> transactions;

  /// Callback when "Earn More" is tapped
  final VoidCallback? onEarnMoreTap;

  /// Callback when "Spend" is tapped
  final VoidCallback? onSpendTap;

  /// Initial state of the widget
  final ExpandableWidgetState initialState;

  /// Creates a token balance widget
  const TokenBalanceWidget({
    super.key,
    required this.user,
    required this.transactions,
    this.onEarnMoreTap,
    this.onSpendTap,
    this.initialState = ExpandableWidgetState.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Calculate token change in the last 30 days
    final recentTransactions = transactions.where(
      (t) => DateTime.now().difference(t.timestamp).inDays < 30
    ).toList();

    int tokenChange = 0;
    for (final transaction in recentTransactions) {
      if (transaction.type == TokenTransactionType.earned) {
        tokenChange += transaction.amount;
      } else {
        tokenChange -= transaction.amount;
      }
    }

    final isPositiveChange = tokenChange >= 0;
    final changeText = isPositiveChange ? '+$tokenChange' : '$tokenChange';
    final changeColor = isPositiveChange ? Colors.green : Colors.red;

    return ExpandableProfileWidget(
      title: 'Token Balance',
      subtitle: 'Last 30 days: $changeText',
      icon: Icons.token,
      accentColor: Colors.amber,
      initialState: initialState,

      // Collapsed view - token balance and quick actions
      collapsedChild: Row(
        children: [
          // Token icon and balance
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.amber.withAlpha(100),
                  Colors.amber.withAlpha(30),
                ],
                stops: const [0.4, 1.0],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withAlpha(50),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
              border: Border.all(
                color: Colors.amber.withAlpha(100),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.token,
              color: Colors.amber,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),

          // Balance and change
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.tokens.toString(),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Available Balance',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (tokenChange != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: changeColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          changeText,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: changeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Quick actions
          Column(
            children: [
              _buildActionButton(
                context,
                label: 'Earn More',
                icon: Icons.add_circle_outline,
                color: Colors.green,
                onTap: onEarnMoreTap,
              ),
              const SizedBox(height: 8),
              _buildActionButton(
                context,
                label: 'Spend',
                icon: Icons.shopping_bag_outlined,
                color: Colors.amber,
                onTap: onSpendTap,
              ),
            ],
          ),
        ],
      ),

      // Expanded view - transaction history and token details
      expandedChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Token balance card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.amber.withAlpha(100),
                  Colors.amber.withAlpha(50),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withAlpha(30),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Token icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.token,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),

                // Balance and change
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.tokens.toString(),
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
          ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: _buildFullActionButton(
                  context,
                  label: 'Earn More',
                  icon: Icons.add_circle_outline,
                  color: Colors.green,
                  onTap: onEarnMoreTap,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFullActionButton(
                  context,
                  label: 'Spend Tokens',
                  icon: Icons.shopping_bag_outlined,
                  color: Colors.amber,
                  onTap: onSpendTap,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Transaction history
          Text(
            'Recent Transactions',
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Transaction list
          transactions.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No transactions yet',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: transactions
                      .take(5)
                      .map((transaction) => _buildTransactionItem(context, transaction))
                      .toList(),
                ),

          if (transactions.length > 5) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  // TODO: Navigate to full transaction history
                },
                icon: const Icon(Icons.history),
                label: const Text('View All Transactions'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.amber,
                ),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Token info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.baseDarkAccent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.amber.withAlpha(50),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Tokens',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildTokenInfoItem(
                  context,
                  icon: Icons.add_circle_outline,
                  text: 'Earn tokens by booking appointments, leaving reviews, and completing challenges.',
                ),
                const SizedBox(height: 4),
                _buildTokenInfoItem(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  text: 'Spend tokens on premium styles, tips for stylists, and exclusive content.',
                ),
                const SizedBox(height: 4),
                _buildTokenInfoItem(
                  context,
                  icon: Icons.access_time,
                  text: 'Tokens expire after 6 months of inactivity.',
                ),
                const SizedBox(height: 8),
                Text(
                  'Note: Tokens cannot be exchanged for real currency.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withAlpha(100),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, TokenTransaction transaction) {
    final theme = Theme.of(context);
    final isEarned = transaction.type == TokenTransactionType.earned;
    final amountText = isEarned ? '+${transaction.amount}' : '-${transaction.amount}';
    final amountColor = isEarned ? Colors.green : Colors.red;

    // Format date as "Today", "Yesterday", or "MMM d"
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(
      transaction.timestamp.year,
      transaction.timestamp.month,
      transaction.timestamp.day,
    );

    String dateText;
    if (transactionDate == today) {
      dateText = 'Today';
    } else if (transactionDate == yesterday) {
      dateText = 'Yesterday';
    } else {
      final month = _getMonthAbbreviation(transaction.timestamp.month);
      dateText = '$month ${transaction.timestamp.day}';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isEarned ? Colors.green.withAlpha(30) : Colors.red.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isEarned ? Icons.add : Icons.remove,
                  color: isEarned ? Colors.green : Colors.red,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description ?? 'Transaction',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    dateText,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            amountText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenInfoItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.amber,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
