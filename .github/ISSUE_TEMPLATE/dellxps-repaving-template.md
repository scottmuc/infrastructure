---
name: Dell XPS Repaving Template
about: Checklist for repaving my Dell XPS
title: Rebuild Dell XPS - EXTRA DESCRIPTION
labels: ubuntu, repave
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

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Aubuntu+label%3Arepave

# Things to do with the existing build

- [ ] Create USB stick with latest Ubuntu OS

</details>

# Rebuild steps

- [ ] Reboot laptop and press `F12` to load the boot selection menu
- [ ] Install the OS <details>
  <summary>Instructions</summary>

  * https://ubuntu.com/tutorials/install-ubuntu-server#1-overview
  * Create a user called `bootstrap` with a password `bootstrap`
</details>

# Post OS install steps

- [ ] Ensure a working ansible enviroment <details>
  <summary>Instructions</summary>

  Not much to say except use `virtualenv`. I don't have a consistent way to set this up because
  my macbook might be my controller, or my windows WSL host will be.
</details>
- [ ] Copy ssh key using `ssh-copy-id`
- [ ] Bootstrap with Ansible <details>
  <summary>Instructions</summary>

  `ansible-playbook -i 192.168.2.11, --become --ask-become-pass ./bootstrap-playbook.yml`
</details>
- [ ] Complete full configuration <details>
  <summary>Instructions</summary>

  `ansible-playbook -i 192.168.2.11, --become ./main-playbook.yml`
</details>
