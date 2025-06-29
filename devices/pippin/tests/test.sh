#!/usr/bin/env bash

set -eu -o pipefail

main() {
    # Can't really do much if we don't have Node installed
    check_node

    # If we've reached here, all machine dependecnies are met!
    install_dependencies

    # Must check browsers after installing dependencies
    check_playwright
    run_tests
}

run_tests() {
    npx cucumber-js \
      features/*.feature \
      --require-module ts-node/register \
      --require steps/*.ts
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

check_playwright() {
    if npx playwright install --dry-run | grep -q 'Installing'; then
        echo "Playwright browsers not installed, run 'npx playwright install'"
        exit 1
    fi
    echo "All Playwright browsers are installed"
}

main "$@"
