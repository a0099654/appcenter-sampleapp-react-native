#!/usr/bin/env bash

HOCKEYAPP_API_TOKEN={API_Token}
HOCKEYAPP_APP_ID={APP_ID}

# Example: Upload master branch app binary to HockeyApp using the API
if [ "$APPCENTER_BRANCH" == "master" ];
then
    curl \
    -F "status=2" \
    -F "ipa=@$APPCENTER_OUTPUT_DIRECTORY/MyApps.ipa" \
    -H "X-HockeyAppToken: $HOCKEYAPP_API_TOKEN" \
    https://rink.hockeyapp.net/api/2/apps/$HOCKEYAPP_APP_ID/app_versions/upload
else
    echo "Current branch is $APPCENTER_BRANCH"
fi

# Steps to download detox
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew install node

brew tap wix/brew
brew install applesimutils

yarn global add detox-cli

detox build

detox test
