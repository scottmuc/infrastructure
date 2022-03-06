#!/usr/bin/env bash

set -e

ansible-playbook -v -i 192.168.2.10, --become ./main-playbook.yml
