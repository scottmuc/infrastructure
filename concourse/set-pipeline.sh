#!/usr/bin/env bash

set -euo pipefail

fly -t concourse.scottmuc.com \
  set-pipeline \
  --pipeline mucrastructure \
  --config ./mucrastructure.yml
