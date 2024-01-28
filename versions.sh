#!/usr/bin/env bash

grep -ER '\s"*([0-9]+\.){1,2}[0-9]+"*$' \
  --exclude=*.{lock,tfstate,md,lock.hcl,lock.json,ini} \
  --exclude-dir={.git,.terraform} \
  .
