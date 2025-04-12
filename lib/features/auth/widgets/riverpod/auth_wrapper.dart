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
  bool _initializing = true;

  @override
  void initState() {
    super.initState();
    // Use Future.microtask to avoid calling setState during build
    Future.microtask(() => _initializeAuth());
  }

  Future<void> _initializeAuth() async {
    await ref.read(authProvider.notifier).initialize();
    if (mounted) {
      setState(() {
        _initializing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initializing) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final authState = ref.watch(authProvider);

    if (authState.isAuthenticated) {
      return widget.authenticatedChild;
    } else {
      return widget.unauthenticatedChild;
    }
  }
}
