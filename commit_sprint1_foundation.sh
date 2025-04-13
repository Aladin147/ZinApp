#!/bin/bash

# Add the new/modified files for testing, persistence, datasources, models, auth
git add test/widget/components/zin_button_test.dart
git add lib/services/local_storage_service.dart
git add data/db.json
git add start_json_server.bat
git add pubspec.yaml
git add lib/data/datasources/remote/user_remote_data_source.dart
git add lib/data/datasources/remote/stylist_remote_data_source.dart
git add lib/data/datasources/remote/post_remote_data_source.dart
git add lib/data/datasources/remote/comment_remote_data_source.dart
git add lib/data/datasources/remote/booking_remote_data_source.dart
git add lib/data/datasources/remote/gamification_remote_data_source.dart
git add lib/models/badge.dart
git add lib/models/badge.g.dart
git add lib/models/challenge.dart
git add lib/models/challenge.g.dart
git add lib/features/auth/screens/login_screen.dart
git add lib/data/repositories/auth_repository_impl.dart
git add lib/models/auth_state.dart
git add lib/features/auth/providers/riverpod/auth_provider.dart
git add lib/features/auth/providers/riverpod/auth_provider.g.dart

# Create commit message
echo "feat: implement Sprint 1 foundation tasks

Implements key foundational elements based on the revised plan:
- Adds basic widget test for ZinButton.
- Creates LocalStorageService using shared_preferences.
- Updates db.json with challenges and streak fields.
- Adds Windows script for json-server and starts server.
- Adds dio dependency.
- Creates RemoteDataSource interfaces and implementations for User, Stylist, Post, Comment, Booking, and Gamification entities, connecting to json-server.
- Creates Badge and Challenge models.
- Scaffolds LoginScreen UI.
- Implements AuthRepository to connect AuthProvider to datasources.
- Updates AuthProvider to use AuthRepository.
- Temporarily modifies AuthState to use User instead of UserProfile (TODO: Refactor).
- Runs build_runner to generate necessary files.

This completes the setup for the mock backend, persistence, and basic auth flow scaffolding." > sprint1_commit_msg.txt

# Commit with the message
git commit -F sprint1_commit_msg.txt

# Clean up
rm sprint1_commit_msg.txt

# (Optional) Push to remote repository - uncomment if needed
# git push origin your-branch-name
