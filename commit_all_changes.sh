#!/bin/bash

# Add all new and modified files related to the three-layer architecture
git add lib/ui/components/zin_button.dart
git add lib/ui/components/zin_card.dart
git add lib/ui/components/zin_text_field.dart
git add lib/ui/screens/component_showcase_screen.dart
git add lib/main_component_showcase.dart
git add docs/journal/2025-04-13-three-layer-architecture-phase1.md

# Add documentation files
git add docs/journal/2025-04-27-technical-debt-resolution-phase6.md
git add lib/ui/README.md
git add lib/sim/README.md
git add lib/data/README.md

# Add utility files
git add lib/utils/image_utils.dart

# Create commit message
echo "feat: implement three-layer architecture foundation

This commit introduces the foundation for our new three-layer architecture as outlined in the experience transformation roadmap:

1. UI Layer Components:
   - ZinButton: Customizable button with variants, animations and states
   - ZinCard: Versatile card component with multiple styling options
   - ZinTextField: Text input component with various styling variants

2. Architecture Structure:
   - Created dedicated directories for UI, Simulation, and Data layers
   - Added documentation for each layer

3. Component Showcase:
   - Implemented a dedicated screen for displaying and testing UI components
   - Added standalone entry point for easier component testing

4. Documentation:
   - Added technical documentation for the three-layer architecture
   - Created journal entry documenting the implementation process

This represents Phase 1 of the architecture transformation, focusing on
establishing the foundational UI components that strictly separate
presentation from business logic." > commit_message_all.txt

# Commit with the message
git commit -F commit_message_all.txt

# Clean up
rm commit_message_all.txt

# Push to remote repository
git push origin full-riverpod-migration
