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

- [ ] boot to the USB.
- [ ] wipe old partitions.
- [ ] run Windows installer.

# Post Paving

- [ ] Windows update
- [ ] Install Box Starter
- [ ] Install my Box Starter Package <details>
  <summary>Instructions</summary>

  Thanks [Rich Turner][rich-turner-boxstarter] for your excellent example!

  [rich-turner-boxstarter]: https://gist.github.com/bitcrazed/c788f9dcf1d630340a19

  Launch Powershell with elevated privileges:

  ```
  Set-ExecutionPolicy Unrestricted
  . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
  Install-BoxstarterPackage -DisableReboots -PackageName https://raw.githubusercontent.com/scottmuc/infrastructure/master/boxstarter.txt
  ```
</details>

