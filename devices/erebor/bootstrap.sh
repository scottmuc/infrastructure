#!/usr/bin/env sh

set -eux

# INFO: a fresh install of FreeBSD does not have a python
# https://docs.ansible.com/ansible/latest/os_guide/intro_bsd.html
ansible --module-name raw \
  --args "pkg install -y python" \
  --inventory "../inventory.yml" \
  --become \
  --become-method "su" \
  --ask-become-pass \
  --user "bootstrap" \
  erebor.middle-earth.internal.

ansible-playbook \
  --inventory "../inventory.yml" \
  --ask-become-pass \
  ./playbooks/0-bootstrap.yml
