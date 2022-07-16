#!/usr/bin/env bash

service navidrome stop

navidrome_version="0.47.5"
navidrome_release_url="https://github.com/deluan/navidrome/releases/download/v${navidrome_version}/navidrome_${navidrome_version}_Linux_armv7.tar.gz"

curl -L "${navidrome_release_url}" 2> /dev/null \
  | tar xzv -C /opt/navidrome

systemctl daemon-reload

service navidrome start
service navidrome status

