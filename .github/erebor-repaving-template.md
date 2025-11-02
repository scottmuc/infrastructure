---
name: Erebor Repaving Template
about: Checklist for repaving my NAS (erebor)
title: Rebuild Erebor - EXTRA DESCRIPTION
labels: freebsd, repave, erebor
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

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Aerebor+label%3Arepave

# Things to do with the existing build


- [ ] Shutdown Server<details>
  <summary>Instructions</summary>

  Make sure the mounted drives are dismounted safely before powering down.

  `sudo shutdown -p now`
</details>

- [ ] Create SD card with the latest FreeBSD OS<details>
  <summary>Instructions</summary>

  TODO

</details>


# Post OS install steps on desktop

- [ ] Ensure a working ansible enviroment <details>
  <summary>Instructions</summary>

  This will exercise the `nix develop` setup.
</details>


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


- [ ] Bootstrap with Ansible <details>
  <summary>Instructions</summary>

  `./bootstrap.sh `
</details>


- [ ] Complete full configuration <details>
  <summary>Instructions</summary>

  `./ansible.sh` and select the `1-main.yml`
</details>

- [ ] Make this template slightly better

# How Do I Know I Am Done?

- [ ] Print out newly repaved machine details<details>
  <summary>Instructions</summary>

  `ssh ansible@erebor -- "cat /etc/os-release; uname -a; pkg info" > state.txt`
</details>

