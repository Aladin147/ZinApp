#!/bin/bash

# Add all the journal files
git add docs/journal/2025-04-15-technical-debt-resolution-phase7.md
git add docs/journal/2025-04-20-three-layer-architecture-phase2.md
git add docs/journal/2025-04-25-three-layer-architecture-phase3.md
git add docs/journal/2025-05-01-integration-migration-strategy.md
git add docs/journal/2025-05-05-component-system-standards.md
git add docs/journal/2025-05-10-performance-benchmarking.md

# Create a commit message
echo "docs: complete remaining journal entries

This commit adds the six remaining journal entries that were identified
in the analysis document. These entries complete the documentation of
our architectural transformation and technical debt resolution efforts:

1. Technical Debt Resolution (Phase 7) - April 15, 2025
2. Three-Layer Architecture (Phase 2) - April 20, 2025
3. Three-Layer Architecture (Phase 3) - April 25, 2025
4. Integration and Migration Strategy - May 1, 2025
5. Component System Standards - May 5, 2025
6. Performance Benchmarking - May 10, 2025

Each journal provides comprehensive documentation with code examples,
metrics, and insights into our architectural transformation process." > remaining_journals_commit_msg.txt

# Commit with the message
git commit -F remaining_journals_commit_msg.txt

# Clean up
rm remaining_journals_commit_msg.txt

# Push to remote repository
git push origin full-riverpod-migration
