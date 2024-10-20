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

- [ ] Check repos for uncommited stuff<details>
  <summary>Instructions</summary>

  `cd && mr status`
</details>

- [ ] Run repave script from windows host<details>
  <summary>Instructions</summary>

  As an admin, run:

  `Set-ExecutionPolicy -ExectionPolicy RemoteSigned`

  Then run:

  `~/workspace/infrastructure/homedirs/windows/Repave-WSLInstance.ps`
</details>

- [ ] Clone and run coalesce script<details>
  <summary>Instructions</summary>

  ```
  mkdir ~/workspace && cd ~/workspace
  git clone https://github.com/scottmuc/infrastructure.git
  cd infrastructure/homedirs/wsl
  ./coalesce_this_machine
  background light # or dark if that's the current windows setting
  ```
</details>

- [ ] Reboot WSL Instance<details>
  <summary>Instructions</summary>

  In order for `/etc/wsl.conf` to take effect we need to restart the
  WSL instance.

  `wsl --shutdown Ubuntu`

</details>

- [ ] Initalize 1Password<details>
  <summary>Instructions</summary>

  `inialized-1password`

</details>

- [ ] Load GPG Keys<details>
  <summary>Instructions</summary>

  ```
  opauth
  keys
  gpg-op restore -e scottATscottmuc.com
  ```

</details>

- [ ] Bootstrap repository tools<details>
  <summary>Instructions</summary>

  ```
  mise install
  pip install ansible
  ```


</details>

# Verification Steps

- [ ] Decrypt Repository<details>
  <summary>Instructions</summary>

  ```
  locksmith unlock
  ```
</details>

- [ ] Attempt DNS Change<details>
  <summary>Instructions</summary>

  ```
  cd dns
  tofu init
  # add TXT record to graffiti.scottmuc.com
  ./tofu_apply
  ```
</details>

- [ ] Configure PI (tests ansible)

- [ ] Clone all the repos<details>
  <summary>Instructions</summary>

  ```
  cd ~/
  mr checkout
  mr github
  ```
</details>

- [ ] Ensure `deploy.sh` of goodenoughmoney.com works

- [ ] Ensure `docker` works<details>
  <summary>Instructions</summary>

  ```
  sudo service docker start
  docker ps
  ```
</details>

- [ ] Log OS release and kernel version<details>
  <summary>Instructions</summary>

  ```
  cat /etc/os-release
  uname -a
  ```
</details>

</details>

- [ ] Make [this template][this-template] slightly better

[this-template]: https://github.com/scottmuc/infrastructure/blob/master/.github/ISSUE_TEMPLATE/wsl-repaving-template.md
