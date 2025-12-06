---
name: Erebor Repaving Template
about: Checklist for repaving my FreeBSD NAS
title: Rebuild Erebor - EXTRA DESCRIPTION
labels: erebor, repave, freebsd
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

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Aerebor+label%3Arepave

# Things to do with the existing build

- [ ] Create USB installer with the latest FreeBSD OS<details>
  <summary>Instructions</summary>

  Follow instructions on the website

</details>

- [ ] Export the zdata zpool<details>
  <summary>Instructions</summary>

  `doas zpool export zdata`  
</details>

- [ ] Shutdown Server<details>
  <summary>Instructions</summary>

  Make sure the mounted drives are dismounted safely before powering down.

  `sudo shutdown -p now`
</details>

# Rebuild steps

- [ ] Reboot to load installer <details>
  <summary>Instructions</summary>

  Hold down **F12** to trigger the boot selection menu.
</details>

- [ ] Install the OS.<details>
  <summary>Instructions</summary>

  See https://github.com/scottmuc/infrastructure/issues/78

  Also set the IP and resolvers manually

  In `/etc/rc.conf`

  ```
  ifconfig_re0="inet 192.168.2.19 netmask 255.255.255.0"
  defaultrouter="192.168.2.1"
  ``` 

  In `/etc/resolve.conf`

  ```
  search middle-earth.internal
  nameserver 192.168.2.10
  nameserver 192.168.2.11
  ```

  The new IP will apply on reboot
</details>

# Post OS install steps

- [ ] Clean up old host keys<details>
  <summary>Instructions</summary>

  The new instance will have new host keys so to ensure host key warning messages don't
  distract us from the repaving, run the following:

  ```
  ssh-keygen -R erebor
  ssh-keygen -R erebor.middle-earth.internal.
  ```
</details>

- [ ] Transfer local public ssh key to NAS<details>
  <summary>Instructions</summary>

  In order to avoid the use of `sshpass`, copy the current sessions public ssh key to
  to `./ssh/authorized_keys` of the `bootstrap` user on the server. This user is only necessary to
  run the bootstrap playbook (which creates an admin `ansible` user) and will be subsequently
  cleaned up.

  `ssh-copy-id bootstrap@erebor`
</details>

- [ ] Run 0-bootstrap from Frodo
- [ ] Run 1-post-install from Frodo

- [ ] Import the zdata zpool<details>
  <summary>Instructions</summary>

  `doas zpool import zdata`  
</details>

- [ ] Run 2-file-server from Frodo
- [ ] Reboot `erebor`

- [ ] Make this template slightly better

# Done When

- [ ] Print out newly repaved machine details<details>
  <summary>Instructions</summary>

  `ssh ansible@erebor -- "cat /etc/os-release; uname -a; pkg info" > state.txt`
</details>

- [ ] Laptop can mount /mnt/mcap
- [ ] Windows PC can mount Z:

