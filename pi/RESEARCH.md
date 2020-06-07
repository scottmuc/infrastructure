# Raspberry Pi Research

This is a place for all the notes I've taken over the repeated re-planting
of my Raspberry Pi.

## FreeBSD Paving Journal

Going with [FreeBSD][freebsd] for nostalgic reasons. There's a pretty easy
[howto][howto] that got me up and running quickly.

[freebsd]: https://www.freebsd.org/
[howto]: https://www.freebsdfoundation.org/freebsd/how-to-guides/installing-freebsd-for-raspberry-pi/

```
freebsd@generic:~ % uname -a
FreeBSD generic 12.1-RELEASE FreeBSD 12.1-RELEASE r354233 GENERIC  arm64
```

* login as root and run `pkg`. It'll install the package manager
* `pkg install doas` and change root password to something very hard to guess

Create `/usr/local/etc/doas.conf` with the contents:

```
permit nopass keepenv :wheel
permit nopass keepenv root as root
```

* Set TZ: `doas cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime`
* Set Date and Time: `doas date YYYYmmddHHMM.SS`

* Fetch the ports `doas portsnap fetch`
* Extract the ports `doas portsnap extract`

Install and configure exfat

```
/usr/ports/sysutils/fusefs-exfat
doas make install
```

**note** the above install was very slow. Next time I should look at installing some
of the dependencies as packages if possible.

* `perl5.30`, `gmake`, `iconv`, `gettext`, `autoconf`


* add `kld_list="fuse"` to `/etc/rc.conf` ([useful info][kld_list_help])
* `doas mkdir /mnt/extusb`
* add `/dev/da0s1 /mnt/extusb exfat rw,late,mountprog=/usr/local/sbin/mount.exfat  0 0` to `/etc/fstab` ([useful
  info][fstab_help]) **note** had to remove `noauto` since I do want the drive mounted once booted
* reboot to confirm that the mounting survives :-)

[kld_list_help]: https://forums.freebsd.org/threads/difference-between-boot-loader-conf-and-etc-rc-conf.53694/
[fstab_help]: https://forums.freebsd.org/threads/mounting-exfat-and-ntfs-3-filesystems-with-fstab.69491/

### Airsonic Journal

* Followed [installer documentation][freebsd-airsonic]

* `doas pkg install tomcat85`

OpenJDK has a message saying the following needs to be in `/etc/fstab`

```
fdesc /dev/fd fdescfs rw 0 0
proc /proc procfs rw 0 0
```

* add `tomcat85_enable="YES"` to `/etc/rc.conf` (this corresponds to a file called `/usr/local/etc/rc.d/tomcat85`)

**note** deploying the `airsonic.war` took a very long time. Over 40m so far. Response time is slow in
general too. I wonder this is a known [issue][gh-issue]?

[gh-issue]: https://github.com/airsonic/airsonic/issues/881
[freebsd-airsonic]: https://airsonic.github.io/docs/install/example/freebsd-freenas/

OK, turns out [the docs][pi-docs] do state that openJDK will result in very slow deployments. I wasn't looking
at this page because I was looking at the FreeBSD page above. There's an [open issue][openjdk-issue] about
it as well.

In order to use the Oracle JDK, I need to run it in linux emulation. I couldn't run `kldload linux64` so
I'm assuming I don't have that module available to me.

[pi-docs]: https://airsonic.github.io/docs/install/example/raspberrypi/
[openjdk-issue]: https://github.com/airsonic/airsonic/issues/283

### Navidrome Journal

Going to back out of the JDK/Airsonic path now and will aim to build navidrome on my laptop
and deploy the the pi thanks to Go's cross compiler.

I spoke too soon. There are native dependencies so I need to enable CGO which requires
a cross platform C compiler. 

https://dh1tw.de/2019/12/cross-compiling-golang-cgo-projects/

I also tried the route of creating a FreeBSD VM on my machine using Vagrant. I got build errors like:

```
vagrant@freebsd:~/workspace/navidrome % env CC=/usr/local/bin/aarch64-unknown-freebsd12.1-gcc CGO_ENABLED="1" GOOS=freebsd GOARCH=arm64 go build
# runtime/cgo
In file included from /usr/include/signal.h:43:0,
                 from gcc_freebsd_arm64.c:9:
/usr/include/sys/_ucontext.h:46:2: error: unknown type name 'mcontext_t'
  mcontext_t uc_mcontext;
  ^~~~~~~~~~
```

[These docs][ucontext] made me think that there's something in this dependency tree that is not quite portable. A rabbit
hole for another time. It's made it clear to me that understand cross platform compilation is an area that I don't
understand very well and could use a bit of studying here.

