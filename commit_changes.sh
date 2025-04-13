#!/bin/bash

# Stage the modified files
git add lib/features/rewards/widgets/daily_rewards_card.dart
git add lib/features/stylist/widgets/riverpod/stylist_carousel.dart
git add lib/services/booking_service.dart
git add lib/services/feed_service.dart
git add lib/services/mock_api_service.dart
git add lib/widgets/accessibility_aware_text.dart

# Stage the updated documentation
git add docs/journal/2025-04-12-technical-debt-resolution-phase7.md
git add docs/KNOWN_ISSUES.md
git add docs/journal/2025-04-12-status-report.md

# Commit with the prepared message
git commit -F commit_message.txt

# Push to remote repository
git push origin full-riverpod-migration
