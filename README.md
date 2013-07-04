Freepto-lb
==========

Encrypted GNU/Linux OS (based on Debian Wheezy) wich can be installed on USB flash drive.

Freepto is designed for encrypt your communications (OTR, GPG, SSL), carry your documents in secure way (LUKS) and save your anonymity (TOR, OPENVPN)


Make Freepto
============

### Make chroot:
> $ sudo debootstrap --include=debian-keyring,debian-archive-keyring,cryptsetup,live-build,git,ca-certificates --arch i386 sid ~/freepto-lb/

> $ sudo chroot ~/freepto-lb /bin/bash

### Cache for APT (only if you use a non-chrooted debian sid):
> $ sudo apt-get install apt-cacher-ng

> $ sudo /etc/init.d/apt-cacher-ng start

> $ export http_proxy=http://localhost:3142/

### Make your Freepto image:
> $ sudo apt-get install install live-build

> $ git clone https://github.com/AvANa-BBS/freepto-lb.git

> $ cd freepto-lb

> $ lb config && lb build

### Create USB Pen Drive:

Use "dmesg" to identify the usb device:
> $ dmesg

Run make-freepto.sh:
> $ sudo bash makefreepto -h

> $ sudo bash makefreepto -i binary.img -p myS3cr3t#luksp4ssw0rd /dev/sdX

### Read documentation:
https://we.riseup.net/avana/freepto-docs

http://avana.forteprenestino.net/freepto

### Screenshots:

![](http://avana.forteprenestino.net/freepto/img/screenshot/freepto1.png)
![](http://avana.forteprenestino.net/freepto/img/screenshot/freepto3.png)
![](http://avana.forteprenestino.net/freepto/img/screenshot/freepto4.png)
