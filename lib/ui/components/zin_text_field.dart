import 'package:flutter/material.dart';

/// Defines the various styles for ZinTextField
enum ZinTextFieldVariant {
  /// Standard text field with default styling
  standard,
  
  /// Text field with darker styling for dark mode or accent areas
  dark,
  
  /// Text field with minimal styling, often used in content forms
  minimal,
}

/// A customized text field component for ZinApp that follows the brand guidelines.
///
/// The ZinTextField provides consistent styling and behavior for text input
/// across the application, with variants for different contexts.
class ZinTextField extends StatefulWidget {
  /// Controller for managing the text input
  final TextEditingController? controller;
  
  /// Hint text to display when the field is empty
  final String? hintText;
  
  /// Label text displayed above the field
  final String? labelText;
  
  /// Helper text displayed below the field
  final String? helperText;
  
  /// Error text displayed below the field when validation fails
  final String? errorText;
  
  /// Prefix icon displayed at the start of the field
  final IconData? prefixIcon;
  
  /// Suffix icon displayed at the end of the field
  final IconData? suffixIcon;
  
  /// Function to execute when the suffix icon is tapped
  final VoidCallback? onSuffixIconTap;
  
  /// Callback for when the text changes
  final ValueChanged<String>? onChanged;
  
  /// Callback for when editing is complete
  final ValueChanged<String>? onSubmitted;
  
  /// Whether the text field is enabled
  final bool enabled;
  
  /// Whether the text field is in focus
  final bool autofocus;
  
  /// Whether the text is obscured (for passwords)
  final bool obscureText;
  
  /// The maximum number of lines for the text field
  final int? maxLines;
  
  /// Whether to expand to fill available height
  final bool expands;
  
  /// The maximum length of text allowed
  final int? maxLength;
  
  /// Input type for the text field
  final TextInputType? keyboardType;
  
  /// Text capitalization style
  final TextCapitalization textCapitalization;
  
  /// Action to perform when submit is pressed
  final TextInputAction? textInputAction;
  
  /// Styling variant for the text field
  final ZinTextFieldVariant variant;
  
  /// Whether to show a clear button when text is entered
  final bool showClearButton;
  
  /// Creates a standard text field
  const ZinTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.expands = false,
    this.maxLength,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.variant = ZinTextFieldVariant.standard,
    this.showClearButton = false,
  }) : super(key: key);
  
  /// Creates a dark-styled text field for dark backgrounds
  factory ZinTextField.dark({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    String? helperText,
    String? errorText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconTap,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool enabled = true,
    bool autofocus = false,
    bool obscureText = false,
    int? maxLines = 1,
    bool expands = false,
    int? maxLength,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    bool showClearButton = false,
  }) {
    return ZinTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onSuffixIconTap: onSuffixIconTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      maxLines: maxLines,
      expands: expands,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      variant: ZinTextFieldVariant.dark,
      showClearButton: showClearButton,
    );
  }
  
  /// Creates a minimal-styled text field for content forms
  factory ZinTextField.minimal({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    String? helperText,
    String? errorText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconTap,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool enabled = true,
    bool autofocus = false,
    bool obscureText = false,
    int? maxLines = 1,
    bool expands = false,
    int? maxLength,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    bool showClearButton = false,
  }) {
    return ZinTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onSuffixIconTap: onSuffixIconTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      maxLines: maxLines,
      expands: expands,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      variant: ZinTextFieldVariant.minimal,
      showClearButton: showClearButton,
    );
  }

  @override
  State<ZinTextField> createState() => _ZinTextFieldState();
}

