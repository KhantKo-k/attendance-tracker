#!/bin/bash

# === Config ===
FLAVOR=$1

if [ -z "$FLAVOR" ]; then
  echo "❌ Please provide a flavor"
  exit 1
fi

# Set export method based on flavor
# if [ ["$FLAVOR" == "prod" || "$FLAVOR" == "preprod" ]]; then
#   EXPORT_METHOD="app-store"
# else
#   EXPORT_METHOD="development"
# fi

DART_DEFINE_ENV="appEnv=$FLAVOR"
DSYM_PATH="./build/ios/archive/Runner.xcarchive/dSYMs"
DEBUG_SYMBOLS_PATH="./debug-symbols/ios"
EXPORT_OPTIONS_PATH="./export-options/export-options-$FLAVOR.plist"

echo "🚀 Building IPA for flavor: $FLAVOR with export method: $EXPORT_METHOD"

# === Build IPA ===
if [ "$FLAVOR" == "prod" ]; then
  flutter build ipa \
    --flavor $FLAVOR \
    --release \
    --export-options-plist=$EXPORT_OPTIONS_PATH \
    --dart-define=$DART_DEFINE_ENV \
    --obfuscate \
    --split-debug-info=$DEBUG_SYMBOLS_PATH
else
  flutter build ipa \
    --flavor $FLAVOR \
    --release \
    --export-method="development" \
    --dart-define=$DART_DEFINE_ENV \
    --obfuscate \
    --split-debug-info=$DEBUG_SYMBOLS_PATH
fi

echo "📦 IPA build complete. Uploading dSYMs to Crashlytics..."

# === Upload dSYMs ===
find $DSYM_PATH -name "*.dSYM" -exec \
  ./ios/Pods/FirebaseCrashlytics/upload-symbols \
  -gsp ./ios/flavors/$FLAVOR/GoogleService-Info.plist \
  -p ios {} \;

echo "✅ dSYMs uploaded."

# === Dart symbols info (optional) ===
if [ -d "$DEBUG_SYMBOLS_PATH" ]; then
  echo "📄 Dart symbol files generated at $DEBUG_SYMBOLS_PATH"
fi
