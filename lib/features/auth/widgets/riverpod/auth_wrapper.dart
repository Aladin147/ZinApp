import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';

/// Widget that redirects to login or home based on authentication state
class RiverpodAuthWrapper extends ConsumerStatefulWidget {
  final Widget authenticatedChild;
  final Widget unauthenticatedChild;

  const RiverpodAuthWrapper({
    Key? key,
    required this.authenticatedChild,
    required this.unauthenticatedChild,
  }) : super(key: key);

  @override
  ConsumerState<RiverpodAuthWrapper> createState() => _RiverpodAuthWrapperState();
}

class _RiverpodAuthWrapperState extends ConsumerState<RiverpodAuthWrapper> {
  static bool _hasInitialized = false;
  bool _localInitializing = true;

  @override
  void initState() {
    super.initState();
    // Only initialize once across all instances
    if (!_hasInitialized) {
      print('AuthWrapper: First initialization');
      _hasInitialized = true;
      // Use Future.microtask to avoid calling setState during build
      Future.microtask(() => _initializeAuth());
    } else {
      print('AuthWrapper: Skipping initialization, already done');
      _localInitializing = false;
    }
  }

  Future<void> _initializeAuth() async {
    print('AuthWrapper: Starting initialization');
    try {
      await ref.read(authProvider.notifier).initialize();
      print('AuthWrapper: Initialization completed');
    } catch (e) {
      print('AuthWrapper: Error during initialization: $e');
    }
    if (mounted) {
      setState(() {
        _localInitializing = false;
        print('AuthWrapper: Set _localInitializing to false');
      });
    } else {
      print('AuthWrapper: Widget not mounted after initialization');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_localInitializing) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final authState = ref.watch(authProvider);
    print('AuthWrapper: Building with auth state: ${authState.isAuthenticated ? "Authenticated" : "Not authenticated"}');

    if (authState.isAuthenticated) {
      return widget.authenticatedChild;
    } else {
      return widget.unauthenticatedChild;
    }
  }
}
