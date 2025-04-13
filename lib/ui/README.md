# UI Layer

This directory contains all pure Flutter presentation components that make up ZinApp's user interface. It follows the principles of clean architecture by separating presentation concerns from business logic.

## Purpose

The UI layer is responsible for:

1. **Presentation Only** - Components in this layer should focus exclusively on how things look and feel
2. **Component Composition** - Building screens from our standardized component library
3. **Animation & Interaction** - Implementing motion and user interaction patterns
4. **Theme Consumption** - Using theme data for consistent styling

## Structure

- `components/` - Reusable UI components (ZinButton, ZinCard, etc.)
- `screens/` - Full screen compositions
- `animations/` - Animation definitions and utilities
- `theme/` - Theme extensions and helpers

## Guidelines

1. UI components should **never** directly implement business logic
2. All components should use the theme system for styling
3. UI components should receive data and callbacks as parameters
4. Animation should be encapsulated within components where possible
5. Use composition over inheritance
6. Prefer stateless widgets unless internal UI state is needed

## Example

```dart
class ZinButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ZinButtonVariant variant;

  const ZinButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.variant = ZinButtonVariant.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implementation using theme data and variant
  }
}
