import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/auth/providers/riverpod/auth_provider.dart';
import 'package:zinapp_v2/models/auth_state.dart'; // Import AuthState
import 'package:zinapp_v2/ui/components/zin_button.dart'; // Using the new button
import 'package:zinapp_v2/ui/components/zin_text_field.dart'; // Assuming a similar text field exists or will be created
import 'package:zinapp_v2/theme/color_scheme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        // Call the login method from the AuthProvider
        // We'll implement the actual repository/datasource call later
        final success = await ref.read(authProvider.notifier).login(
              email: _emailController.text.trim(), // Use named parameter
              password: _passwordController.text.trim(), // Use named parameter
            );

        if (!success && mounted) {
           // Read the error from the current state after the failed attempt
           final currentError = ref.read(authProvider).error;
           setState(() {
             _errorMessage = currentError ?? 'Login failed. Please check credentials.';
           });
        }
        // Navigation will be handled by the Auth state listener in the root widget
      } catch (e) {
         if (mounted) {
           setState(() {
             _errorMessage = 'An error occurred: ${e.toString()}';
           });
         }
      } finally {
         if (mounted) {
           setState(() {
             _isLoading = false;
           });
         }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Listen for auth errors from the provider
    ref.listen<AuthState>(authProvider, (previous, next) {
      // Check if the new state has an error and it's different from the previous one
      if (next.error != null && previous?.error != next.error) {
        if (mounted) {
          setState(() {
            _errorMessage = next.error; // Use state.error
            _isLoading = false; // Stop loading on error
          });
        }
      }
    });


    return Scaffold(
      backgroundColor: AppColors.baseDark,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: AppColors.baseDarkAlt,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // TODO: Add ZinApp Logo here later
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to continue your style journey.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),

                // Using ZinTextField
                 ZinTextField.dark( // Use ZinTextField.dark variant
                   controller: _emailController,
                   labelText: 'Email',
                   prefixIcon: Icons.email_outlined, // Pass IconData directly
                   keyboardType: TextInputType.emailAddress,
                   // Validator removed - handle in Form or _login if needed
                 ),
                // ZinTextField(
                //   controller: _emailController,
                //   labelText: 'Email',
                const SizedBox(height: 16),
                 ZinTextField.dark( // Use ZinTextField.dark variant
                   controller: _passwordController,
                   labelText: 'Password',
                   prefixIcon: Icons.lock_outline, // Pass IconData directly
                   obscureText: true,
                   // Validator removed - handle in Form or _login if needed
                 ),
                // ZinTextField(
                //   controller: _passwordController,
                //   labelText: 'Password',
                const SizedBox(height: 24),

                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],

                ZinButton(
                  label: 'Login',
                  onPressed: _isLoading ? null : _login, // Disable button when loading
                  // isLoading parameter removed as it doesn't exist on ZinButton
                  fullWidth: true,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to registration screen
                  },
                  child: Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(color: AppColors.primaryHighlight),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
