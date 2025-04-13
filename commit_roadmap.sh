#!/bin/bash

# Stage the new roadmap document
git add docs/EXPERIENCE_TRANSFORMATION_ROADMAP.md

# Commit with the prepared message
git commit -F commit_message_roadmap.txt

# Push to remote repository
git push origin full-riverpod-migration
