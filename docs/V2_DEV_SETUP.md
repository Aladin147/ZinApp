# ZinApp V2 Development Environment Setup

This document outlines the necessary setup for developing the ZinApp V2 Flutter application. Consistency in the development environment ensures code quality and smooth collaboration.

## 1. Flutter SDK
   - **Requirement:** Ensure you have the Flutter SDK installed. Follow the official Flutter installation guide for your operating system: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
   - **Version:** While the project aims to be compatible with recent stable versions, target Flutter version `3.x.x` (specify exact version later if needed). Verify your installation using `flutter --version`.
   - **Channel:** Use the `stable` channel (`flutter channel stable`, `flutter upgrade`).

## 2. IDE Setup (VS Code Recommended)
   - **Requirement:** An IDE with Flutter support. Visual Studio Code is recommended.
   - **Essential Extensions (VS Code):**
     - `Dart`: Dart language support and debugger.
     - `Flutter`: Flutter support and utilities.
     - `Awesome Flutter Snippets`: Useful code snippets.
     - `Error Lens`: Highlights errors/warnings inline.
     - `Prettier - Code formatter` (Optional, but recommended for other file types if needed. `dart format` handles Dart files).
     - `Material Icon Theme` (Optional, for aesthetics).

## 3. Code Formatting
   - **Tool:** The standard `dart format` tool is used for formatting Dart code.
   - **Configuration:** It uses default Dart formatting rules.
   - **Usage:**
     - Configure your IDE to format on save for Dart files.
     - Manually run `dart format .` from the project root to format all Dart files.
   - **Consistency:** Ensure all committed code is formatted using `dart format`.

## 4. Linting (Static Analysis)
   - **Goal:** To enforce code style, identify potential errors, and improve code quality.
   - **Tool:** Dart's built-in analyzer, configured via `analysis_options.yaml`.
   - **Ruleset:** We use the `flutter_lints` package as a base, extended with stricter rules.
   - **Setup:**
     1.  Add `flutter_lints` to `dev_dependencies` in `pubspec.yaml`:
         ```yaml
         dev_dependencies:
           flutter_lints: ^2.0.1 # Or latest compatible version
           # other dev dependencies...
         ```
     2.  Run `flutter pub get`.
     3.  Create or update the `analysis_options.yaml` file in the project root with the following content:
         ```yaml
         include: package:flutter_lints/flutter.yaml

         analyzer:
           # Optional: Exclude generated files if necessary
           # exclude:
           #   - "**/*.g.dart"
           #   - "**/*.freezed.dart"
           errors:
             # Treat specific info-level issues as warnings or errors if desired
             # missing_required_param: warning

         linter:
           rules:
             # --- Rules inherited from flutter_lints ---
             # (No need to list them all here)

             # --- Additional stricter rules ---
             always_use_package_imports: true  # Enforce package imports over relative ones
             prefer_const_constructors: true     # Prefer const constructors where possible
             avoid_print: true                   # Discourage print statements in production code
             require_trailing_commas: true     # Enforce trailing commas for better formatting diffs
             # avoid_dynamic: true              # Consider enabling later for stricter typing
             # exhaustive_cases: true           # Ensure switch statements on enums are exhaustive

             # --- Potentially disable conflicting or noisy rules ---
             # e.g., if a specific rule conflicts with project style
         ```
   - **Usage:** The analyzer runs automatically in supported IDEs, highlighting issues. Run `flutter analyze` from the command line to check the entire project.

## 5. Environment Configuration
   - **Goal:** Manage environment-specific settings (e.g., API keys, feature flags, mock data toggle).
   - **Strategy:** Use a dedicated configuration file, potentially loaded based on build flavor or environment variables.
   - **Implementation (Example):**
     - Create `lib/config/env.dart`:
       ```dart
       // lib/config/env.dart
       class AppConfig {
         // TODO: Load these from actual environment variables or build flavors later
         static const bool useMockData = true; // TOGGLE FOR PROTOTYPE VS REAL
         static const String apiBaseUrl = useMockData
             ? 'mock://' // Placeholder for mock service identification
             : 'https://api.zinapp.com/v2'; // Example real API URL
         // Add other config variables (API keys, etc.)
       }
       ```
     - Access configuration via `AppConfig.useMockData`, `AppConfig.apiBaseUrl`, etc.
   - **Note:** This is a basic approach. For more complex scenarios, packages like `flutter_dotenv` or Flutter's build flavors can be used. This strategy will be further detailed in `V2_DATA_HANDLING.md`.

## 6. Git Workflow
   - **Main Branch:** The primary development branch is likely `main` or `develop` now. (*Please verify the current primary branch name.*) All feature branches should be based on and merged back into this primary branch.
   - **Feature Branches:** Create feature branches off the primary development branch for all new work (e.g., `feature/booking-screen`, `fix/login-bug`, `docs/update-readme`). Use descriptive names.
   - **Commits:** Write clear, concise commit messages. Following Conventional Commits ([https://www.conventionalcommits.org/](https://www.conventionalcommits.org/)) is recommended (e.g., `feat: Add stylist profile screen`, `fix: Correct login validation`, `docs: Update animation system`).
   - **Pull Requests:** Use Pull Requests (PRs) to merge feature branches back into the primary development branch. Code reviews are encouraged/required for collaboration.
   - **Pushing:** Ensure code is formatted (`dart format .`) and analyzed (`flutter analyze` - ensure 0 issues) before pushing. Pull the latest changes from the primary development branch (`git pull origin [primary-branch-name]`) into your feature branch before pushing and creating a PR to minimize conflicts.

## 7. Dependencies
   - Manage dependencies using `pubspec.yaml`.
   - Run `flutter pub get` after modifying `pubspec.yaml`.
   - Regularly update dependencies using `flutter pub upgrade` (check for breaking changes).
