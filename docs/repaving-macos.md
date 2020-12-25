# Repaving macos

## Bootstrapping the bootstrapping

* Format a USB (> 16GB) stick and name it UNTITLED
* Fetch the latest version of macos from the App Store
* Run the following

```
$ sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/UNTITLED --nointeraction
Password:
Erasing disk: 0%... 10%... 20%... 30%... 100%
Copying to disk: 0%... 10%... 20%... 30%... 40%... 50%... 60%... 70%... 80%... 90%... 100%
Making disk bootable...
Install media now available at "/Volumes/Install macOS Big Sur"
```

## Bootstrapping a fresh Apple machine


```
git # this will trigger the XCode installer which brings git along with it
mkdir ~/workspace
git clone https://github.com/scottmuc/infrastructure.git ~/workspace/infrastructure
~/workspace/infrastructure/homedirs/osx/bin/coalesce_this_machine
```

## Manual Steps

* Map capslock to control
* Launch 1Password and authenticate via credentials+salt stored on a dead tree
* Launch shiftit and get it setup
* Launch flycut and get it setup
