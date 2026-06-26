#!/bin/bash

# === Config ===
BUILD_TYPE=$1
FLAVOR=$2

# Validate required parameters
if [ -z "$BUILD_TYPE" ] || [ -z "$FLAVOR" ]; then
  echo "❌ Usage: $0 <BUILD_TYPE> <FLAVOR>"
  echo "   BUILD_TYPE: apk or appbundle"
  echo "   FLAVOR: dev, mock, uat, preprod, or prod"
  exit 1
fi

# Validate BUILD_TYPE
if [ "$BUILD_TYPE" != "apk" ] && [ "$BUILD_TYPE" != "appbundle" ]; then
  echo "❌ Invalid BUILD_TYPE: $BUILD_TYPE"
  echo "   BUILD_TYPE: apk, appbundle"
  exit 1
fi

# Function to get Firebase app ID based on flavor
get_firebase_app_id() {
  local flavor=$1
  if [ "$FLAVOR" == "prod" ]; then
    local package_name="com.ksta.app_starter_kit_bloc"
  else
    local package_name="com.ksta.app_starter_kit_bloc.$flavor"
  fi
  local google_services_path="android/app/src/$flavor/google-services.json"

  if [ ! -f "$google_services_path" ]; then
    echo "❌ google-services.json not found for flavor: $flavor"
    exit 1
  fi

  local app_id=$(jq -r --arg PACKAGE_NAME "$package_name" '
    .client[] 
    | select(.client_info.android_client_info.package_name == $PACKAGE_NAME) 
    | .client_info.mobilesdk_app_id
  ' "$google_services_path")

  if [ -z "$app_id" ] || [ "$app_id" == "null" ]; then
    echo "❌ Unable to extract Firebase App ID for package: $package_name"
    exit 1
  fi

  echo "$app_id"
}

DART_DEFINE_ENV="appEnv=$FLAVOR"
DEBUG_SYMBOLS_PATH="./debug-symbols/android"
APP_ID=$(get_firebase_app_id "$FLAVOR")

echo "🚀 Building $BUILD_TYPE for flavor: $FLAVOR"
echo "🔥 Firebase App ID: $APP_ID"

# === Build APK/AAB ===
flutter build $BUILD_TYPE \
  --release \
  --flavor=$FLAVOR \
  --dart-define=$DART_DEFINE_ENV \
  --obfuscate \
  --split-debug-info=$DEBUG_SYMBOLS_PATH

# === Upload symbols ===
echo "📤 Uploading debug symbols to Firebase Crashlytics..."
firebase crashlytics:symbols:upload --app=$APP_ID $DEBUG_SYMBOLS_PATH

echo "✅ Symbols uploaded successfully"