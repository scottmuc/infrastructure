#!/usr/bin/env bash

set -e

ansible-playbook -vv -i 192.168.2.10, --become ./main-playbook.yml
