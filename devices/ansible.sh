#!/usr/bin/env sh

set -e

playbook=$(find ./playbooks/ -name "*.yml" \
  | sort -r \
  | gum choose --header "Select a playbook")

gum confirm "Running ${playbook}" || exit 1

set -x
env \
  ANSIBLE_CONFIG=./ansible.cfg \
ansible-playbook \
  --inventory ./inventory.yml \
  "${playbook}"
