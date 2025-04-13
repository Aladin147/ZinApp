#!/bin/bash

# Add the modified UI files
git add lib/features/showcase/screens/riverpod_test_screen.dart
git add lib/features/home/screens/riverpod/dashboard_home_screen.dart
git add lib/features/home/screens/riverpod/enhanced_home_screen.dart
git add lib/features/profile/screens/riverpod/dashboard_profile_screen.dart
git add lib/features/profile/screens/riverpod/profile_edit_screen.dart
git add lib/features/profile/screens/riverpod/game_profile_screen.dart
git add lib/features/profile/screens/riverpod/profile_screen.dart
git add lib/features/rewards/screens/token_shop_screen.dart
git add lib/features/rewards/widgets/token_shop_card.dart

# Create commit message
echo "fix(ui): resolve UserProfile access errors in UI components

Updates various screens and widgets to correctly handle the nullable
UserProfile object now present in AuthState. Uses null-safe accessors (?.)
and provides default values where necessary to prevent build errors.

Files updated:
- riverpod_test_screen.dart
- dashboard_home_screen.dart
- enhanced_home_screen.dart
- dashboard_profile_screen.dart
- profile_edit_screen.dart
- game_profile_screen.dart
- profile_screen.dart
- token_shop_screen.dart
- token_shop_card.dart

This resolves the build errors caused by the AuthState refactoring." > ui_type_fixes_commit_msg.txt

# Commit with the message
git commit -F ui_type_fixes_commit_msg.txt

# Clean up
rm ui_type_fixes_commit_msg.txt

# (Optional) Push to remote repository - uncomment if needed
# git push origin your-branch-name
