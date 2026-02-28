#!/usr/bin/env bash

skopeo copy \
  --format=oci \
  docker://quay.io/skopeo/stable:latest \
  docker://zot.scottmuc.com/skopeo:latest
