import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A standardized text input field component for the ZinApp V2 application.
///
/// Uses styling from the application's [ThemeData] (InputDecorationTheme).
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use the InputDecorationTheme defined in zinapp_theme.dart
    final inputDecorationTheme = theme.inputDecorationTheme;

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      onTap: onTap,
      // Apply theme styles, allowing for overrides via parameters
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // Apply theme defaults (can be overridden by InputDecoration parameters)
        filled: inputDecorationTheme.filled,
        fillColor: inputDecorationTheme.fillColor,
        contentPadding: inputDecorationTheme.contentPadding,
        hintStyle: inputDecorationTheme.hintStyle,
        labelStyle: inputDecorationTheme.labelStyle,
        floatingLabelStyle: inputDecorationTheme.floatingLabelStyle,
        border: inputDecorationTheme.border,
        enabledBorder: inputDecorationTheme.enabledBorder,
        focusedBorder: inputDecorationTheme.focusedBorder,
        errorBorder: inputDecorationTheme.errorBorder,
        focusedErrorBorder: inputDecorationTheme.focusedErrorBorder,
        errorStyle: inputDecorationTheme.errorStyle,
      ),
      // Apply text style from theme (e.g., bodyMedium)
      style: theme.textTheme.bodyMedium,
    );
  }
}

/*
  Example Usage:

  Form(
    key: _formKey,
    child: Column(
      children: [
        AppTextField(
          labelText: 'Email',
          hintText: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty || !value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        AppTextField(
          labelText: 'Password',
          obscureText: true,
          validator: (value) {
             if (value == null || value.length < 6) {
               return 'Password must be at least 6 characters';
             }
             return null;
          },
        ),
      ],
    ),
  )
*/
