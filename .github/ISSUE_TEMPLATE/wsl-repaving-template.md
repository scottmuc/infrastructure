---
name: WSL Repaving Template
about: Checklist for repaving WSL
title: Rebuild WSL - EXTRA DESCRIPTION
labels: wsl, repave
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

[repave-history]: https://github.com/scottmuc/infrastructure/issues?q=is%3Aissue+is%3Aclosed+label%3Awsl+label%3Arepave

# Steps

- [ ] Delete previous WSL instance if applicable

- [ ] Ensure WSL2 is being used

- [ ] Install latest Ubuntu

- [ ] Clone and run coalesce script

- [ ] Initalize 1Password

- [ ] Attempt DNS Change

- [ ] Configure PI (tests ansible)

- [ ] Make [this template][this-template] slightly better

[this-template]: https://github.com/scottmuc/infrastructure/blob/master/.github/ISSUE_TEMPLATE/wsl-repaving-template.md
