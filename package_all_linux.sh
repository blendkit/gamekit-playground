#!/bin/bash

### CONFIG
### To package web,android and blackberry following environment-variables have to be set
### android: 'ANDROID_HOME' have to be set to the root of the android-sdk 
###  https://developer.android.com/studio/index.html ( only the commandline tools )
###
### emscripten: 'emsdk' have to be set to the root of the portable-sdk
###  https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html
###
### blackberry: 'bb_bb10_ndk' and 'bb_playbook_ndk' have to be set to the roots of the bb10- and playbook-ndks 
###  bb10	: https://developer.blackberry.com/native/downloads/
###  playbook	: https://developer.blackberry.com/playbook/native/download/
####

echo "VARCHECK:"
echo "emsdk: $emsdk"
echo "ANDROID_HOME: $ANDROID_HOME"
echo "bb_bb10_ndk: $bb_bb10_ndk"
echo "bb_playbook_ndk: $bb_playbook_ndk"
echo "--------------------------------------------"

NAME=$1
if [ "$NAME" = "" ]; then
  NAME="Game"
fi

CALL_FOLDER=$PWD
echo "CALL FOLDER $CALL_FOLDER"

if [ -d "_temp_project" ]; then
	rm -Rf _temp_project
fi

cp -r project _temp_project
cd _temp_project
rm *.blend1 *.blend2 *.blend3 2> /dev/null
mv project.blend game.dat
cd ..

if [ ! -d "_package" ]; then
  mkdir _package
fi

## Linux / Windows
rm -Rf _package/* ?2>/dev/null
cp -r _temp_project _package/$NAME-linux
cp runtimes/linux/AppOgreKit _package/$NAME-linux/$NAME
cp -r _temp_project _package/$NAME-windows
cp runtimes/windows/AppOgreKit.exe _package/$NAME-windows/$NAME.exe
cp -r runtimes/web _package/$NAME-web

cd _package
zip -r $NAME-linux.zip $NAME-linux
zip -r $NAME-win.zip $NAME-windows

## web / emscripten
if [ "$emsdk" != "" ]; then
    source $emsdk/emsdk_env.sh
    cp -r $CALL_FOLDER/runtimes/web $NAME-web
    cd $CALL_FOLDER/_temp_project
    cp game.dat project.blend
    python $EMSCRIPTEN/tools/file_packager.py ../_package/$NAME-web/project.data --js-output=../_package/$NAME-web/loader.js --preload . 
    cd ../_package
    mv $NAME-web/bbkit.html $NAME-web/$NAME.html
	zip -r $NAME-web.zip $NAME-web
else
	echo "Skipping Web! Install emscripten and set emsdk-environment-variable to the emsdk-portable-root:\n( https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html )"
fi

## ANDROID
if [ "$ANDROID_HOME" != "" ]; then
	cd $CALL_FOLDER/runtimes/android/assets
	rm -Rf $CALL_FOLDER/runtimes/android/assets/*
	cp -r $CALL_FOLDER/_temp_project/* .
	cp ../res.cfg .
	cd ..
	./gradlew assembleDebug
	mv build/outputs/apk $CALL_FOLDER/_package/$NAME-android
	cp $CALL_FOLDER/_package/$NAME-android/android-debug.apk $CALL_FOLDER/_package/$NAME-android.apk
else
       	echo "Skipping Android! Install Android-SDK and set ANDROID_HOME-Environment-Variable to this SDK-Root-Folder"
fi

## Blackberry Playbook
if [ "$bb_playbook_ndk" != "" ]; then
	source $bb_playbook_ndk/bbndk-env.sh
	cd $CALL_FOLDER/runtimes/blackberry-playbook
	echo "CALL FOLDER $CALL_FOLDER"
	blackberry-nativepackager -package ../../_package/$NAME-playbook.bar -devMode bar-descriptor.xml
else
	echo "Skipping blackberry playbook. Please install the playbook NDK and set bb_playbook_ndk-environment variable to the root of the playbook-ndk.\nhttps://developer.blackberry.com/playbook/native/download/"
fi
## Blackberry bb10
if [ "$bb_bb10_ndk" != "" ]; then
	source $bb_bb10_ndk/bbndk-env_10_3_1_995.sh
	cd $CALL_FOLDER/runtimes/blackberry-bb10
	echo "CALL FOLDER $CALL_FOLDER"
	blackberry-nativepackager -package ../../_package/$NAME-bb10.bar -devMode bar-descriptor.xml
else
	echo "Skipping blackberry os 11. Please install the NDK and set the bb_bb10_ndk-environment variable to the root of the bb10-ndk.\nhttps://developer.blackberry.com/native/downloads/"
fi

