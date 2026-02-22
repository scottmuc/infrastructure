#!/usr/bin/env bash

cachix use scottmuc

cachix watch-exec scottmuc -- \
  nix --extra-experimental-features "nix-command flakes" \
  develop .#ci --command \
    "$@"
