#!/usr/bin/env bash

set -eu -o pipefail

main() {
    # Can't really do much if we don't have Node installed
    check_node

    # If we've reached here, all machine dependecnies are met!
    install_dependencies

    load_test_env
    run_tests
}

# This will only work on Scott's machine, but if you export
# NAVIDROME_PASSWORD, the default behaviour will be skipped.
load_test_env() {
    : "${NAVIDROME_BASE_URL:="https://home.scottmuc.com/music"}"
    export NAVIDROME_BASE_URL
    : "${NAVIDROME_USERNAME:="tester"}"
    export NAVIDROME_USERNAME
    : "${NAVIDROME_PASSWORD:=$(op read "op://Personal/tester - navidrome/password")}"
    export NAVIDROME_PASSWORD
}

run_tests() {
    # use DEBUG=pw:browser to get useful headless browser details
    ./node_modules/.bin/cucumber-js \
      features/*.feature \
      --require-module ts-node/register \
      --require steps/*.ts \
      --format progress-bar
}

install_dependencies() {
    if [[ -L ./node_modules ]]; then
      # This case handles the Nix devShell
      echo "node_modules is a symlink, assuming a nix devShell and skipping npm install"
    elif [[ "${NAVIDROME_TEST_ENVIRONMENT}" == "container" ]]; then
      # This case handles when running in a container (usually Concourse)
      echo "node_modules is exists in nix store, assuming a container run, and skipping npm install"
      ln -sf "${NODE_PATH}" ./node_modules
    else
      # Fall back to old fashioned fetching random stuff from the Internet
      npm install
    fi
}

check_node() {
    echo "Node JS location : $(command -v node)"
    echo "Node JS version  : $(node --version)"
}

main "$@"
