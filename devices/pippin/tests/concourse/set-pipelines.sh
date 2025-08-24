#!/usr/bin/env bash

set -euo pipefail

fly -t concourse.scottmuc.com \
  set-pipeline \
  --pipeline docker-image \
  --config ./docker-image.yml

fly -t concourse.scottmuc.com \
  set-pipeline \
  --pipeline pippin \
  --config ./end-to-end.yml
