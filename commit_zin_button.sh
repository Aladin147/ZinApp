#!/bin/bash

# Stage the new component files
git add lib/ui/components/zin_button.dart
git add lib/ui/screens/component_showcase_screen.dart
git add lib/main_component_showcase.dart

# Commit with the prepared message
git commit -F commit_zin_button.txt

# Push to remote repository
git push origin full-riverpod-migration
