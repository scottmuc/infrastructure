#!/usr/bin/env bash

set -e

pushd devices
  ansible-lint \
    --exclude secrets \
    --exclude concourse \
    --exclude root
popd

cat << EOT
********************************************************************************
The code has passed all the ansible static analyis checks!
********************************************************************************
EOT
