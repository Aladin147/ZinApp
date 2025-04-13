import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zinapp_v2/models/token_transaction.dart';
// import 'package:zinapp_v2/theme/color_scheme.dart'; // Unused import removed

/// A list item that displays a token transaction with its type, amount, and timestamp.
class TokenTransactionItem extends StatelessWidget {
  final TokenTransaction transaction;

  const TokenTransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    
    // Determine icon and colors based on transaction type
    IconData icon;
    Color iconColor;
    Color amountColor;
    String prefix;
    
    switch (transaction.type) {
      case TokenTransactionType.earned:
        icon = Icons.add_circle;
        iconColor = Colors.green;
        amountColor = Colors.green;
        prefix = '+';
        break;
      case TokenTransactionType.spent:
        icon = Icons.remove_circle;
        iconColor = Colors.red;
        amountColor = Colors.red;
        prefix = '-';
        break;
      case TokenTransactionType.received:
        icon = Icons.arrow_circle_down;
        iconColor = Colors.blue;
        amountColor = Colors.blue;
        prefix = '+';
        break;
      case TokenTransactionType.sent:
        icon = Icons.arrow_circle_up;
        iconColor = Colors.orange;
        amountColor = Colors.orange;
        prefix = '-';
        break;
      case TokenTransactionType.system:
        icon = Icons.settings;
        iconColor = Colors.purple;
        amountColor = Colors.purple;
        prefix = transaction.amount >= 0 ? '+' : '-';
        break;
    }
    
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withAlpha(51), // 0.2 opacity
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        transaction.description ?? _getDefaultDescription(transaction.type),
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        dateFormat.format(transaction.timestamp),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(153), // 0.6 opacity
        ),
      ),
      trailing: Text(
        '$prefix${transaction.amount.abs()}',
        style: theme.textTheme.titleMedium?.copyWith(
          color: amountColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        _showTransactionDetails(context, transaction);
      },
    );
  }
  
  String _getDefaultDescription(TokenTransactionType type) {
    switch (type) {
      case TokenTransactionType.earned:
        return 'Tokens Earned';
      case TokenTransactionType.spent:
        return 'Tokens Spent';
      case TokenTransactionType.received:
        return 'Tokens Received';
      case TokenTransactionType.sent:
        return 'Tokens Sent';
      case TokenTransactionType.system:
        return 'System Transaction';
    }
  }
  
  void _showTransactionDetails(BuildContext context, TokenTransaction transaction) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMMM d, yyyy • h:mm a');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          transaction.description ?? _getDefaultDescription(transaction.type),
          style: theme.textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              context,
              label: 'Amount',
              value: '${transaction.amount >= 0 ? '+' : ''}${transaction.amount}',
              valueColor: transaction.amount >= 0 ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              label: 'Type',
              value: _formatTransactionType(transaction.type),
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              label: 'Date',
              value: dateFormat.format(transaction.timestamp),
            ),
            const SizedBox(height: 8),
            if (transaction.relatedEntityId != null) ...[
              _buildDetailRow(
                context,
                label: 'Related To',
                value: transaction.relatedEntityId!,
              ),
              const SizedBox(height: 8),
            ],
            _buildDetailRow(
              context,
              label: 'Transaction ID',
              value: transaction.id,
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
  
  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
  }) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withAlpha(179), // 0.7 opacity
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
  
  String _formatTransactionType(TokenTransactionType type) {
    switch (type) {
      case TokenTransactionType.earned:
        return 'Earned';
      case TokenTransactionType.spent:
        return 'Spent';
      case TokenTransactionType.received:
        return 'Received';
      case TokenTransactionType.sent:
        return 'Sent';
      case TokenTransactionType.system:
        return 'System';
    }
  }
}
