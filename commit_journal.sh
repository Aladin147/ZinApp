#!/bin/bash

# Stage the journal entry
git add docs/journal/2025-04-12-experience-transformation-planning.md

# Commit with the prepared message
git commit -F commit_journal.txt

# Push to remote repository
git push origin full-riverpod-migration
