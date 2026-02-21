#!/usr/bin/env sh

set -e

  playbook=$(find ./playbooks/ -name "*.yml" \
  | sort \
  | gum choose --header "Select a playbook")

tags=$(gum choose --header "Select tag to apply" \
  "all"           \
  "lanmanager"    \
  "logging"       \
  "monitoring"    \
  "mounts"        \
  "navidrome"     \
  "webserver"     \
)

gum confirm "Run ${playbook}" || exit 1

set -x
env \
  ANSIBLE_CONFIG=../ansible.cfg \
ansible-playbook \
  --inventory "../inventory.yml" \
  --tags "${tags}" \
  "${playbook}"
