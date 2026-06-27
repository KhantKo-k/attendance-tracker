if [ "$CONFIGURATION" == "Debug-local" ] || [ "$CONFIGURATION" == "Release-local" ]; then
  cp Runner/local/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-staging" ] || [ "$CONFIGURATION" == "Release-staging" ]; then
  cp Runner/staging/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-production" ] || [ "$CONFIGURATION" == "Release-production" ]; then
  cp Runner/production/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi
