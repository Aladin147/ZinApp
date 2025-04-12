import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/providers/showcase_mode_provider.dart';

/// A floating action button that toggles between app and showcase modes
class ShowcaseToggleButton extends ConsumerWidget {
  const ShowcaseToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShowcaseMode = ref.watch(showcaseModeProvider);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0, right: 16.0),
      child: FloatingActionButton.extended(
        onPressed: () {
          ref.read(showcaseModeProvider.notifier).toggle();
          
          // Show a snackbar to confirm the mode change
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isShowcaseMode
                    ? 'Switching to App Mode'
                    : 'Switching to Showcase Mode',
              ),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        backgroundColor: isShowcaseMode
            ? const Color(0xFF232D30) // Dark slate
            : const Color(0xFFD2FF4D), // Primary yellow
        foregroundColor: isShowcaseMode
            ? const Color(0xFFD2FF4D) // Primary yellow
            : const Color(0xFF232D30), // Dark slate
        icon: Icon(
          isShowcaseMode ? Icons.app_shortcut : Icons.widgets,
        ),
        label: Text(
          isShowcaseMode ? 'App Mode' : 'Showcase',
        ),
      ),
    );
  }
}
