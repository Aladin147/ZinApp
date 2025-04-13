#!/bin/bash

# Add the updated documentation files
git add docs/TODO.md
git add docs/DEVELOPMENT_JOURNAL.md

# Create commit message
echo "docs: update TODO and Journal for Sprint 1 completion

- Updates TODO.md to mark Sprint 1 tasks as complete and outline Sprint 2.
- Adds a new entry to DEVELOPMENT_JOURNAL.md summarizing Sprint 1 progress." > docs_update_commit_msg.txt

# Commit with the message
git commit -F docs_update_commit_msg.txt

# Clean up
rm docs_update_commit_msg.txt

# (Optional) Push to remote repository - uncomment if needed
# git push origin your-branch-name
