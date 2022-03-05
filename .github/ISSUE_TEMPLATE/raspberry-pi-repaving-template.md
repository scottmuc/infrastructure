---
name: Raspberry PI Repaving Template
about: Checklist for repaving my Rapberry PI
title: Rebuild Raspbery PI - EXTRA DESCRIPTION
labels: raspberry-pi, repave
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

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Araspberry-pi+label%3Arepave

# Things to do with the existing build

- [ ] Create SD card with the latest Raspberry Pi OS<details>
  <summary>Instructions</summary>

  Preferrably with a secondary SD Card to keep the current Pi running.
  
  [installer download](https://www.raspberrypi.org/downloads.../)
</details>

- [ ] Ensure a working ansible enviroment <details>
  <summary>Instructions</summary>

  Not much to say except use `virtualenv`. I don't have a consistent way to set this up because
  my macbook might be my controller, or my windows WSL host will be.
</details>

# Post OS install steps

- [ ] Ensure machine IP is 192.168.2.10

- [ ] Copy ssh key using `ssh-copy-id`

- [ ] Bootstrap with Ansible <details>
  <summary>Instructions</summary>

  `ansible-playbook -i 192.168.2.10, --become --ask-become-pass ./bootstrap-playbook.yml`
</details>

- [ ] Complete full configuration <details>
  <summary>Instructions</summary>

  `ansible-playbook -i 192.168.2.10, --become ./main-playbook.yml`
</details>

- [ ] Make this template slightly better
