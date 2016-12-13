# gamekit-playground

Disclaimer
----------
Before you even start: This version of gamekit these runtimes are based on is more than fragile and were more a playing field for me for integrating libs and such without the worry to make it super clean. Lots of things do work, but others do not or not as intended. **If you expect a 100% working engine with full support go to unity3d or unreal-engine.**

**The sourcecode is not opensourced,yet. But will be very soon.**  
**No osx version at the moment,sry. Couldn't get a renderwindow to open. Use wine and the windows-version for now :) **

getting started
---------------

* Download this repository
* Startup blender: File=>User Preferences=>Add-Ons=>Install from File=>[navigate to the playground-folder's blender-addon] and choose blenderaddon.zip or the experimental version.
* Select gamekit-renderer. On top where you see "Blender Render" choose "Gamekit".
* On the Render-Panel under "Gamekit Runtime" choose the runtime file-icon and navigate to the playground=>runtimes=>your os=>**AppOgreKit** or **AppOgreKit.exe**  
(**Sorry for not supporting mac-OSX at the moment**! I did try a complete night and day to get it to work. Without success. You can use wine on the windows-version though. Installing wine via brew did work for me)
* Save your blend before starting the engine. Otherwise it will not work...


Auto-Packaging of all supported Platforms(win,lin,android,bb10,playbook,web)
-------------------------------

##What you need?
 
First of all you need to create your gamekit-project inside the playground-project folder and name you master-blend project.blend


**Deploying:**

Linux and Windows should work out of the box. 
**linux:** just starting "./package_all_linux.sh [gamename]" will produce a folder named _package
where you will find zips with the game-pack.  
**windows:** starting  "./package_win.bat" will call the linux version with the help of a windows-bash (no zips are created)

In order for the other platforms to work, you need to install their SDKs:

**For web:**  
Install emscripten-sdk: https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html
And modify the package_all_linux.sh script to point to the emsdk-portable-root.

For **bb-playbook**: https://developer.blackberry.com/playbook/native/download/  
For **bb-bb10**: https://developer.blackberry.com/native/downloads/  
Also modify the package_all_linux.sh to point to the respective SDKs

For **android**:  
Modify the runtimes/android/local.properties to point to your SDK and NDK (not sure if you need the NDK at this point)


I know these instructions are very confuse but it is a first version. Feel free to contribute.

There are some docs for the lua-api in docs/lua-api-folder (search the index.html). Not optimal but better than nothing.

For Questions: Please refer to the forum at http://gamekit.org
