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

* ~~Ad blocking DNS for all networked devices~~ Not yet as the more I read about
  pi-hole, the more I don't like it.
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

## 6. Install and configure Samba

`apt-get install samba`

Add the following to `/etc/samba/smb.conf`
```
[All Stuff]
  path = /mnt/usb
  browseable = yes
  read only = no
  guest ok = no
  valid users = pi
```

Then create the user:

`sudo smbpasswd -a pi`

After restarting the service `sudo systemctl restart smbd.service` the share
will be accessible with that account.

## 7. Install and setup ad blocking DNS resolver

This still needs some work. I was initially looking at [pi-hole][pi-hole] but
upon further investigation, I found it didn't fit how I like to operate things.

1. The `curl bash` script is way too large and complicated to understand for me.
2. It installs another `httpd` server when I already have one installed.
3. It still requires you to install a resursive resolver if you don't want to
   delegte resolution to one of the upstream providers (I didn't know this going
   into things). I wanted to avoid third-party upstream providers in the first
   place.
4. Not a fan that it's a fork of [`dnsmasq`][dnsmasq].
5. Why can I not install it via `apt-get intsall`? And if I can, why the `curl bash`?
6. I sense that pi-hole is intended to be more of an appliance type application
   and therefore it's best to dedicate a machine to it. It doesn't appear to
   play well in a shared server.

Some of my complaints might be me not understanding things but the more I
looked into it, the more layers and confusion I found.

[pi-hole]: https://pi-hole.net/
[dnsmasq]: https://docs.pi-hole.net/ftldns/dns-resolver/

# TODO

* [x] Setup a static IP
* [ ] Setup the Pi to be a `dhcpd` server and disable it on my router
* [x] Run navidrome with reduced priv users
* [ ] Create a service wrapper for navidrome
* [ ] ~~Setup backups of the navidrome DB~~ No longer needed as the data
  lives on the external disk therefore it won't be wiped when I repave
  the Pi.
* [x] Don't let certbot change ngninx config, just generate certs
* [x] Figure out how to organize ngninx config cleanly
* [ ] setup a splash page for /
* [x] secure samba sharing (should have a read-only user) and a power user
  with write privleges
* [ ] ~~Run samba with reduced priv users~~ Samba needs to run as root in order
  to fork as the users for specific share access.
* [ ] ~~split pi-hole installation up into separate parts~~ No longer running
  pi-hole.
* [ ] ~~Run pihole with reduced priv users~~ No longer running pi-hole.

## Tickets to Write

* [ ] https://github.com/scottmuc/infrastructure/commit/f3a9a06ce2dc77d4f978663a6ea8e2baf4ce0834
* [ ] Cannot install go 1.14.3 on my pi in FreeBSD
* [ ] Cannot build with CGO enabled targetting FreeBSD/arm64 on a FreeBSD VM
* [ ] Album art images break when you change your password
