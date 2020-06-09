#!/usr/bin/env bash

rm -rf /opt/navidrome
mkdir -p /opt/navidrome/ffmpeg

navidrome_version="0.22.0"
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

cat > /opt/navidrome/run.sh <<'EOF'
#!/bin/bash

exec \
env \
  PATH=/opt/navidrome/ffmpeg:$PATH \
  ./navidrome
EOF

chmod +x /opt/navidrome/run.sh
chown -R navidrome:root /opt/navidrome

useradd --system navidrome --home-dir /opt/navidrome --shell /usr/sbin/nologin/

# To launch
# cd /opt/navidrome
# sudo -u navidrome nohup ./run.sh &> /mnt/usb/navidrome/logs/navidrome.log &
