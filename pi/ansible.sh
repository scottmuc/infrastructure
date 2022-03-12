#!/usr/bin/env bash

set -e

pi_ip="${1:-192.168.2.10}"

ansible-playbook -i "${pi_ip}," --become ./main-playbook.yml
