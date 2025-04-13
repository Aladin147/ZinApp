#!/bin/bash

# ZinApp V2 - Code Generation Script
# This script runs the build_runner to generate code for JSON serialization and other code generation needs.

echo "Running code generation for ZinApp V2..."

# Run build_runner in watch mode
flutter pub run build_runner build --delete-conflicting-outputs

echo "Code generation complete!"
