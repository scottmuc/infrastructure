---
name: Pippin Repaving Template
about: Checklist for repaving my Rapberry PI (aka Pippin)
title: Rebuild Pippin - EXTRA DESCRIPTION
labels: raspberry-pi, repave, pippin
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

As much as possible is documented inline in this issue template. In case of problems you may find help by viewing all
the [previous repave issues][repave-history]. Have fun!

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Araspberry-pi+label%3Arepave

# Things to do with the existing build

- [ ] Enable DHCP on the router, remove port mapping<details>
  <summary>Instructions</summary>

  DHCP on the router needs to be enabled in order for pippin to be able to resolve hostnames in order to install all of
  the things. If merry is running, it could be configured to use 192.168.2.11, but that might be a more complicated
  orchestration.
</details>


- [ ] Shutdown PI<details>
  <summary>Instructions</summary>

  Make sure the mounted drives are dismounted safely before powering down.

  `sudo shutdown -h now`
</details>

- [ ] Create SD card with the latest Raspberry Pi OS **ensure you read this**<details>
  <summary>Instructions</summary>

  Using the SD card in the now powered down PI.

  The new installer has [options][advanced-options] to enable SSH and create a user.

  [installer download](https://www.raspberrypi.org/downloads/)

  **note** check if the underlying Debian distribution is changing as this might result
  in some issues in the playbook execution.

  The Bookworm 64-bit lite image seems to work for now. **note** as of `v1.8.4` of
  the Imager software, ensure to not select `no filtering` in the *Raspberry Pi Device*
  filter.

  As of 2025.12.04, the Trixie image hasn't worked so use the Legacy Bookworm image to just
  get the repave done. Next repave should at least attempt Trixie again to see if the issues
  have been fixed.

  [advanced-options]: https://www.raspberrypi.com/documentation/computers/getting-started.html#advanced-options
</details>


# Post OS install steps on desktop

- [ ] Ensure a working ansible enviroment <details>
  <summary>Instructions</summary>

  Use the nix devshell by running `nix develop`
</details>

- [ ] Turn on the PI and note the IP obtained from the Router

- [ ] Update `/etc/hosts` mapping the IP in the step above to `pippin.middle-earth.internal.`

- [ ] Clean up old host key<details>
  <summary>Instructions</summary>

  The new instance will have new host keys so to ensure host key warning messages don't
  distract us from the repaving, run the following:

  ```
  ssh-keygen -R pippin.middle-earth.internal.
  ```
</details>

- [ ] Transfer local public ssh key to PI<details>
  <summary>Instructions</summary>

  In order to avoid the use of `sshpass`, copy the current sessions public ssh key to
  to `./ssh/authorized_keys` of the `bootstrap` user on the PI. This user is only necessary to
  run the bootstrap playbook (which creates an admin `ansible` user) and will be subsequently
  cleaned up.

  `ssh-copy-id bootstrap@pippin.middle-earth.internal.`
</details>


- [ ] Bootstrap with Ansible <details>
  <summary>Instructions</summary>

  `./ansible.sh` and select the `0-bootstrap.yml`
</details>

- [ ] Add the PI port forwarding<details>
  <summary>Instructions</summary>

  Needed for the `certbot` ACME challenge in the next step.
</details>

- [ ] Complete full configuration <details>
  <summary>Instructions</summary>

  `./ansible.sh` and select the `1-machine-config.yml`

  and then:

  `./ansible.sh` and select the `2-main.yml`
</details>

- [ ] Reboot PI

- [ ] Re-add port mapping to the static IP

- [ ] Disable DHCP on the router

- [ ] Deploy goodenoughmoney.com

- [ ] Clean up `~/.ssh/known_hosts`<details>
  <summary>Instructions</summary>

  Run `really-well-known-hosts` to completey reset the file
</details>

- [ ] Update `/etc/hosts` and remove entry for `pippin.middle-earth.internal.`

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

  `ssh ansible@192.168.2.10 -- "cat /etc/os-release; uname -a; dpkg -l" > state.txt`
</details>