[uconext]: https://www.unix.com/man-page/FreeBSD/3/ucontext/

### FreeBSD Musings

I haven't really used FreeBSD since the 4.x/5.x era.

Some thing have changed:

* portsnap - no more cvsup! Port and pkg installation feel familiar
* doas seems to be mentioned more as a better alternative to sudo

I find FreeBSD follows a [Make me think!][make-me-think] philosophy. It doesn't do everything
automatically for you. When you install a service it won't auto-start it. You'll have to
explicitly enable it in /etc/rc.conf. Configuration is usually secure by default or, no configuration
exists and you'll be required to think about how you want to configure that thing you
just installed. I like this approach a lot. As I operate it, I feel like I'm improving my
understanding.

I'm amazed at the response that a couple tweets got. It left me with the impression that the 
FreeBSD is a community looking for opportunities to show support. I know it's anecdotal but
it did give me a very positive impression. 

https://twitter.com/ScottMuc/status/1266650792024518657

[make-me-think]: https://blog.prototypr.io/make-me-think-90b46aa50513

## Raspberry Pi OS

### Back to Raspian

Going to park FreeBSD at the moment.

Downloaded Raspberry OS Lite from [the website][raspi-download]. Ran `raspi-config` to enable
ssh access.

I thought I would go down setting up ingress first. The instructions for lets encrypt were
pretty easy: https://certbot.eff.org/lets-encrypt/debianbuster-nginx

```
apt-get install nginx certbot python-certbot-nginx
certbot --nginx
```

At some point I'll look at how all this works so I don't have to go through the interactive
installer next time I repave.

Good news is that https://home.scottmuc.com/ works now.

Getting the USB device mounted was just as easy in FreeBSD

```
apt-get install exfat-fuse exfat-utils
mkdir /media/extusb
mount -t exfat /dev/sda1 /media/extusb

# /etc/fstab entry
UUID=5A47-F8E2 /mnt/usb exfat defaults,auto,users,rw,nofail,umask=000 0 0
```

At the moment, I'm happy to re-mount things after a reboot.

I followed the [pre-built binaries][prebuild] installation instructions and it was painless.
However, I am having issues reading my music library. I get the following error message:

```
ERRO[0002] Error importing MediaFolder                   error="error extracting metadata files" folder=/home/pi/music
ERRO[0002] Errors while scanning media. Please check the logs
ERRO[0002] Error scanning media folder                   error="errors while scanning media" folder=/home/pi/music
```

This happens even when I copy a single mp3 and put it into a folder and configure navidrome to look
at the one. Going to try installing ffmpeg through apt now.

After installing `ffmpeg` through apt, the reading of the library works now. To enable public access
I added the following to `/etc/nginx/sites-enabled/default`

```
        location /music/ {
                proxy_pass http://pi.home.scottmuc.com:4533;
        }
```

Need to figure out how to now do ngninx surgery to get everything configured. Especially since the
`certbot` it automatically doing things to this file. I'll likely change that later.

[prebuild]: https://www.navidrome.org/docs/installation/pre-built-binaries/
[raspi-download]: https://www.raspberrypi.org/downloads/raspbian/

### Samba Setup

I recall doing this many years ago. This is what I did:

`apt-get install samba`

Inside `/etc/samba/smb.conf` I added the lines

```
[All Stuff]
  path = /mnt/usbdisk
  browseable = yes
  read only = no
  guest ok = yes
```

### DNS

I would like to reduce the ads and protect my network so I thought I would
tinker with [pi-hole][pi-hole].

The curl-bash did the trick. I'm not too happy with the install though. Why
can't it be installed as a debian package? I also didn't like that it blindly
installed lighttpd which also binds to port 80 when I already have nginx
running.

[pi-hole]: https://github.com/pi-hole/pi-hole/#one-step-automated-install

### DHCP

I think eventually it would be best to use the Pi as my DHCP server (for
the auto DNS server setting).

I cannot switch DNS in my router config but I can at least disable DHCP.

# Train Rides to Watch When Repaving

* [Führerstandsmitfahrt S-Bahn Berlin von Alexanderplatz nach Potsdam auf der S7 in 4K](https://www.youtube.com/watch?v=dxYiz4knmkU)
* [Cab ride St. Moritz - Tirano (Bernina pass), Switzerland to Italy](https://www.youtube.com/watch?v=Mw9qiV7XlFs)
* [4K CABVIEW Bar - Bijelo Polje -102 tunnels -96 bridges -1029m altitude change from Sea to Mountains](https://www.youtube.com/watch?v=zomZywCAPTA)


