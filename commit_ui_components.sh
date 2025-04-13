#!/bin/bash

# Stage the modified files
git add lib/ui/components/zin_button.dart
git add lib/ui/components/zin_card.dart
git add lib/ui/components/zin_text_field.dart
git add lib/ui/screens/component_showcase_screen.dart
git add lib/main_component_showcase.dart
git add docs/journal/2025-04-13-three-layer-architecture-phase1.md

# Create a commit message
echo "feat: implement UI layer components for three-layer architecture

This commit adds the core UI layer components as part of Phase 1 of our Experience Transformation Roadmap:

- ZinButton: A customizable button component with variants, icons, states, and animations
- ZinCard: A versatile card component with various styling options and structure
- ZinTextField: A comprehensive text field with different styling variants and states
- Component Showcase: A dedicated screen to display and interact with all UI components
- Standalone Showcase: A separate main entry point to run just the component showcase

These components form the foundation of our new three-layer architecture, 
providing a clean separation between presentation (UI), business logic (Simulation), 
and data (Models/Repositories). The components are fully documented and demonstrated
in an interactive showcase.

This implementation follows the architecture outlined in the experience
transformation planning journal." > temp_ui_components_msg.txt

# Commit with the message
git commit -F temp_ui_components_msg.txt

# Clean up
rm temp_ui_components_msg.txt

# Push to remote repository
git push origin full-riverpod-migration
