---
name: Macbook Air Repaving Template
about: Checklist for repaving my Macbook Air
title: Rebuild Macbook Air - EXTRA DESCRIPTION
labels: macos, repave
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

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Amacos+label%3Arepave

# Things to do with the existing build

- [ ] Create USB stick with macOS Big Sur<details>
  <summary>Instructions</summary>
  **Big Sur** is the latest version supported by my Macbook Air hardware ([compatibility][compatibility-matrix],
  [macos history][macos-history]). I have an early 2014 13" model.

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
</details>

[compatibility-matrix]: https://niwtech.com/guides/apple/macbook-air/mac-os-compatibility/
[macos-history]: https://en.wikipedia.org/wiki/MacOS_version_history

- [ ] Backup anything worth keeping <details>
  <summary>Instructions</summary>

  Generally, this means look at the following directories for things that I might want to carry over to the fresh
  install or possibly consider saving to a cloud service:

  * `Desktop`
  * `Documents`
  * `Downloads`
</details>

# Rebuild steps

- [ ] Reboot to load installer <details>
  <summary>Instructions</summary>

  Hold down the **Option** key to trigger the boot selection menu.
</details>

- [ ] Use Disk Utility to wipe existing partition and make a new one (new name, new encryption key)
- [ ] Install the OS

# Post OS install steps

- [ ] Install git, clone this repo, and run `coalese_this_machine` <details>
  <summary>Instructions</summary>

  ```
  git # this will trigger the XCode installer which brings git along with it
  mkdir ~/workspace
  git clone https://github.com/scottmuc/infrastructure.git ~/workspace/infrastructure
  ~/workspace/infrastructure/homedirs/osx/coalesce_this_machine
  ```
</details>

- [ ] Launch and configure 1 Password
- [ ] Initialise 1 Password CLI
- [ ] Map capslock to control

**note** to speed things up, some of the steps above can be done while `coalese_this_machine` is running.

# Done When

- [ ] Make a tiny DNS change and run terraform<details>
  <summary>Instructions</summary>


    ```
    # Initialize and log into the 1 Password CLI
    initialize-1password
    opauth
    # Unlock the repo in order to access values in ./secrets dir
    cd ~/workspace/infrastructure
    locksmith unlock
    # Initialize Terraform and apply
    cd dns
    terraform init
    ./terraform_apply
    ```
</details>

- [ ] Make a signed commit mentioning this issue (exercises `gpg-op`)<details>
  <summary>Instructions</summary>


    ```
    # Initialize and log into the 1 Password CLI
    initialize-1password
    opauth
    gpg_op restore -e "scottATscottmuc.com"
    ```
</details>

- [ ] Be able to push the commit (exercises `ssh-op-agent`)
- [ ] Log into GitHub in Brave (exercises 1 Password browser extension)
- [ ] Old keys and credentials are deleted (GitHub and 1Password)
- [ ] Make this template slightly better
