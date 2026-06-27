#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

switch_firebase_project() {
    local project=$1
    echo "Switching to Firebase project: $project"
    firebase use --project $project
}

if [[ $# -eq 0 ]]; then
    echo "Error: No environment specified. Use 'local', 'staging', or 'production'."
    exit 1
fi

case $1 in
    local|staging|production)
        # Switch to main project
        switch_firebase_project "attendance-tracker-d696e"
        flutterfire config \
            --project=attendance-tracker-d696e \
            --out=lib/firebase_options_$1.dart \
            --ios-bundle-id=com.kkz.attendance-tracker.$1 \
            --ios-out=ios/Runner/$1/GoogleService-Info.plist \
            --android-package-name=com.kkz.attendance_tracker.$1 \
            --android-out=android/app/src/$1/google-services.json
        ;;
    *)
        echo "Error: Invalid environment specified. Use 'local', 'staging', or 'production'."
        exit 1
        ;;
esac
