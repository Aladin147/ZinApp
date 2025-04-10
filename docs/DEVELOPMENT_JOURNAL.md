# ZinApp V2 - Development Journal

This journal provides a chronological log of development activities, significant decisions, challenges encountered, and solutions implemented during the ZinApp V2 project.

---

## 2025-04-10

*   **Entry:** Initial setup of the new Flutter project (`zinapp_v2`) completed after resolving Flutter SDK installation and PATH issues. Project initialized, base directory structure created, linter configured, `.gitignore` added.
*   **Entry:** Copied V2 specification documents (Architecture, Brand Identity, Components, etc.) from the old project structure into `zinapp_v2/docs/v2`.
*   **Entry:** Implemented the core V2 theme system (`ThemeData`, `ColorScheme`, `TextTheme`) in `lib/app/theme/`. Declared Urbanist font assets in `pubspec.yaml`. Applied the theme in `main.dart`.
*   **Decision:** Confirmed Flutter as the target platform for V2, adopting a rebuild strategy instead of porting from React Native. (Ref: `docs/v2/V2_MIGRATION_GUIDE.md`)
*   **Decision:** Chose Riverpod as the primary state management solution. (Ref: `docs/v2/V2_ARCHITECTURE.md`)
*   **Decision:** Selected Urbanist as the primary font. (Ref: `docs/v2/V2_TYPOGRAPHY_SYSTEM.md`)
*   **Decision:** Adopted an `ApiService` abstraction for data handling. (Ref: `docs/v2/V2_DATA_HANDLING.md`)
*   **Challenge:** Encountered issues running `flutter create` via the execution tool due to environment/PATH problems. Required manual SDK installation verification and running `flutter create .` directly.
*   **Next:** Setting up the remaining living documentation files (Known Issues, Decisions, etc.). Planning the first implementation steps (API service abstraction, core widgets).

---
