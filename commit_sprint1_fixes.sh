#!/bin/bash

# Add the modified files
git add lib/models/auth_state.dart
git add lib/data/datasources/remote/user_profile_remote_data_source.dart
git add lib/data/repositories/user_profile_repository_impl.dart
git add lib/features/auth/providers/riverpod/auth_provider.dart
git add lib/features/auth/providers/riverpod/auth_provider.g.dart # Add generated file

# Create commit message
echo "fix: resolve User/UserProfile type mismatch for Sprint 1

Reverts the temporary change to AuthState, ensuring it correctly expects UserProfile.
Creates UserProfileRemoteDataSource and UserProfileRepository.
Refactors AuthProvider to use the new repositories and outlines the
correct two-step authentication flow (fetch User, then fetch UserProfile).
Runs build_runner to regenerate code.

Note: This resolves build errors related to AuthProvider but leaves expected
type errors in UI components that incorrectly access profile data from AuthState.
These will be addressed in Sprint 2 by implementing UserProfile fetching and
potentially a dedicated UserProfileProvider." > sprint1_fixes_commit_msg.txt

# Commit with the message
git commit -F sprint1_fixes_commit_msg.txt

# Clean up
rm sprint1_fixes_commit_msg.txt

# (Optional) Push to remote repository - uncomment if needed
# git push origin your-branch-name
