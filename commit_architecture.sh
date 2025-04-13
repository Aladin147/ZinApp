#!/bin/bash

# Stage the new directories and README files
git add lib/ui/
git add lib/sim/
git add lib/data/

# Commit with the prepared message
git commit -F commit_architecture.txt

# Push to remote repository
git push origin full-riverpod-migration
