# ZinApp V2 Component System

## 1. Philosophy
   - **Atomic Design Influence:** While not strictly adhering to Atomic Design, we draw inspiration from its principles of building UIs from small, reusable parts (Atoms -> Molecules -> Organisms -> Templates -> Pages).
   - **Reusability:** Prioritize creating generic, reusable components (`lib/widgets/`) for common UI elements (buttons, cards, inputs, avatars).
   - **Consistency:** Ensure all components adhere strictly to the V2 Brand Identity (`V2_BRAND_IDENTITY.md`), including colors, typography, spacing, and rounding defined in the design tokens.
   - **Composability:** Design components to be easily composed together to build more complex UI structures and features.
   - **Feature-Specific Components:** Components specific to a single feature reside within that feature's directory (`lib/features/*/widgets/`). Promote shared components (`lib/widgets/`) only when reuse across features is confirmed.
   - **Accessibility:** All components must be built with accessibility in mind from the start (See `V2_ACCESSIBILITY_GUIDELINES.md`).

## 2. Component Categories & Location
   - **Core/Shared Widgets (`lib/widgets/`)**:
     - **Purpose:** Highly reusable, generic UI elements used across multiple features.
     - **Examples:**
       - `AppButton`: Standard button with variants (primary, secondary, text).
       - `AppCard`: Base card container with standard padding, rounding, and optional elevation.
       - `AppTextField`: Styled text input field.
       - `Avatar`: User/Stylist avatar display.
       - `RatingStars`: Displays star ratings.
       - `LoadingIndicator`: Consistent loading spinner/shimmer.
       - `ScreenWrapper`: Standard screen layout wrapper (handles safe area, background color, basic padding).
       - `Typography`: (Although often implemented as a helper function/extension rather than a widget) Ensures consistent text styling.
       - `IconWidget`: Wrapper for displaying icons consistently.
   - **Feature Widgets (`lib/features/*/widgets/`)**:
     - **Purpose:** Components specific to a particular feature domain. May compose core widgets.
     - **Examples:**
       - `lib/features/booking/widgets/booking_card.dart`: Displays booking summary.
       - `lib/features/stylist_discovery/widgets/stylist_card.dart`: Displays stylist preview.
       - `lib/features/feed/widgets/post_card.dart`: Displays a social feed post.
       - `lib/features/profile/widgets/xp_progress_bar.dart`: Displays user XP progress.
   - **Screens (`lib/features/*/screens/`)**:
     - **Purpose:** Top-level widgets representing full application screens. Compose feature widgets and core widgets to build the screen layout. Responsible for fetching data (via state management) and handling primary screen-level interactions.

## 3. Component Design Principles
   - **Stateless vs. Stateful:** Prefer `StatelessWidget` where possible. Use `StatefulWidget` only when managing local, ephemeral UI state not suitable for a global state management solution.
   - **Constructor Parameters:** Use named parameters for clarity. Pass required data and callbacks. Avoid passing excessive configuration; rely on the theme for styling.
   - **Theming:** Components should derive their styling (colors, fonts, spacing) primarily from the `ThemeData` defined in `lib/app/theme.dart`. Avoid hardcoding design token values directly within components.
     ```dart
     // Good: Use theme
     Container(
       color: Theme.of(context).colorScheme.primary,
       padding: EdgeInsets.all(Theme.of(context).extension<AppSpacing>()!.medium),
     )

     // Bad: Hardcoding values
     Container(
       color: Color(0xFFD2FF4D), // Use AppColors.primaryHighlight instead
       padding: EdgeInsets.all(16.0), // Use AppSpacing.medium instead
     )
     ```
   - **Layout:** Use standard Flutter layout widgets (`Column`, `Row`, `Stack`, `Padding`, `SizedBox`, `Expanded`, `Flex`, etc.). Adhere to the 4pt grid system defined via spacing tokens.
   - **Responsiveness:** Design components to adapt reasonably to different screen sizes. Use layout widgets like `Expanded` and `Flexible`, and consider `LayoutBuilder` for more complex adaptations if necessary. (See also responsive typography in `V2_TYPOGRAPHY_SYSTEM.md`).
   - **Rounding:** Apply consistent corner rounding (`BorderRadius`) based on design tokens.
   - **Elevation/Depth:** Use elevation or shadows subtly as defined in the brand identity to create depth, primarily through `AppCard` or similar wrappers.

## 4. Key Base Components (Examples - To Be Implemented)

   - **`AppButton`**:
     - Parameters: `onPressed`, `label`, `variant` (primary, secondary, text), `icon`, `isLoading`, `isDisabled`.
     - Styling: Uses `ElevatedButton`, `OutlinedButton`, `TextButton` with custom `ButtonStyle` derived from theme. Uses highlight color (`#D2FF4D`) for primary variant.
   - **`AppCard`**:
     - Parameters: `child`, `padding`, `margin`, `elevation`, `borderRadius`, `backgroundColor`.
     - Styling: Uses `Card` or `Container` with `BoxDecoration`. Defaults based on theme (e.g., standard padding, rounding, background from `neutral.canvasLight` or `neutral.canvasDark`).
   - **`ScreenWrapper`**:
     - Parameters: `child`, `appBar`, `useSafeArea`, `backgroundColor`, `padding`.
     - Styling: Uses `Scaffold`, `SafeArea`, `Container`. Sets default background color (`#232D30`).

## 5. Development Workflow
   - **Storybook (Optional but Recommended):** Consider using `storybook_flutter` to develop and document UI components in isolation. This helps visualize different states and variations.
   - **Testing:** Write Widget Tests for core and feature components to verify rendering and basic interactions (See `V2_TEST_STRATEGY.md`).
   - **Review:** Ensure new components adhere to these guidelines during code reviews.

## 6. Evolution
   - This system will evolve. When a component developed within a feature proves reusable, promote it to `lib/widgets/`.
   - Regularly review `lib/widgets/` for consistency and potential consolidation.
