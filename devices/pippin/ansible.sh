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

inventory_choice=$(gum choose --header "Select inventory" \
  "inventory file" \
  "specific ip")

inventory_arg="../inventory.yml"
if [ "${inventory_choice}" = "specific ip" ]; then
  inventory_arg="$(gum input --placeholder "192.168.2.x"),"
fi

gum confirm "Deploy ${playbook} using ${inventory_choice}?" || exit 1

set -x
env \
  ANSIBLE_CONFIG=../ansible.cfg \
ansible-playbook \
  --inventory "${inventory_arg}" \
  --tags "${tags}" \
  "${playbook}"
