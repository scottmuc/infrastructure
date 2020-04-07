# OSX Homedir

### Bootstrapping the bootstrapping

Before anything can happen, the first thing that needs to be done is to create a Mojave USB boot device. I've
followed the [osxdaily post](http://osxdaily.com/2018/09/26/make-macos-mojave-boot-usb-installer/).

### Bootstrapping a brand spanking new machine

On a freshly installed **macOS Mojave** machine the following commands will get everything configured.

```
sudo xcodebuild -license
curl -L https://raw.githubusercontent.com/scottmuc/osx-homedir/master/bin/curl-bash-bootstrap.bash 2> /dev/null | bash
~/bin/coalesce_this_machine
```

**Manual Steps**

* Map capslock to control
* Launch 1Password and authenticate via credentials+salt stored on a dead tree
* Launch shiftit and get it setup
* Launch flycut and get it setup

### So What's Included?

The following is made available by being cloned in the `$HOME` directory:

* **bash** configuration
* **git** configuration
* **~/bin** (added to PATH)
* **neovim** configuration

The rest is installed/configured by `~/bin/coalesce_this_machine`:

* runs **sprout-wrap** automation which does the following:
  * fixes my Dock
  * sets a fast key repeat rate
  * makes the function keys act as function keys
  * changes my menubar clock format
* runs **homebrew** things.
* installs **neovim** plugins
* runs OSX softwareupdates
