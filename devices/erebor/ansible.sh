#!/usr/bin/env sh

set -eu

playbook=$(find ./playbooks/ -name "*.yml" \
  | grep -v bootstrap \
  | sort -r \
  | gum choose --header "Select a playbook")

gum confirm "Deploy ${playbook} to erebor?" || exit 1

set -x
env \
  ANSIBLE_CONFIG=../ansible.cfg \
ansible-playbook \
  --extra-vars "ansible_python_interpreter=/usr/local/bin/python" \
  --inventory "inventory.ini" \
  --tags "all" \
  "${playbook}"
