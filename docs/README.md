# ZinApp V2 Development

This directory contains documentation for the V2 development of ZinApp. V2 represents a significant evolution from V1, with major changes to brand identity, visual design, code structure, and the addition of gamification elements.

## Current Status

The major technical debt resolution and architectural refactoring for V2 (Phases 1-7) is complete or nearing completion. The codebase now follows Clean Architecture principles, utilizes Riverpod for state management, and adheres to a standardized feature-first structure. Development focus is shifting towards building new features, stabilization, and further enhancements on this solid foundation.

## Core Documentation

Key documents outlining the current architecture, standards, and development process include:

- **Architecture:**
    - `docs/technical_architecture.md`: High-level overview of layers, structure, and key technologies.
    - `docs/V2_ARCHITECTURE.md`: Detailed explanation of architectural layers, patterns, and choices.
    - `docs/V2_FILE_STRUCTURE.md`: Defines the standard project directory structure.
- **State Management:**
    - `docs/developer_guides/state_management_with_riverpod.md`: Comprehensive guide to using Riverpod in this project.
    - `docs/specs/riverpod-architecture.md`: Detailed specification of Riverpod patterns used.
- **Development Process:**
    - `docs/developer_guides/adding_a_new_feature.md`: Step-by-step guide for adding new features following the established architecture.
    - `docs/development_standards/`: Contains code style guides, PR templates, etc.
    - `docs/journal/`: Chronological record of development progress, decisions, and challenges faced during the refactoring phases.
- **Design System & Brand:**
    - `docs/design_system/`: Contains detailed documentation on colors, typography, components, etc. (Supersedes older `V2_BRAND_IDENTITY.md`, `V2_COMPONENT_SYSTEM.md` if fully populated).
    - `docs/V2_BRAND_IDENTITY.md`: Core brand identity elements (colors, typography).
- **Features:**
    - `docs/GAMIFICATION_ENGINE.md` / `docs/V2_GAMIFICATION.md`: Details on the gamification system.
    - Feature-specific READMEs may exist within `lib/features/[feature_name]/`.

*(Note: Older `V2_` documents like `V2_MIGRATION_GUIDE.md` and `V2_PROGRESS_JOURNAL.md` may be outdated or superseded by the journal entries and current guides.)*

## Development Approach

Development now follows these core principles based on the established V2 architecture:

1.  **Clean Architecture:** Adhere to the separation of concerns between Presentation, Domain, and Data layers within each feature.
2.  **Feature-First Structure:** Organize code primarily by feature within the `lib/features/` directory.
3.  **Riverpod for State Management:** Utilize Riverpod consistently for state management and dependency injection, following patterns outlined in the developer guide.
4.  **Immutability:** Use immutable state classes (preferably with `freezed`).
5.  **Modularity & Reusability:** Build reusable components (`lib/widgets/`) and services (`lib/services/`) where appropriate, minimizing direct dependencies between features.
6.  **Testing:** Follow the testing strategy (`docs/V2_TEST_STRATEGY.md`), writing unit, widget, and integration tests for new and existing code.
7.  **Code Generation:** Leverage `build_runner` for Riverpod providers (`@riverpod`) and immutable classes (`freezed`).

## Key Brand Identity Elements

### Primary Colors
- **#D2FF4D**: Highlight / CTA / Logo (for energy, currency, or reward system actions)
- **#232D30**: Official Background / Base Dark (primary background for depth and polish)

### Typography
- Modern sans-serif font (e.g., Urbanist, Nunito, or Inter)
- Headings: 28px / 24px / 20px tiers
- Body: 16px default
- Caption/meta: 13–14px
- CTA Buttons: Uppercase or bold, 16–18px
- Weight hierarchy: Regular (400) / Medium (500) / Bold (700) only

### Iconography
- Style: Flat, outlined or filled with soft edges
- Sizing: Standard 20–24px, matching text cap height
- Positioning: Vertically aligned to center of adjacent text
- Padding: 8–10px from adjacent elements
- Sets: Prefer Lucide or Heroicons, or custom match

## Getting Started

To contribute to ZinApp V2 development:

1.  Clone the repository. Ensure you are on the main development branch (e.g., `main`, `develop`, or the successor to `full-riverpod-migration` - please verify current branch).
2.  Familiarize yourself with the core documentation listed above, especially:
    *   `docs/technical_architecture.md`
    *   `docs/V2_FILE_STRUCTURE.md`
    *   `docs/developer_guides/state_management_with_riverpod.md`
    *   `docs/developer_guides/adding_a_new_feature.md`
3.  Follow the established file structure and architectural patterns when adding or modifying code.
4.  Refer to the `docs/design_system/` or `docs/V2_BRAND_IDENTITY.md` for UI/UX guidelines.
5.  Run `flutter pub run build_runner build --delete-conflicting-outputs` after adding or modifying files that require code generation (Riverpod providers, freezed classes).

## V1 Reference

The final state of V1 is preserved in the `master` branch. While V2 represents a significant departure from V1 in terms of visual design and structure, some functional logic from V1 may be adapted and reused in V2.
