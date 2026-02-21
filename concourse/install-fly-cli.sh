#!/usr/bin/env sh

curl 'https://concourse.scottmuc.com/api/v1/cli?arch=amd64&platform=linux' -o fly
chmod +x ./fly
sudo mv ./fly /usr/local/bin/
