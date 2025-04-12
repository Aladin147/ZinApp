import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';

/// A custom text field widget for the ZinApp application
class ZinTextField extends StatelessWidget {
  /// Controller for the text field
  final TextEditingController? controller;

  /// Label text displayed above the text field
  final String? labelText;

  /// Hint text displayed inside the text field when empty
  final String? hintText;

  /// Icon displayed at the start of the text field
  final Widget? prefixIcon;

  /// Icon displayed at the end of the text field
  final Widget? suffixIcon;

  /// Whether to obscure the text (for passwords)
  final bool obscureText;

  /// Keyboard type for the text field
  final TextInputType? keyboardType;

  /// Action to perform when the text field is submitted
  final TextInputAction? textInputAction;

  /// Function to validate the text field input
  final String? Function(String?)? validator;

  /// Function called when the text field is submitted
  final void Function(String)? onSubmitted;

  /// Function called when the text field value changes
  final void Function(String)? onChanged;

  /// Whether the text field is enabled
  final bool enabled;

  /// Maximum number of lines for the text field
  final int? maxLines;

  /// Minimum number of lines for the text field
  final int? minLines;

  /// Maximum length of text in the text field
  final int? maxLength;

  /// Whether to show the counter for character count
  final bool? showCounter;

  /// Whether to auto-focus the text field when displayed
  final bool autofocus;

  /// Focus node for the text field
  final FocusNode? focusNode;

  /// Text style for the input text
  final TextStyle? style;

  /// Content padding for the text field
  final EdgeInsetsGeometry? contentPadding;

  const ZinTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter,
    this.autofocus = false,
    this.focusNode,
    this.style,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label text (if provided)
        if (labelText != null) ...[
          Text(
            labelText!,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Text field
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding ?? const EdgeInsets.all(16),
            filled: true,
            fillColor: theme.colorScheme.surface,
            counterText: showCounter == false ? '' : null,
            // Custom border styling
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryHighlight,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2,
              ),
            ),
          ),
          style: style ?? theme.textTheme.bodyMedium,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          onChanged: onChanged,
          enabled: enabled,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          maxLength: maxLength,
          autofocus: autofocus,
          focusNode: focusNode,
        ),
      ],
    );
  }
}
