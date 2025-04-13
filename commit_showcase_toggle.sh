#!/bin/bash

# Stage the modified files
git add lib/main.dart lib/providers/showcase_mode_provider.dart lib/widgets/showcase_toggle_button.dart lib/features/showcase/screens/component_showcase_screen.dart

# Create a commit message
echo "feat: implement showcase/app toggle mechanism

This commit:
- Adds a showcase mode provider to track and persist mode state with SharedPreferences
- Creates a floating action button for toggling between app and showcase modes
- Updates main.dart to conditionally display either the app or component showcase
- Enhances the component showcase to include the new three-layer architecture components

This implements the first step in our Experience Transformation Roadmap by providing
a way to easily access both the app and component showcase during development." > temp_showcase_msg.txt

# Commit with the message
git commit -F temp_showcase_msg.txt

# Clean up
rm temp_showcase_msg.txt

# Push to remote repository
git push origin full-riverpod-migration
