#!/usr/bin/env bash

set -e

# shellcheck disable=SC2038
find . -path '*/node_modules' -prune -o -name "*.sh" -print \
  | xargs shellcheck

shellcheck home/common/bin/*

cat << EOT
********************************************************************************
The code has passed all the bash static analyis checks!
********************************************************************************
EOT
