# ZinApp V2 - Practices to Avoid (DO NOT DO)

This document lists specific anti-patterns, practices, or technologies that should be actively avoided during ZinApp V2 development to maintain code quality, consistency, and adherence to the project's architecture and design principles.

---

*   **Hardcoding Design Tokens:**
    *   **DO NOT** hardcode colors, font sizes, spacing values, border radii, etc., directly in widget style properties.
    *   **DO** always use values derived from `Theme.of(context)` (e.g., `Theme.of(context).colorScheme.primary`, `Theme.of(context).textTheme.bodyMedium`, `Theme.of(context).cardTheme.shape`) or defined constants/extensions for spacing/radii.
    *   **Reference:** `docs/v2/V2_COMPONENT_SYSTEM.md`, `docs/v2/V2_BRAND_IDENTITY.md`

*   **Mixing RN/Flutter Code:**
    *   **DO NOT** attempt to directly port, copy-paste, or mix React Native code, components, or state management logic into the Flutter V2 codebase.
    *   **DO** use the V1 codebase solely as a reference for understanding business logic, feature scope, and potential API contracts. The V2 implementation must be idiomatic Flutter/Dart.
    *   **Reference:** `docs/v2/V2_MIGRATION_GUIDE.md`

*   **Placing Reusable Widgets in Feature Folders:**
    *   **DO NOT** place widgets intended for use across multiple features inside a specific feature's directory (`lib/features/*/widgets/`).
    *   **DO** place genuinely reusable, feature-agnostic widgets in the shared `lib/widgets/` directory. Promote widgets from feature folders only when clear cross-feature reusability is identified.
    *   **Reference:** `docs/v2/V2_FILE_STRUCTURE.md`, `docs/v2/V2_COMPONENT_SYSTEM.md`

*   **Ignoring Accessibility:**
    *   **DO NOT** build UI components or screens without considering accessibility from the start.
    *   **DO** ensure adequate tap target sizes, sufficient color contrast, meaningful semantic labels for screen readers, and respect for reduced motion settings.
    *   **Reference:** `docs/v2/V2_ACCESSIBILITY_GUIDELINES.md`

*   **Direct Service Calls from UI Widgets:**
    *   **DO NOT** call `ApiService`, `GamificationService`, or other business logic services directly from within the `build` method of UI widgets.
    *   **DO** trigger actions through the state management layer (e.g., calling methods on a Riverpod Notifier or Provider) which then interacts with the service layer.
    *   **Reference:** `docs/v2/V2_ARCHITECTURE.md`

*   **Using `dynamic` Type Excessively:**
    *   **DO NOT** overuse the `dynamic` type. Aim for strong typing wherever possible.
    *   **DO** define clear data models (`lib/models/`) and use explicit types for variables, function parameters, and return values. Consider enabling stricter lint rules (`avoid_dynamic`) later.
    *   **Reference:** `docs/v2/V2_DEV_SETUP.md` (Linting section)

*   **Large, Monolithic Widgets/Classes:**
    *   **DO NOT** create overly large widgets or classes that handle too many responsibilities.
    *   **DO** break down complex UI into smaller, composable widgets and separate logic into appropriate state management classes or services. Follow the Single Responsibility Principle.
    *   **Reference:** `docs/v2/V2_COMPONENT_SYSTEM.md`, `docs/v2/V2_ARCHITECTURE.md`

*   **Ignoring State Management Patterns:**
    *   **DO NOT** manage complex state directly within `StatefulWidget` using `setState` excessively for non-ephemeral state.
    *   **DO** utilize the chosen state management solution (Riverpod) and its patterns (e.g., `StateNotifierProvider`) for managing feature or application state.
    *   **Reference:** `docs/v2/V2_ARCHITECTURE.md`

---

*(Add other specific anti-patterns as they are identified)*
