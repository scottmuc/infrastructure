---
name: Macos Repaving Template
about: Checklist for repaving my Macos machines
title: Macos Repave
labels: macos, repave
assignees: ''

---

# Things to do with the existing build

- [ ] Create USB stick with latest macOS
- [ ] Create credentials for the rebuild
- [ ] Backup anything worth keeping

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
