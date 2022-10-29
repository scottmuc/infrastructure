#!/usr/bin/env sh

set -e

playbook=$(find . -name "*playbook.yml" | sort -r | gum choose)
tags=$(gum choose "all" "sysctls" "prometheus" "navidrome" "nginx")
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
