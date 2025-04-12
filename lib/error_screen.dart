import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A screen to display when an error occurs during navigation.
class ErrorScreen extends StatelessWidget {
  /// Creates an error screen.
  const ErrorScreen({super.key, required this.error});

  /// The error that occurred.
  final Exception error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseDark,
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: AppColors.baseDark,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppColors.coral,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong.',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
