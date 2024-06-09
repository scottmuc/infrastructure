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

- [ ] Enable DHCP on the router, remove port mapping and statically assign network to PC<details>
  <summary>Instructions</summary>

  **Insert screenshots here** ;-)
</details>


- [ ] Shutdown PI<details>
  <summary>Instructions</summary>

  Make sure the USB drive has spun down before doing any work.

  `sudo shutdown -h now`
</details>

- [ ] Create SD card with the latest Raspberry Pi OS<details>
  <summary>Instructions</summary>

  Using the SD card in the now powered down PI.

  The new installer has [options][advanced-options] to enable SSH and create a user.

  [installer download](https://www.raspberrypi.org/downloads/)

  **note** check if the underlying Debian distribution is changing as this might result
  in some issues in the playbook execution.

  The Bookworm 64-bit lite image seems to work for now. **note** as of `v1.8.4` of
  the Imager software, ensure to not select `no filtering` in the *Raspberry Pi Device*
  filter.

  [advanced-options]: https://www.raspberrypi.com/documentation/computers/getting-started.html#advanced-options
</details>


# Post OS install steps on desktop

- [ ] Ensure a working ansible enviroment <details>
  <summary>Instructions</summary>

  This will exercise the `asdf` setup.
</details>

- [ ] Turn on the PI and note the IP obtained from the Router

- [ ] Clean up old host keys<details>
  <summary>Instructions</summary>

  The new instance will have new host keys so to ensure host key warning messages don't
  distract us from the repaving, run the following:

  ```
  ssh-keygen -R 192.168.2.10
  ssh-keygen -R pi
  ssh-keygen -R pi.home.scottmuc.com
  ```
</details>

- [ ] Transfer local public ssh key to PI<details>
  <summary>Instructions</summary>

  In order to avoid the use of `sshpass`, copy the current sessions public ssh key to
  to `./ssh/authorized_keys` of the `pi` user on the PI. This user is only necessary to
  run the bootstrap playbook (which creates an admin `ansible` user) and will be subsequently
  cleaned up.

  `ssh-copy-id pi@<pi ip>`
</details>


- [ ] Bootstrap with Ansible <details>
  <summary>Instructions</summary>

  `./ansible.sh` and select the `bootstrap-playbook.yml`
</details>

- [ ] Add the PI port forwarding<details>
  <summary>Instructions</summary>

  Needed for the `certbot` ACME challenge in the next step.
</details>

- [ ] Complete full configuration <details>
  <summary>Instructions</summary>

  `./ansible.sh` and select the `main-playbook.yml`
</details>

- [ ] Reboot PI

- [ ] Re-add port mapping to the static IP

- [ ] Disable DHCP on the router

- [ ] Deploy goodenoughmoney.com

- [ ] Clean up host key for ephemeral IP<details>
  <summary>Instructions</summary>

  Remove host key reference to the temporary IP that was used to bootstrap the
  device. This cleanup will ensure that an error won't occur in the next refresh
  if the same IP is used again.

  ```
  ssh-keygen -R <ephemeral IP>
  ```
</details>

- [ ] Make this template slightly better

# How Do I Know I Am Done?

- [ ] https://www.goodenoughmoney.com/ displays stuff

- [ ] https://home.scottmuc.com/music/ loads navidrome and the music is playable

- [ ] http://192.168.2.10:9090/ loads and has data

- [ ] http://192.168.2.10:3000/ loads and has data

- [ ] `ipconfig /release` and then `ipconfig /renew` works

- [ ] `nslookup analytics.google.com` is refused

- [ ] Print out newly repaved machine details<details>
  <summary>Instructions</summary>

  `cat /etc/os-release && uname -a`
</details>

