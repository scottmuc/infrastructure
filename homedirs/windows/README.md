# Windows Homedir

This repository is analagous to the one that is used for [Mac OSX][osx-homedir] workstation
automation. Of course there are going to be some subtle differences because of the platform
differences.

Here's my [primary influence][primary-influence].

[primary-influence]: http://forum.notebookreview.com/threads/guide-clean-install-windows-10-after-m-2-nvme-ssd-upgrade.787420/

### Bootstrapping a brand spanking new machine

Thanks [Rich Turner][rich-turner-boxstarter] for your excellent example!

[rich-turner-boxstarter]: https://gist.github.com/bitcrazed/c788f9dcf1d630340a19

Launch Powershell with elevated privileges:

```
Set-ExecutionPolicy Unrestricted
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
Install-BoxstarterPackage -DisableReboots -PackageName https://raw.githubusercontent.com/scottmuc/windows-homedir/master/boxstarter.txt
```

**Post bootstrap TODO**

* Change windows performance settings to only have font smoothing enabled

[osx-homedir]: https://github.com/scottmuc/osx-homedir

### Repave Journal

##### October 3 2018

* Need to add documentation on how to setup the bootable USB drive as it required some BIOS
  setting tweaks and downloading of drivers from dell.com
* Once install completed had to run the installer for the WiFi drivers
* Performed a complete Windows update
* Need up adjust KB and language as my laptop is from Dell Ireland but I still
  type as if I have a US QWERTY layout
* Need to install Boxstarter first before the other things
* Create ssh key on separate machine first and put on the repave USB stick

##### October 5 2018

* Went smoothly with the ssh keys transfered from previous build as well as the boxstarter downoad
* Set the task bar config plus more Explorer config in the boxstarter.txt
