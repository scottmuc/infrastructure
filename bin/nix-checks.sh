#!/usr/bin/env bash

set -e

for flake in $(find . -name "flake.nix"); do
  echo "*********************************************************"
  echo " Inspecting: ${flake}"
  echo "*********************************************************"
  dir=$(dirname "${flake}")
  file=$(basename "${flake}")

  pushd "${dir}" > /dev/null
    nixfmt --check "${file}"
    nix flake check
    flake-checker --fail-mode
  popd
done
