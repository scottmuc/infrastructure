#!/usr/bin/env sh

set -eux

# INFO: a fresh install of FreeBSD does not have a python
# https://docs.ansible.com/ansible/latest/os_guide/intro_bsd.html
ansible --module-name raw \
  --args "pkg install -y python" \
  --inventory "inventory.ini" \
  --become \
  --become-method "su" \
  --ask-become-pass \
  --user "bootstrap" \
  erebor

ansible-playbook \
  --extra-vars "ansible_python_interpreter=/usr/local/bin/python" \
  --inventory "inventory.ini" \
  --ask-become-pass \
  ./playbooks/0-bootstrap.yml
