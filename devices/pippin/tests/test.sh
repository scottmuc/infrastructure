#!/usr/bin/env bash

set -eu -o pipefail

main() {
    check_node

    # If we've reached here, all machine dependecnies are met!
    install_dependencies
    run_tests
}

run_tests() {
    ./node_modules/.bin/cucumber-js
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
