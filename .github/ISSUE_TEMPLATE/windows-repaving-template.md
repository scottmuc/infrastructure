---
name: Windows PC Repaving Template
about: Checklist for repaving my Windows PC
title: Rebuild Windows PC - EXTRA DESCRIPTION
labels: windows, repave
assignees: 'scottmuc'
---
<!--
From: https://gist.github.com/pierrejoubert73/902cc94d79424356a8d20be2b382e1ab
<details>
  <summary>Instructions</summary>

  moar markdown
</details>
-->
# Yay for Repaving!

As much as possible is documented inline in this issue template. In case of problems you may find help by viewing
all the [previous repave issues][repave-history]. Have fun!

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Awindows+label%3Arepave

# Prep

- [ ] backup stuff if you think you need it. <details>
  <summary>Instructions</summary>

  * Desktop
  * Downloads
  * Documents
</details>

- [ ] prepare USB device with a Windows installer. <details>
  <summary>Instructions</summary>

  Here's my [primary influence][primary-influence].

  [primary-influence]: http://forum.notebookreview.com/threads/guide-clean-install-windows-10-after-m-2-nvme-ssd-upgrade.787420/
</details>

# Repave

- [ ] boot to the USB. <details>
  <summary>Instructions</summary>

  * Hit `F12` while machine is rebooting to load boot menu.
  * The drive that is less than 50GB is likely the bootable USB device.
</details>

- [ ] wipe old partitions.
- [ ] run Windows installer.

# Post Paving

- [ ] Install Chocolatey <details>
  <summary>Instructions</summary>

  * https://chocolatey.org/install
</details>

- [ ] Install BoxStarter <details>
  <summary>Instructions</summary>

  * `choco install Boxstarter`
</details>

- [ ] Install my Box Starter Package <details>
  <summary>Instructions</summary>

  Thanks [Rich Turner][rich-turner-boxstarter] for your excellent example!

  [rich-turner-boxstarter]: https://gist.github.com/bitcrazed/c788f9dcf1d630340a19

  Launch Powershell with elevated privileges:

  ```
  Install-BoxstarterPackage -DisableReboots -PackageName https://github.com/scottmuc/infrastructure/blob/master/homedirs/windows/boxstarter.ps1
  ```
</details>

- [ ] Windows update


