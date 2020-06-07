# Raspberry Pi

I now have a raspberry pi and this is how I set it up. The setup has been
informed by the [research](RESEARCH.md) I've done.

# Current Hardware

This is what I [bought from amazon][amazon].

[amazon]: https://www.amazon.de/dp/B07BNPZVR7

# Current Operating System

```
pi@raspberrypi:~ $ uname -a
Linux raspberrypi 4.19.118-v7+ #1311 SMP Mon Apr 27 14:21:24 BST 2020 armv7l GNU/Linux
```

# Features

* Ad blocking DNS for all networked devices
* Personal music streaming service
* Apartment network storage

# Setup

Why no standard configuration management tools? Mainly because I don't think
they are needed for an environment where I am the only maintainer. If I were to
distribute this as a "solution", I woud look to distribute in a more understood
way. For this device I am quite content with a supervised partially automated
setup.

## 1. Fresh machine configuration

Run `raspi-config` and enable SSHD and set the timezone.

## 2. Network configuration

Turn off `dhcpcd` and statically set the IP ([instructions][static-ip]). I saw
that a lot of people set static IPs in their `dhcpcd` configuration. I don't
really understand why one would continuing running `dhcpcd` when you are going
to statically assign the IP.

[static-ip]: https://raspberrypi.stackexchange.com/questions/78510/disable-dhcpcd-service-for-static-ip

```
systemctl stop dhcpcd
systemctl disable dhcpd
apt remote dhcpd5
```


```
# /etc/cnetwork/interfaces.d/eth0

auto eth0
allow-hotplug eth0
iface eth0 inet static
address 192.168.2.10
netmask 255.255.255.0
gateway 192.168.2.1
dns-nameservers 8.8.8.8
dns-search home.scottmuc.com
```

## 3. Setup Nginx ingress and TLS

```
apt-get install nginx certbot
certbot certonly --webroot -w /var/www/html -d home.scottmuc.com -m "scottmuc@gmail.com"
```

In `/etc/nginx/sites-available/home.scottmuc.com` paste in the following:

```
server {
    index index.html index.htm index.nginx-debian.html;
    server_name home.scottmuc.com;

    location /music/ {
        proxy_pass http://pi.home.scottmuc.com:4533;
    }

    listen [::]:443 ssl ipv6only=on;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/home.scottmuc.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/home.scottmuc.com/privkey.pem;
}

server {
    if ($host = home.scottmuc.com) {
        return 301 https://$host$request_uri;
    }

    listen 80 ;
    listen [::]:80 ;
    server_name home.scottmuc.com;
    return 404;
}
```

Need to research if using the `--nginx` flag to `certbot` is worth it. It adds
a separate `dh_key` along with some `ngninx` specific configuration.

## 4. Setup external USB

```
apt-get install exfat-fuse exfat-utils
mkdir /mnt/usb

# /etc/fstab entry
UUID=5A47-F8E2 /mnt/usb exfat defaults,auto,users,rw,nofail,umask=000 0 0
```

Then reboot to confirm the mount "sticks".

## 5. Install and run navidrome

Run [`navidrome.sh`](navidrome.sh) as `root` on the Pi.

# TODO

* Setup a static IP
* Setup the Pi to be a `dhcpd` server and disable it on my router
* Run navidrome with reduced priv users
* Run samba with reduced priv users
* Run pihole with reduced priv users
* Create a service wrapper for navidrome
* Setup backups of the navidrome DB
* Don't let certbot change ngninx config, just generate certs
* Figure out how to organize ngninx config cleanly
* setup a splash page for /
* secure samba sharing (should have a read-only user) and a power user
  with write privleges
* split pi-hole installation up into separate parts

## Tickets to Write

* https://github.com/scottmuc/infrastructure/commit/f3a9a06ce2dc77d4f978663a6ea8e2baf4ce0834
* Cannot install go 1.14.3 on my pi in FreeBSD
* Cannot build with CGO enabled targetting FreeBSD/arm64 on a FreeBSD VM
* Album art images break when you change your password
