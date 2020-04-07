#!/usr/bin/env bash

set -e

target_dir=${1:-~/}

if [ ! -d ${target_dir} ]
then
  echo ${target_dir} does not exist... bailing out
  exit -1
fi

pushd ${target_dir}
  if [ -d .git ]
  then
    echo It appears ${target_dir} is already a repository
    echo going to step away slowly and let you deal with it
    echo perhaps you have already bootstrapped this computer?
    exit -1
  fi
  git init
  git remote add origin https://github.com/scottmuc/osx-homedir.git
  git fetch --all
  git checkout master
popd

echo You are now ready to run:
echo
echo   ${target_dir}/bin/coalesce_this_machine
echo

