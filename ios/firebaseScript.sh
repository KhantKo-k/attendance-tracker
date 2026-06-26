if [ "$CONFIGURATION" == "Debug-mock" ] || [ "$CONFIGURATION" == "Release-mock" ]; then
  cp Runner/mock/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-dev" ] || [ "$CONFIGURATION" == "Release-dev" ]; then
  cp Runner/dev/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-uat" ] || [ "$CONFIGURATION" == "Release-uat" ]; then
  cp Runner/uat/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-preprod" ] || [ "$CONFIGURATION" == "Release-preprod" ]; then
  cp Runner/preprod/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-prod" ] || [ "$CONFIGURATION" == "Release-prod" ]; then
  cp Runner/prod/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi

