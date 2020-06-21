#!/usr/bin/env bash

service prometheus stop

rm -rf /opt/prometheus
mkdir /opt/prometheus

prometheus_url="https://github.com/prometheus/prometheus/releases/download/v2.19.1/prometheus-2.19.1.linux-armv7.tar.gz"

curl -L "${prometheus_url}" 2> /dev/null \
  | tar xzv --strip-components=1 -C /opt/prometheus


useradd --system prometheus --home-dir /opt/prometheus --shell /usr/sbin/nologin/

chown -R prometheus:root /opt/prometheus

cat > /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus
After=remote-fs.target network.target
AssertPathExists=/opt/prometheus

[Install]
WantedBy=multi-user.target

[Service]
User=prometheus
Group=root
Type=simple
ExecStart=/opt/prometheus/prometheus --storage.tsdb.path=/mnt/usb/prometheus
WorkingDirectory=/opt/prometheus
TimeoutStopSec=20
KillMode=process
Restart=on-failure

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
ReadWritePaths=/mnt/usb/prometheus
ProtectSystem=strict
ProtectHome=true
EOF

systemctl daemon-reload

service prometheus start
service prometheus status