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

- [ ] Enable DHCP on the router and remove port mapping

# Post OS install steps on the PI

- [ ] Note the IP assigned to the PI during the OS install

- [ ] Enable SSHD via `rasp-config`

# Post OS install steps on desktop

- [ ] Ensure a working ansible enviroment <details>
  <summary>Instructions</summary>

  Not much to say except use `virtualenv`. I don't have a consistent way to set this up because
  my macbook might be my controller, or my windows WSL host will be.
</details>

- [ ] Copy ssh key using `ssh-copy-id pi@<pi ip>`

- [ ] Bootstrap with Ansible <details>
  <summary>Instructions</summary>

  `ansible-playbook -i <pi ip>, --become --ask-become-pass ./bootstrap-playbook.yml`
</details>

- [ ] Complete full configuration <details>
  <summary>Instructions</summary>

  `./ansible.sh <pi ip>`
</details>

- [ ] Reboot PI

- [ ] Add port mapping on the router

- [ ] Disable DHCP on the router

- [ ] Make this template slightly better
