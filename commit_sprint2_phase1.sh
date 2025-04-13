#!/bin/bash

# Add the new/modified files
git add lib/sim/gamification/gamification_state.dart
git add lib/sim/gamification/gamification_simulation.dart
git add lib/sim/gamification/gamification_simulation.g.dart # Add generated file
git add docs/DEVELOPMENT_JOURNAL.md
git add docs/TODO.md

# Create commit message
echo "feat(sim): implement initial gamification simulation logic (Sprint 2 Phase 1)

Implements the basic structure and core logic for the gamification system
within the simulation layer (lib/sim/), independent of the data layer for now.

- Creates GamificationState model.
- Creates GamificationSimulation Riverpod provider.
- Implements initial logic for:
  - Processing user actions (XP calculation, level-up checks, token awards).
  - Adding XP/Tokens directly.
  - Checking daily streaks.
  - Placeholder for unlocking achievements.
- Adds TODOs for challenge logic and data layer integration.
- Updates Development Journal and TODO list.
- Runs build_runner to generate code." > sprint2_phase1_commit_msg.txt

# Commit with the message
git commit -F sprint2_phase1_commit_msg.txt

# Clean up
rm sprint2_phase1_commit_msg.txt

# Push to remote repository
git push origin full-riverpod-migration
