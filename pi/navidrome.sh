#!/usr/bin/env bash

service navidrome stop

rm -rf /opt/navidrome
mkdir -p /opt/navidrome/ffmpeg

navidrome_version="0.23.0"
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


cat > /etc/systemd/system/navidrome.service <<EOF
[Unit]
Description=Navidrome Music Server and Streamer compatible with Subsonic/Airsonic
After=remote-fs.target network.target
AssertPathExists=/opt/navidrome

[Install]
WantedBy=multi-user.target

[Service]
User=navidrome
Group=root
Type=simple
ExecStart=/opt/navidrome/navidrome -configfile "/opt/navidrome/navidrome.toml"
WorkingDirectory=/opt/navidrome
TimeoutStopSec=20
KillMode=process
Restart=on-failure
Environment="PATH=/opt/navidrome/ffmpeg"

# See https://www.freedesktop.org/software/systemd/man/systemd.exec.html
DevicePolicy=closed
NoNewPrivileges=yes
PrivateTmp=yes
PrivateUsers=yes
ProtectControlGroups=yes
ProtectKernelModules=yes
ProtectKernelTunables=yes
RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6
RestrictNamespaces=yes
RestrictRealtime=yes
SystemCallFilter=~@clock @debug @module @mount @obsolete @privileged @reboot @setuid @swap
ReadWritePaths=/mnt/usb/navidrome
ProtectSystem=strict
ProtectHome=true
EOF

chown -R navidrome:root /opt/navidrome

useradd --system navidrome --home-dir /opt/navidrome --shell /usr/sbin/nologin/

systemctl daemon-reload

service navidrome start
service navidrome status
