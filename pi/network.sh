#!/bin/sh

systemctl stop dhcpcd
systemctl disable dhcpd
apt remote dhcpd5

# /etc/cnetwork/interfaces.d/eth0

auto eth0
allow-hotplug eth0
iface eth0 inet static
address 192.168.2.10
netmask 255.255.255.0
gateway 192.168.2.1
dns-nameservers 8.8.8.8
dns-search home.scottmuc.com
