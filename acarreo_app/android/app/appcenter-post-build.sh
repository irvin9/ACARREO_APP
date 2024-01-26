#!/usr/bin/env bash
#Place this script in project/android/app/
cd ..
# fail if any command fails
set -e
# debug log
set -x

cd ..
# if you need build bundle (AAB) in addition to your APK, uncomment line below and last line of this script.
#flutter build appbundle --release --build-number $APPCENTER_BUILD_ID

# copy the APK where AppCenter will find it
# mkdir -p android/app/build/outputs/apk/; mv build/app/outputs/apk/release/app-release.apk $_

# copy the AAB where AppCenter will find it
mkdir -p android/app/build/outputs/bundle/
mv build/app/outputs/bundle/"$ENVIRONMENT"Release/app-"$ENVIRONMENT"-release.aab $_
