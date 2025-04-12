import 'package:flutter/material.dart';
import 'package:zinapp_v2/features/auth/screens/login_screen.dart';
import 'package:zinapp_v2/features/auth/screens/register_screen.dart';

/// Screen that handles switching between login and register views
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showLogin = true;

  void _toggleView() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLogin) {
      return LoginScreen(onRegisterTap: _toggleView);
    } else {
      return RegisterScreen(onLoginTap: _toggleView);
    }
  }
}
