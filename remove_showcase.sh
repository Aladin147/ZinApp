#!/bin/bash

# Remove the showcase screen and main entry point files
git rm lib/ui/screens/component_showcase_screen.dart
git rm lib/main_component_showcase.dart

# Commit with the prepared message
git commit -F commit_remove_showcase.txt

# Push to remote repository
git push origin full-riverpod-migration