class _ZinTextFieldState extends State<ZinTextField> {
  late TextEditingController _controller;
  bool _hasFocus = false;
  late FocusNode _focusNode;
  
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    
    // Ensure we rebuild when controller changes
    _controller.addListener(_handleTextChange);
  }
  
  @override
  void dispose() {
    if (widget.controller == null) {
      // Only dispose the controller if we created it
      _controller.dispose();
    } else {
      _controller.removeListener(_handleTextChange);
    }
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }
  
  void _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }
  
  void _handleTextChange() {
    setState(() {
      // Update widget when text changes (for clear button)
    });
  }
  
  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
  }
  
  InputDecoration _getInputDecoration() {
    // Determine colors based on variant and state
    Color fillColor;
    Color borderColor;
    Color textColor;
    Color labelColor;
    Color hintColor;
    Color iconColor;
    Color focusedBorderColor;
    double borderRadius = 12.0;
    
    switch (widget.variant) {
      case ZinTextFieldVariant.standard:
        fillColor = const Color(0xFFF5F5F5);
        borderColor = const Color(0xFFE0E0E0);
        textColor = const Color(0xFF232D30);
        labelColor = const Color(0xFF757575);
        hintColor = const Color(0xFF9E9E9E);
        iconColor = const Color(0xFF757575);
        focusedBorderColor = const Color(0xFFD2FF4D); // Brand yellow
        break;
      case ZinTextFieldVariant.dark:
        fillColor = const Color(0xFF2C3538); // Darker slate
        borderColor = const Color(0xFF384046);
        textColor = Colors.white;
        labelColor = Colors.white70;
        hintColor = Colors.white54;
        iconColor = Colors.white70;
        focusedBorderColor = const Color(0xFFD2FF4D); // Brand yellow
        break;
      case ZinTextFieldVariant.minimal:
        fillColor = Colors.transparent;
        borderColor = const Color(0xFFE0E0E0);
        textColor = const Color(0xFF232D30);
        labelColor = const Color(0xFF757575);
        hintColor = const Color(0xFF9E9E9E);
        iconColor = const Color(0xFF757575);
        focusedBorderColor = const Color(0xFFD2FF4D); // Brand yellow
        borderRadius = 8.0; // Smaller radius for minimal style
        break;
    }
    
    // Handle disabled state
    if (!widget.enabled) {
      fillColor = widget.variant == ZinTextFieldVariant.dark
          ? const Color(0xFF1E2528) // Darker disabled state
          : const Color(0xFFEEEEEE); // Light disabled state
      borderColor = widget.variant == ZinTextFieldVariant.dark
          ? const Color(0xFF2C3538)
          : const Color(0xFFDDDDDD);
      textColor = widget.variant == ZinTextFieldVariant.dark
          ? Colors.white38
          : const Color(0xFFAAAAAA);
      labelColor = textColor;
      hintColor = textColor;
      iconColor = textColor;
    }
    
    // Suffix icon (clear button or custom icon)
    Widget? suffixIconWidget;
    if (widget.showClearButton && _controller.text.isNotEmpty) {
      suffixIconWidget = IconButton(
        icon: Icon(Icons.clear, size: 18, color: iconColor),
        onPressed: _clearText,
      );
    } else if (widget.suffixIcon != null) {
      suffixIconWidget = IconButton(
        icon: Icon(widget.suffixIcon, color: iconColor),
        onPressed: widget.onSuffixIconTap,
      );
    }
    
    return InputDecoration(
      filled: true,
      fillColor: fillColor,
      hintText: widget.hintText,
      hintStyle: TextStyle(color: hintColor),
      labelText: widget.labelText,
      labelStyle: TextStyle(color: labelColor),
      helperText: widget.helperText,
      helperStyle: TextStyle(
        color: widget.variant == ZinTextFieldVariant.dark ? Colors.white54 : const Color(0xFF757575),
      ),
      errorText: widget.errorText,
      errorStyle: const TextStyle(
        color: Color(0xFFE53935), // Error red
      ),
      prefixIcon: widget.prefixIcon != null
          ? Icon(widget.prefixIcon, color: iconColor)
          : null,
      suffixIcon: suffixIconWidget,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: widget.variant == ZinTextFieldVariant.minimal && !_hasFocus
            ? BorderSide.none
            : BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: widget.variant == ZinTextFieldVariant.minimal
            ? BorderSide.none
            : BorderSide(color: borderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: widget.variant == ZinTextFieldVariant.minimal
            ? BorderSide.none
            : BorderSide(color: borderColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor;
    switch (widget.variant) {
      case ZinTextFieldVariant.standard:
      case ZinTextFieldVariant.minimal:
        textColor = widget.enabled ? const Color(0xFF232D30) : const Color(0xFFAAAAAA);
        break;
      case ZinTextFieldVariant.dark:
        textColor = widget.enabled ? Colors.white : Colors.white38;
        break;
    }
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          widget.variant == ZinTextFieldVariant.minimal ? 8.0 : 12.0
        ),
        boxShadow: _hasFocus
            ? [
                BoxShadow(
                  color: const Color(0xFFD2FF4D).withOpacity(0.3), // Brand yellow with opacity
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        decoration: _getInputDecoration(),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        maxLines: widget.expands ? null : widget.maxLines,
        minLines: widget.expands ? null : 1,
        expands: widget.expands,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
