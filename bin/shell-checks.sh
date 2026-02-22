#!/usr/bin/env bash

set -e

find . -path '*/node_modules' -prune -o -name "*.sh" -print \
  | xargs shellcheck

shellcheck homedirs/common/bin/*
