#!/bin/bash

# Add the modified files
git add lib/features/rewards/screens/token_shop_screen.dart
git add lib/features/rewards/widgets/achievements_card.dart
git add lib/features/rewards/widgets/challenges_card.dart
git add lib/features/home/widgets/trending_styles_card.dart

# Create commit message
echo "fix(ui): Apply initial fixes for layout overflows

Addresses critical overflow issues reported in feedback:
- Wraps TokenShopScreen body with SafeArea.
- Wraps expandable content in AchievementsCard and ChallengesCard with SingleChildScrollView.
- Improves image error placeholder in TrendingStylesCard.

This is the first step towards resolving layout overflows across the app." > overflow_fixes_commit_msg.txt

# Commit with the message
git commit -F overflow_fixes_commit_msg.txt

# Clean up
rm overflow_fixes_commit_msg.txt

# (Optional) Push to remote repository - uncomment if needed
# git push origin your-branch-name
