#!/usr/bin/env bash

set -e

pushd dns
  if ! tofu fmt -check; then
    echo "********************************************************"
    echo "Terraform files aren't following tofu formatting rules"
    echo "********************************************************"
    exit 1
  fi

  tflint
popd

cat << EOT
********************************************************************************
The code has passed all the terraform static analyis checks!
********************************************************************************
EOT
