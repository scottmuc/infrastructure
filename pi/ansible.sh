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
ip=$(gum choose "192.168.2.10" "other")

if [ "${ip}" = "other" ]; then
  ip=$(gum input --placeholder "192.168.2.x")
fi

gum confirm "Deploy ${playbook} to ${ip}?" || exit 1

ansible-playbook \
  --extra-vars "ansible_python_interpreter=/usr/bin/python3" \
  --inventory "${ip}," \
  --tags "${tags}" \
  "${playbook}"
