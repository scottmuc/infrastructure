#!/usr/bin/env bash

set -e

pushd devices
  ansible-lint \
    --exclude secrets \
    --exclude concourse \
    --exclude root
popd
