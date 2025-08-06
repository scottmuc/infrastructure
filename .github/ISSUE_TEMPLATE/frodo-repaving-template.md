---
name: Frodo Repaving Template
about: Checklist for repaving my Framework laptop
title: Rebuild Frodo - EXTRA DESCRIPTION
labels: frodo, repave, framework, ubuntu
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

  * Download an image from: https://ubuntu.com/download/desktop
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

  Hold down **F12** to trigger the boot selection menu.
</details>

- [ ] Install the OS.

# Post OS install steps

- [ ] Install `git` and `curl`
- [ ] Clone repo and run `coalesce_this_machine`
- [ ] Reboot (to get nix profile loaded in XWindows)
- [ ] Launch and log into Vivaldi
- [ ] Map capslock to control
- [ ] Open the 1 Password browser extension and log into it.
- [ ] Initialise 1 Password CLI<details>

  * `initialize-1password`
</details>


# Done When

- [ ] Make a tiny DNS change and run terraform<details>
  <summary>Instructions</summary>


    ```
    opauth
    # Unlock the repo in order to access values in ./secrets dir
    cd ~/workspace/infrastructure
    locksmith unlock
    # Initialize Terraform and apply
    cd dns
    ./tofu_apply
    ```
</details>

- [ ] Be able to push the commit (exercises `ssh-op-agent`)
- [ ] Old keys and credentials are deleted (GitHub and 1Password)
- [ ] Add OS details to repave issue
- [ ] Make this template slightly better
