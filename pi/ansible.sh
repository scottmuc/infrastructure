#!/usr/bin/env bash

set -e

case "$1" in
  bootstrap)
    shift
    become_args="--become --ask-become-pass"
    playbook="./bootstrap-playbook.yml"
    ;;
  apply)
    shift
    become_args="--become"
    playbook="./main-playbook.yml"
    ;;
  *)
    echo "Invalid arguments"
    echo ""
    echo "e.g.: ./ansible.sh bootstrap -i 192.168.2.105"
    echo "      ./ansible.sh apply # -i defaults to 192.168.2.10"
    exit 1
    ;;
esac

ip="192.168.2.10"
while getopts ":i:" opt; do
  case $opt in
    i) ip="$OPTARG"
    ;;
  esac
done

ansible-playbook -i "${ip}," ${become_args} ${playbook}
