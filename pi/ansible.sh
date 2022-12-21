#!/usr/bin/env sh

set -e

gum style --bold "Select a playbook"
playbook=$(find . -name "*playbook.yml" | sort -r | gum choose)
gum style --bold "Select tag to apply"
tags=$(gum choose \
  "all"           \
  "certbot"       \
  "grafana"       \
  "logging"       \
  "navidrome"     \
  "nginx"         \
  "prometheus"    \
  "sysctls"       \
)

gum style --bold "Select inventory"
inventory_choice=$(gum choose "inventory file" "specific ip")

if [ "${inventory_choice}" = "specific ip" ]; then
  inventory_arg="$(gum input --placeholder "192.168.2.x"),"
else
  inventory_arg="inventory.ini"
fi

gum confirm "Deploy ${playbook} using ${inventory_choice}?" || exit 1

set -x
ansible-playbook \
  --extra-vars "ansible_python_interpreter=/usr/bin/python3" \
  --inventory "${inventory_arg}" \
  --tags "${tags}" \
  "${playbook}"
