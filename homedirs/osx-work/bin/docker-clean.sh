#!/usr/bin/env bash

set -e

docker rmi $(docker images -q --filter='dangling=true')
