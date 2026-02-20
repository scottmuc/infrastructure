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
  --inventory "../inventory.yml" \
  --tags "all" \
  "${playbook}"
