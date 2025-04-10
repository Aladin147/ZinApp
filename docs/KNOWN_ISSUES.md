# ZinApp V2 - Known Issues

This document tracks identified bugs, limitations, or areas needing improvement during the V2 development.

| ID | Issue Description                                  | Priority | Status   | Date Reported | Notes / Resolution                                                                 |
|----|----------------------------------------------------|----------|----------|---------------|------------------------------------------------------------------------------------|
| 01 | Android Toolchain/SDK not yet installed            | Medium   | Open     | 2025-04-10    | Required for Android builds/testing. Install Android Studio & SDK components.      |
| 02 | Mock API write operations not fully implemented    | Medium   | Open     | 2025-04-10    | `MockApiService` currently reads JSON but doesn't persist updates (e.g., XP changes). |
| 03 | Responsive typography scaling not implemented    | Low      | Open     | 2025-04-10    | Base text styles defined, but optional scaling logic needs implementation if required. |
| 04 | Core dependencies (Riverpod, go_router) not added | High     | Open     | 2025-04-10    | Need to add state management and routing packages to `pubspec.yaml`.             |
|    |                                                    |          |          |               |                                                                                    |

*(Add new issues as they are identified)*
