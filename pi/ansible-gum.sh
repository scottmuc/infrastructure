#!/usr/bin/env sh

set -e

playbook=$(find . -name "*playbook.yml" | gum choose)
ip=$(gum choose "192.168.2.10" "other")

if [ "${ip}" = "other" ]; then
  ip=$(gum input --placeholder "192.168.2.x")
fi

echo "deploying ${playbook} to ${ip}"
gum confirm || exit 1

ansible-playbook \
  --extra-vars "ansible_python_interpreter=/usr/bin/python3" \
  --inventory "${ip}," \
  "${playbook}"
