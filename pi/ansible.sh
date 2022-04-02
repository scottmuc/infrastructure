#!/usr/bin/env bash

set -e

case "$1" in
  bootstrap)
    shift
    playbook="./bootstrap-playbook.yml"
    ;;
  apply)
    shift
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

ansible-playbook -i "${ip}," ${playbook}
