#!/usr/bin/env sh

set -e

playbook=$(find . -name "*playbook.yml" \
  | sort -r \
  | gum choose --header "Select a playbook")

tags=$(gum choose --header "Select tag to apply" \
  "all"           \
  "certbot"       \
  "fail2ban"      \
  "git"           \
  "grafana"       \
  "keys"          \
  "logging"       \
  "mounts"        \
  "navidrome"     \
  "nginx"         \
  "prometheus"    \
  "sysctls"       \
)

inventory_choice=$(gum choose --header "Select inventory" \
  "inventory file" \
  "specific ip")

inventory_arg="inventory.ini"
if [ "${inventory_choice}" = "specific ip" ]; then
  inventory_arg="$(gum input --placeholder "192.168.2.x"),"
fi

gum confirm "Deploy ${playbook} using ${inventory_choice}?" || exit 1

set -x
ansible-playbook \
  --extra-vars "ansible_python_interpreter=/usr/bin/python3" \
  --inventory "${inventory_arg}" \
  --tags "${tags}" \
  "${playbook}"
