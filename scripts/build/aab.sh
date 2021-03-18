#!/usr/bin/env bash

# Remove old builds
rm -rf output/*.aab
# Clean and build
flutter clean
flutter build appbundle
# Copy APKs to root of project
mkdir -p output
cp build/app/outputs/bundle/release/app-release.aab output/LunaSea-release.aab
# Remove build files
rm -rf build
