#!/usr/bin/env bash

cd ../..
# Remove old builds
rm -rf output/*.apk
# Clean and build
flutter clean
flutter build apk --split-per-abi
# Copy APKs to root of project
mkdir -p output
cp build/app/outputs/apk/release/app-armeabi-v7a-release.apk output/LunaSea-armeabi-v7a-release.apk
cp build/app/outputs/apk/release/app-arm64-v8a-release.apk output/LunaSea-arm64-v8a-release.apk
cp build/app/outputs/apk/release/app-x86_64-release.apk output/LunaSea-x86_64-release.apk
# Remove build files
rm -rf build
