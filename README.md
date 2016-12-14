# gamekit-playground

Disclaimer
----------
Before you even start: The version of gamekit these runtimes are based on is more than fragile and were more my playing-field for integrating libs and experimenting and such without worrying to make it super clean. Lots of things do work, but others do not or not as intended. **If you expect a 100% working engine with full support go to unity3d or unreal-engine.**

**The sourcecode is not opensourced,yet. But will be very soon.**  
**No osx version at the moment,sry. Couldn't get a renderwindow to open. Use wine and the windows-version for now :)**

getting started
---------------

* Download this repository
* Startup blender: File=>User Preferences=>Add-Ons=>Install from File=>[navigate to the playground-folder's blender-addon] and choose blenderaddon.zip or the experimental version.
* Select gamekit-renderer. On top where you see "Blender Render" choose "Gamekit".
* On the Render-Panel under "Gamekit Runtime" choose the runtime file-icon and navigate to the playground=>runtimes=>your os=>**AppOgreKit** or **AppOgreKit.exe**  
* Save your blend before starting the engine. Otherwise it will not work...
* Press start


Auto-Packaging of all supported Platforms(win,lin,android,bb10,playbook,web)
-------------------------------

##What you need?
 
First of all you need to create your gamekit-project inside the playground-**project folder** and name you master-blend **project.blend**


**Deploying:**

Linux- and windows-package-creation should work out of the box. 
**linux:** just starting "./package_all_linux.sh [gamename]" will produce a folder named _package
where you will find zips with the game-pack.  
**windows:** starting  "./package_win.bat" will call the linux version with the help of a windows-bash (no zips are created and not really tested)

In order for the other platforms to work, you need to install their SDKs:

**For web**:
Install emscripten-sdk: https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html
And set the environment-variable 'emsdk' to the root of the emsdk-portable-root.

For **bb-playbook** set 'bb_playbook_ndk' to the root of the playbook-ndk: https://developer.blackberry.com/playbook/native/download/
For **bb-bb10** set 'bb_bb10_ndk' to the root of the bb10-ndk : https://developer.blackberry.com/native/downloads/
For **android**: set ANDROID_HOME to the root of the Android-SDK : https://developer.android.com/studio/index.html ( only the command-line tools ) 


I know these instructions might be a bit confusing but it is a first version. Feel free to contribute.

There are some docs for the lua-api in docs/lua-api-folder (search the index.html). Not optimal but better than nothing.

For Questions: Please refer to the forum at http://gamekit.org or visit http://thomas.trocha.com/pebble/pages/gamekit-index.html
