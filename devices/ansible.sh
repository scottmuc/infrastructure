#!/usr/bin/env sh

set -e

drift_detection_args=""

playbook=$(find ./ -wholename "*/playbooks/*.yml" \
  | sort -r \
  | grep -v bootstrap \
  | gum choose --height 20 --header "Select a playbook")

if gum confirm "Drift detection only?"; then
  drift_detection_args="--check --diff"
fi

set -x
# shellcheck disable=SC2086
env \
  ANSIBLE_CONFIG=./ansible.cfg \
ansible-playbook \
  --inventory ./inventory.yml \
  "${playbook}" ${drift_detection_args}
