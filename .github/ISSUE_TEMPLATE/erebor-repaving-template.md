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

- [ ] Export the zdata zpool<details>
  <summary>Instructions</summary>

  `doas zpool export zdata`  
</details>

# Rebuild steps

- [ ] Reboot to load installer <details>
  <summary>Instructions</summary>

  Hold down **F12** to trigger the boot selection menu.
</details>

- [ ] Install the OS.<details>
  <summary>Instructions</summary>

  See https://github.com/scottmuc/infrastructure/issues/78
</details>

# Post OS install steps

- [ ] Run 0-bootstrap from Frodo
- [ ] Run 1-post-install from Frodo

- [ ] Import the zdata zpool<details>
  <summary>Instructions</summary>

  `doas zpool import zdata`  
</details>

- [ ] Run 1-file-server from Frodo
- [ ] Reboot `erebor`

# Done When

- [ ] Laptop can mount /mnt/mcap
- [ ] Windows PC can mount Z:
