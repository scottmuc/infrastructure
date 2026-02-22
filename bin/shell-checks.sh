#!/usr/bin/env bash

set -e

# shellcheck disable=SC2038
find . -path '*/node_modules' -prune -o -name "*.sh" -print \
  | xargs shellcheck

shellcheck homedirs/common/bin/*
