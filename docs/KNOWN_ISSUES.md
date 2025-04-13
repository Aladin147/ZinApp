# ZinApp V2 - Known Issues

This document tracks identified bugs, limitations, or areas needing improvement during the V2 development.

| ID | Issue Description                                  | Priority | Status   | Date Reported | Notes / Resolution                                                                 |
|----|----------------------------------------------------|----------|----------|---------------|------------------------------------------------------------------------------------|
| 01 | Android Toolchain/SDK not yet installed            | Medium   | Open     | 2025-04-10    | Required for Android builds/testing. Install Android Studio & SDK components. (Verify local setup) |
| 02 | Mock API write operations not fully implemented    | Medium   | Open     | 2025-04-10    | `MockApiService` currently reads JSON but doesn't persist updates (e.g., XP changes). Needs implementation if mock writes are required. |
| 03 | Responsive typography scaling not implemented    | Low      | Open     | 2025-04-10    | Base text styles defined, but optional scaling logic needs implementation if required for different screen sizes. |
| 04 | Core dependencies (Riverpod, go_router) not added | High     | Resolved | 2025-04-10    | Resolved during initial setup and Phase 3 (Riverpod Migration). Packages added to `pubspec.yaml`. |
| 05 | Layout overflow errors in various screens        | Medium   | Open     | 2025-04-12    | Multiple `RenderFlex overflowed` errors in user_status_card.dart and other widgets. Non-critical UI issues needing layout fixes. |
|    |                                                    |          |          |               |                                                                                    |

*(Add new issues as they are identified. Review existing 'Open' issues to confirm they are still relevant after refactoring.)*
