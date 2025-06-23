#!/usr/bin/env bash

set -eu -o pipefail

main() {
    check_node
    check_playwright

    # If we've reached here, all machine dependecnies are met!
    install_dependencies
    run_tests
}

run_tests() {
    ./node_modules/.bin/cucumber-js features/*.feature --require-module ts-node/register --require steps/*.ts
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
    browser_count="$(ls ~/.cache/ms-playwright/ | wc -l)"
    if (( browser_count == 0 )); then
        echo "Playwright browsers not installed, run 'npx playwright install'"
        exit 1
    fi
}

main "$@"
