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

- [ ] Enable DHCP on the router and remove port mapping and release/renew IP address

- [ ] Create SD card with the latest Raspberry Pi OS<details>
  <summary>Instructions</summary>

  Preferrably with a secondary SD Card to keep the current Pi running.

  [installer download](https://www.raspberrypi.org/downloads.../)
</details>

- [ ] Touch `ssh` on the boot volume of the SD Card

# Post OS install steps on desktop

- [ ] Ensure a working ansible enviroment <details>
  <summary>Instructions</summary>

  Not much to say except use `virtualenv`. I don't have a consistent way to set this up because
  my macbook might be my controller, or my windows WSL host will be.
</details>

- [ ] Note the IP the PI obtained from the Router

- [ ] Bootstrap with Ansible <details>
  <summary>Instructions</summary>

  `./ansible.sh bootstrap -i <pi ip>`
</details>

- [ ] Add the PI port forwarding

- [ ] Complete full configuration <details>
  <summary>Instructions</summary>

  `./ansible.sh apply -i <pi ip>`
</details>

- [ ] Reboot PI

- [ ] Re-add port mapping to the static IP

- [ ] Disable DHCP on the router

- [ ] Deploy goodenoughmoney.com

- [ ] Create `pi` Samba user<details>
  <summary>Instructions</summary>

  Run the following on the PI
  `sudo smbpasswd -a pi`
</details>

- [ ] Deploy navidrome<details>
  <summary>Instructions</summary>

  run `navidrome.sh` as `root` on the PI
</details>


- [ ] Make this template slightly better

# How Do I Know I Am Done?

- [ ] https://www.goodenoughmoney.com/ displays stuff

- [ ] https://home.scottmuc.com/music/ loads navidrome and the music is playable

- [ ] Z:\ on my Windows PC works

- [ ] `ipconfig /release` and then `ipconfig /renew` works

- [ ] `nslookup analytics.google.com` is refused
