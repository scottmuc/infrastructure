#!/usr/bin/env bash

set -eu -o pipefail

main() {
    # Can't really do much if we don't have Node installed
    check_node

    # If we've reached here, all machine dependecnies are met!
    install_dependencies

    if [[ "${NAVIDROME_TEST_ENVIRONMENT-:""}" != "local" ]]; then
      install_playwright_browsers
    fi

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

install_playwright_browsers() {
  npx playwright install
}

run_tests() {
    npx cucumber-js \
      features/*.feature \
      --require-module ts-node/register \
      --require steps/*.ts \
      --format pretty
}

install_dependencies() {
    npm install
}

check_node() {
    if ! command -v node >/dev/null; then
        echo "Node JS not detected, please install Node JS into your environment"
        exit 1
    fi
    echo "Node JS location : $(command -v node)"
    echo "Node JS version  : $(node --version)"
}

main "$@"
