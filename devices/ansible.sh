#!/usr/bin/env sh

set -e

playbook=$(find ./ -wholename "*/playbooks/*.yml" \
  | sort -r \
  | grep -v bootstrap \
  | gum choose --height 20 --header "Select a playbook")

gum confirm "Running ${playbook}" || exit 1

set -x
env \
  ANSIBLE_CONFIG=./ansible.cfg \
ansible-playbook \
  --inventory ./inventory.yml \
  "${playbook}"
