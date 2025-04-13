#!/bin/bash

# Add the modified files
git add lib/data/datasources/remote/user_remote_data_source.dart
git add lib/data/repositories/auth_repository_impl.dart

# Create commit message
echo "fix(auth): implement user creation in mock backend for registration

Updates UserRemoteDataSource.createUser to accept password and construct
the full payload expected by db.json (including default profile fields).
Updates AuthRepository.register to call the corrected createUser method.

This ensures a user record is actually created in the mock backend during
registration, allowing the subsequent profile fetch in AuthProvider to succeed." > register_fix_commit_msg.txt

# Commit with the message
git commit -F register_fix_commit_msg.txt

# Clean up
rm register_fix_commit_msg.txt

# (Optional) Push to remote repository - uncomment if needed
# git push origin your-branch-name
