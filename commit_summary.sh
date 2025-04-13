#!/bin/bash

# Stage the summary journal file
git add docs/journal/2025-04-12-experience-transformation-summary.md

# Create a commit message
echo "docs: add experience transformation summary report

This summary report:
- Consolidates progress on the Experience Transformation Roadmap
- Documents the relationship to the completed Technical Debt Resolution
- Outlines planned future journal entries
- Identifies implementation challenges and approaches
- Defines immediate next steps across all three layers

This serves as a comprehensive reference for the team and stakeholders
to understand our current position and future direction in the transformation." > temp_summary_msg.txt

# Commit with the message
git commit -F temp_summary_msg.txt

# Clean up
rm temp_summary_msg.txt

# Push to remote repository
git push origin full-riverpod-migration
