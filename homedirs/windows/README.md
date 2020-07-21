# Windows Homedir

This repository is analagous to the one that is used for [Mac OSX][osx-homedir] workstation
automation. Of course there are going to be some subtle differences because of the platform
differences.

[osx-homedir]: ../osx

Here's my [primary influence][primary-influence].

[primary-influence]: http://forum.notebookreview.com/threads/guide-clean-install-windows-10-after-m-2-nvme-ssd-upgrade.787420/

### Bootstrapping a brand spanking new machine

Thanks [Rich Turner][rich-turner-boxstarter] for your excellent example!

[rich-turner-boxstarter]: https://gist.github.com/bitcrazed/c788f9dcf1d630340a19

Launch Powershell with elevated privileges:

```
Set-ExecutionPolicy Unrestricted
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
Install-BoxstarterPackage -DisableReboots -PackageName https://raw.githubusercontent.com/scottmuc/infrastructure/master/boxstarter.txt
```
