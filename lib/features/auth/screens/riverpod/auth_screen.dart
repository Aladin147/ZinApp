import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/screens/riverpod/login_screen.dart';
import 'package:zinapp_v2/features/auth/screens/riverpod/register_screen.dart';

class RiverpodAuthScreen extends ConsumerStatefulWidget {
  const RiverpodAuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RiverpodAuthScreen> createState() => _RiverpodAuthScreenState();
}

class _RiverpodAuthScreenState extends ConsumerState<RiverpodAuthScreen> {
  bool _showLogin = true;

  void _toggleAuthMode() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showLogin
        ? RiverpodLoginScreen(onRegisterTap: _toggleAuthMode)
        : RiverpodRegisterScreen(onLoginTap: _toggleAuthMode);
  }
}
