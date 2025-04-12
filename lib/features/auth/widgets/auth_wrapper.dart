import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zinapp_v2/features/auth/providers/auth_provider.dart';

/// Widget that redirects to login or home based on authentication state
class AuthWrapper extends StatefulWidget {
  final Widget authenticatedChild;
  final Widget unauthenticatedChild;

  const AuthWrapper({
    Key? key,
    required this.authenticatedChild,
    required this.unauthenticatedChild,
  }) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _initializing = true;

  @override
  void initState() {
    super.initState();
    // Use Future.microtask to avoid calling setState during build
    Future.microtask(() => _initializeAuth());
  }

  Future<void> _initializeAuth() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.initialize();
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

    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isAuthenticated) {
      return widget.authenticatedChild;
    } else {
      return widget.unauthenticatedChild;
    }
  }
}
