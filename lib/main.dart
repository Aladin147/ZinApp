import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/showcase/screens/component_showcase_screen.dart';
import 'package:zinapp_v2/providers/showcase_mode_provider.dart';
import 'package:zinapp_v2/riverpod_app.dart';
import 'package:zinapp_v2/widgets/showcase_toggle_button.dart';

void main() {
  // Run the app with Riverpod
  runApp(
    const ProviderScope(
      child: ZinAppRoot(),
    ),
  );
}

/// Root widget that decides whether to show the app or showcase
class ZinAppRoot extends ConsumerStatefulWidget {
  const ZinAppRoot({Key? key}) : super(key: key);

  @override
  ConsumerState<ZinAppRoot> createState() => _ZinAppRootState();
}

class _ZinAppRootState extends ConsumerState<ZinAppRoot> {
  @override
  void initState() {
    super.initState();
    
    // Initialize the showcase mode provider
    Future.microtask(() {
      ref.read(showcaseModeProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Read the showcase mode state
    final isShowcaseMode = ref.watch(showcaseModeProvider);

    return MaterialApp(
      title: 'ZinApp V2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD2FF4D), // Primary yellow
          brightness: Brightness.light,
        ),
        fontFamily: 'Urbanist',
      ),
      home: Builder(
        builder: (context) {
          // Choose between showcase mode and regular app
          Widget content = isShowcaseMode
              ? const ComponentShowcaseScreen()
              : const RiverpodApp();

          // Wrap with a Scaffold to provide the toggle button
          return Scaffold(
            body: content,
            floatingActionButton: const ShowcaseToggleButton(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        },
      ),
    );
  }
}
