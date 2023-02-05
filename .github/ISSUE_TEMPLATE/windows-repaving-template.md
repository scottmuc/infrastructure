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
  

  Here's the [latest documentation][msdocs] I followed to make a USB installer.

  [msdocs]: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/install-windows-from-a-usb-flash-drive
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

- [ ] Set machine hostname<details>
  <summary>Instructions</summary>

  This can come in handy for all services that have recorded the machines
  hostname for security verification. The timestamp in the name and other
  metadata can make future auditing a bit easier.

  The convention is YYYYMMDD-something meta.

  Test if this can be done in [powershell][ps-rename].

  [ps-rename]: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-computer?view=powershell-7.2
</details>

- [ ] Install Chocolatey <details>
  <summary>Instructions</summary>

  * https://chocolatey.org/install
</details>

- [ ] Install BoxStarter <details>
  <summary>Instructions</summary>

  * `choco install Boxstarter`
</details>

- [ ] Install Boostrap BoxStarter Package <details>
  <summary>Instructions</summary>

  Thanks [Rich Turner][rich-turner-boxstarter] for your excellent example!

  [rich-turner-boxstarter]: https://gist.github.com/bitcrazed/c788f9dcf1d630340a19

  Launch Boxstarter Shell with elevated privileges:

  ```
  Install-BoxstarterPackage -DisableReboots -PackageName https://raw.githubusercontent.com/scottmuc/infrastructure/main/homedirs/windows/boxstarter.bootstrap.ps1
  ```
</details>

- [ ] Windows update

- [ ] Install Main BoxStarter Package <details>
  <summary>Instructions</summary>

  Thanks [Rich Turner][rich-turner-boxstarter] for your excellent example!

  [rich-turner-boxstarter]: https://gist.github.com/bitcrazed/c788f9dcf1d630340a19

  Launch Boxstarter Shell with elevated privileges:

  ```
  Install-BoxstarterPackage -DisableReboots -PackageName $(Join-Path -Path $Env:USERPROFILE -ChildPath "workspace/infrastructure/homedirs/windows/boxstarter.ps1")
  ```
</details>

- [ ] Install 1 Password

- [ ] Configure Brave<details>
  <summary>Instructions</summary>

  Do the following:
  * Ensure 1 Password extension works
  * Getpocket installed
  * Unhook extension is installed (and support the author)
  * Set searrch engine to DuckDuckGo
</details>

- [ ] Install and configure Google Drive
- [ ] Turn off all Windows notification sounds

- [ ] Setup Radeon Software<details>
  <summary>Instructions</summary>

  I'm not sure what to do here. Here are a couple helpful links:
  * https://www.amd.com/en/support/kb/faq/gpu-kb205
  * https://raptoreumcalculator.com/blog/radeonsoftware-exe-windows-complaining-about-missing-mfplat-dll-mf-dl-and-mfreadwrite-dll-files/
  * https://www.amd.com/en/support
</details>

- [ ] Install and configure Samsung Magician<details>
  <summary>Instructions</summary>

  Download [the installer][samsung-magician] and run it. Enable the performance profile.

  [samsung-magician]: https://semiconductor.samsung.com/consumer-storage/magician/
</details>

- [ ] Run Novabench<details>
  <summary>Instructions</summary>

  Score should be around:
  * CPU 1600
  * RAM 260
  * GPU 1000
  * Disk 340
</details>

- [ ] Disable Windows sounds

- [ ] Unpin items for TaskBar

- [ ] Pair speakers and XBox controller

- [ ] Configure 2nd monitor (TV)

- [ ] Make [this template][this-template] slightly better

[this-template]: https://github.com/scottmuc/infrastructure/blob/master/.github/ISSUE_TEMPLATE/windows-repaving-template.md
 