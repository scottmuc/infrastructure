# Raspberry Pi

I now have a raspberry pi and will add my setup here.

# Current Hardware

This is what I [bought from amazon][amazon].

[amazon]: https://www.amazon.de/dp/B07BNPZVR7

# Current Operating System

Going with [FreeBSD][freebsd] for nostalgic reasons. There's a pretty easy
[howto][howto] that got me up and running quickly.

[freebsd]: https://www.freebsd.org/
[howto]: https://www.freebsdfoundation.org/freebsd/how-to-guides/installing-freebsd-for-raspberry-pi/

```
freebsd@generic:~ % uname -a
FreeBSD generic 12.1-RELEASE FreeBSD 12.1-RELEASE r354233 GENERIC  arm64
```

# Paving Journal

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

# Airsonic Journal

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

# Tools to look at

* ~~neofetch~~ pretty system information, nice but not necessary
* glances
* bsmtrace
* https://www.navidrome.org/

# TODO

* Setup a static IP. Either on the DHCP side or on the machine side
* Run stuff with reduced priv users
* Setup localization so files with special characters can get loaded
* install nginx and letsencrypt to have a TLS terminating endpoint

# FreeBSD Musings

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

# Train Rides

* https://www.youtube.com/watch?v=dxYiz4knmkU
* https://www.youtube.com/watch?v=Mw9qiV7XlFs
* https://www.youtube.com/watch?v=zomZywCAPTA

# Tickets to Write

* https://github.com/scottmuc/infrastructure/commit/f3a9a06ce2dc77d4f978663a6ea8e2baf4ce0834
* Cannot install go 1.14.3 on my pi
* Airsonic very slow to the point of not being usable
