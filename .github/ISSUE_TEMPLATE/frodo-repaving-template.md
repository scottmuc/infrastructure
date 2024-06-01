---
name: Frodo Repaving Template
about: Checklist for repaving my Framework laptop
title: Rebuild Frodo - EXTRA DESCRIPTION
labels: frodo, repave, framework
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

As much as possible is documented inline in this issue template. In case of problems you may
find help by viewing all the [previous repave issues][repave-history]. Have fun!

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Afrodo+label%3Arepave

# Things to do with the existing build

- [ ] Create USB stick with Ubuntu<details>
  <summary>Instructions</summary>
  TODO Add some notes
</details>

- [ ] Backup anything worth keeping <details>
  <summary>Instructions</summary>

  Generally, this means look at the following directories for things that I might want to carry
  over to the fresh install or possibly consider saving to a cloud service:

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
    ./tofu_apply
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
- [ ] Log into GitHub in Vivaldi (exercises 1 Password browser extension)
- [ ] Old keys and credentials are deleted (GitHub and 1Password)
- [ ] Make this template slightly better
