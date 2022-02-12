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
  Install-BoxstarterPackage -DisableReboots -PackageName https://raw.githubusercontent.com/scottmuc/infrastructure/master/homedirs/windows/boxstarter.ps1
  ```
</details>

- [ ] Windows update

- [ ] Configure Brave<details>
  <summary>Instructions</summary>

  Do the following:
  * Ensure 1 Password extension works
  * Getpocket installed
  * Unhook extension is installed (and support the author)
  * Set searrch engine to DuckDuckGo
</details>

- [ ] Install and configure Google Drive

- [ ] Setup Radeon Software<details>
  <summary>Instructions</summary>

  I'm not sure what to do here. Here are a couple helpful links:
  * https://www.amd.com/en/support/kb/faq/gpu-kb205
  * https://raptoreumcalculator.com/blog/radeonsoftware-exe-windows-complaining-about-missing-mfplat-dll-mf-dl-and-mfreadwrite-dll-files/
  * https://www.amd.com/en/support
</details>


- [ ] Run Novabench<details>
  <summary>Instructions</summary>

  Score should be around:
  * CPU 1600
  * RAM 260
  * GPU 1000
  * Disk 340
</details>


