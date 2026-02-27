#!/usr/bin/env bash

# https://concourse-ci.org/docs/operation/creds/vault/#using-a-periodic-token
vault token create \
  -tls-skip-verify \
  -address https://merry.middle-earth.internal:8200 \
  --policy concourse \
  --period 1h
