#!/usr/bin/env bash

set -e

ansible-lint --exclude secrets devices
