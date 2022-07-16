#!/usr/bin/env bash

service navidrome stop

navidrome_version="0.47.5"
navidrome_release_url="https://github.com/deluan/navidrome/releases/download/v${navidrome_version}/navidrome_${navidrome_version}_Linux_armv7.tar.gz"
ffmpeg_download_url="https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-armhf-static.tar.xz"

curl -L "${navidrome_release_url}" 2> /dev/null \
  | tar xzv -C /opt/navidrome

(cd /tmp && curl -LO "${ffmpeg_download_url}" 2> /dev/null)

tar xvf /tmp/ffmpeg-release-armhf-static.tar.xz --strip-components=1 -C /opt/navidrome/ffmpeg

cat > /opt/navidrome/navidrome.toml <<EOF
LogLevel = "INFO"
BaseURL = "/music"
ScanInterval = "60m"
TranscodingCacheSize = "15MB"
DataFolder = "/mnt/usb/navidrome"
MusicFolder = "/mnt/usb/music"
EOF

systemctl daemon-reload

service navidrome start
service navidrome status

