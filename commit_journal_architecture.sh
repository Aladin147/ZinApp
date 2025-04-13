#!/bin/bash

# Stage the journal file
git add docs/journal/2025-04-12-experience-transformation-architecture.md

# Create a commit message
echo "docs: add experience transformation architecture journal entry

This journal documents the initial implementation of the three-layer architecture
as outlined in the Experience Transformation Roadmap:
- UI Layer for pure presentation components
- Simulation Layer for business logic
- Data Layer for data access and models

It explains the design decisions, challenges, and next steps in the transformation process." > temp_commit_msg.txt

# Commit with the message
git commit -F temp_commit_msg.txt

# Clean up
rm temp_commit_msg.txt

# Push to remote repository
git push origin full-riverpod-migration
