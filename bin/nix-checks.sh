#!/usr/bin/env bash

set -e

# shellcheck disable=SC2044
for flake in $(find . -name "flake.nix"); do
  echo "*********************************************************"
  echo " Inspecting: ${flake}"
  echo "*********************************************************"
  dir=$(dirname "${flake}")
  file=$(basename "${flake}")

  pushd "${dir}" > /dev/null
    nixfmt --check "${file}"
    # Ignore flake check because I'm not sure I want the whole nix
    # echosystem in the ci image yet.
    #nix flake check
    flake-checker --fail-mode
  popd
done

cat << EOT
********************************************************************************
The code has passed all the nix static analyis checks!
********************************************************************************
EOT
