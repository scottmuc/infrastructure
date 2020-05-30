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


[freebsd-airsonic]: https://airsonic.github.io/docs/install/example/freebsd-freenas/

# Tools to look at

* neofetch
* glances
* bsmtrace

# TODO

* Setup a static IP. Either on the DHCP side or on the machine side

