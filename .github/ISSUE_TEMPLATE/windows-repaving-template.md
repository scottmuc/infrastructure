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

As much as possible is documented inline in this issue template. In case of problems
you may find help by viewing all the [previous repave issues][repave-history]. Have fun!

* [Current machine specs](https://pcpartpicker.com/b/wX9J7P)

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Awindows+label%3Arepave

# Prep

- [ ] Backup stuff if you think you need it. <details>
  <summary>Instructions</summary>

  * Desktop
  * Downloads
  * Documents
</details>

- [ ] Prepare USB device with a Windows installer. <details>
  <summary>Instructions</summary>
  
  Here's the [latest documentation][msdocs] I followed to make a USB installer.

  [msdocs]: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/install-windows-from-a-usb-flash-drive
</details>

# Repave

- [ ] Boot to the USB. <details>
  <summary>Instructions</summary>

  * Hit `F12` while machine is rebooting to load boot menu.
  * The drive that is less than 50GB is likely the bootable USB device.
</details>

- [ ] Wipe old partitions.<details>
  <summary>Instructions</summary>

  Only the 1TB drive should be wiped. This is the NVMe drive that is dedicated
  to the Windows installation. The other 2TB drive is the data drive where all
  the Steam and GOG games are installed.
</details>

- [ ] Run Windows installer.

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

- [ ] Install Gigabyte App Center <details>
  <summary>Instructions</summary>

  For now, [this tool][gigabyteutils] might be the most convenient way to install
  supported drivers for this mainboard.
</details>

[gigabyteutils]: https://www.gigabyte.com/Motherboard/X570-UD-rev-10/support#support-dl-utility

- [ ] Install 1 Password<details>
  <summary>Instructions</summary>

  This was failing to install correctly using `choco`, test if this has improved.
</details>

- [ ] Configure Vivaldi<details>
  <summary>Instructions</summary>

  Do the following:
  * Use credentials from 1 Password
</details>

[unhook]: https://chrome.google.com/webstore/detail/unhook-remove-youtube-rec/khncfooichmfjbepaaaebmommgaepoid
[pocket]: https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj
[brave-search-engine]: brave://settings/?search=search+engine
[brave-download-location]: brave://settings/?search=downloads

- [ ] Review Radeon Software (optional)<details>
  <summary>Instructions</summary>

  So far I am getting by without installing this software. Every now and then, it's worth reviewing
  whether or not the software would be useful to add.

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

  Novabench's new version seems to augment the numbers:
  * CPU 1200
  * RAM 270
  * GPU 500
  * Disk 470
</details>

- [ ] Unpin items for TaskBar<details>
  <summary>Instructions</summary>

  Right click on the items and hide them.
</details>

- [ ] Pair with XBox controller

- [ ] Configure 2nd monitor (TV)<details>
  <summary>Instructions</summary>

  To ensure audio output works correctly, after switching display to the TV,
  launch the audio settings and change the audio output to the TV. After this,
  switching back and forth will configure the audio output device correctly.
</details>

- [ ] Create SSH key and add GPG key<details>
  <summary>Instructions</summary>

  I'll need to look into running an ssh-agent in Windows and update my 1 Password key access. For
  now I can run `ssh-keygen` and add the public key to GitHub manually.

  To load my gpg key, following these steps:

  1. Copy the base64 encoded secret key from 1 Password
  2. Paste the contents into a file (use vim)
  3. Run `cat .\base64.file | iconv -f UTF-8 -t UTF-16LE | base64 -d -i > .\secret.key`
  4. Run `gpg --import .\secret.key`

</details>

- [ ] Install Syncthing

- [ ] Repave WSL

# Verification Steps

- [ ] Play a Steam game on the TV

- [ ] Open personal Obsidian vault

- [ ] Open personal GnuCash ledger

- [ ] Commit (signed) and push without WSL by making [this template][this-template] slightly better.

[this-template]: https://github.com/scottmuc/infrastructure/blob/main/.github/ISSUE_TEMPLATE/windows-repaving-template.md 