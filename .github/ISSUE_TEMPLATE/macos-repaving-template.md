---
name: Macbook Air Repaving Template
about: Checklist for repaving my Macbook Air
title: Rebuild Macbook Air - EXTRA DESCRIPTION
labels: macos, repave
assignees: ''

---

# Things to do with the existing build

- [ ] Create USB stick with latest macOS ([instructions][usb-stick-instruction])
- [ ] Create credentials for the rebuild ([instructions][recreate-credentials])
- [ ] Backup anything worth keeping ([instructions][backup-stuff])

[usb-stick-instructions]: https://github.com/scottmuc/infrastructure/blob/master/docs/repaving-macos.md#bootstrapping-the-bootstrapping
[recreate-credentials]: https://github.com/scottmuc/infrastructure/blob/master/docs/repaving-macos.md#recreate-credentials
[backup-stuff]: https://github.com/scottmuc/infrastructure/blob/master/docs/repaving-macos.md#backup-stuff

# Rebuild steps

- [ ] Reboot to load installer
- [ ] Use Disk Utility to wipe existing partition and make a new one (new name, new encryption key)
- [ ] Install the OS

# Post OS install steps

- [ ] Install git and clone this repo
- [ ] Run `coalesce_this_machine`
- [ ] Launch and configure 1 Password
- [ ] Initialise 1 Password CLI

# Done When

- [ ] Make a tiny DNS change and run terraform
- [ ] Make a signed commit mentioning this issue (exercises `gpg_op`)
- [ ] Be able to push the commit (exercises `ssh_op_agent`)
- [ ] Log into GitHub in Brave (exercises 1 Password browser extension)
