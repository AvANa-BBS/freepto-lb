Freepto is discontinued
=======================

During these years we developed Freepto with the main goal of providing a ready-to-use, encrypted OS to whoever was willing to abandon proprietary OS.

For security reasons it is paramunt to keep Freepto always up-to-date.
Unfortunately, this requires lot of time, and the current developer team is not able to keep up with it.

Also, some choices we took 3 years ago now show up all their limits:

We considered that attacks such as malware were possible only in a limited number of cases and distinct from mass-surveilance techniques.
It is now evident that we were wrong, and that advanced attacks are quite common.
We preferred not using Tor extensively, thinking that the slowness of such a network would be too much of a burden to our users; in the meanwhile, 
Tor got faster, while we reconsidered that usability need a broad project, capable of writing good documentation and develop carefully designed interfaces

Therefore, we are ending Freepto development.

We suggest to Freepto users to give a try to Tails, a live OS focused on privacy and anonimity. Read more on Tails website: https://tails.boum.org/


Freepto-lb
==========

Encrypted GNU/Linux OS (based on Debian Wheezy) wich can be installed on USB flash drive.

Freepto is designed for encrypt your communications (OTR, GPG, SSL), carry your documents in secure way (LUKS) and save your anonymity (TOR, OPENVPN)


For developers: build Freepto
=============================

You need a debian wheezy  and some packages installed:
`aptitude install live-build python git-core debootstrap`

Just clone a repository, edit the configuration file:

 vim config/freepto

and run:

`lb config && lb build`

and you'll find a binary.img file :)

We are also providing a Vagrantfile to create quickly a Freepto development environment
https://github.com/AvANa-BBS/freepto-vagrant

See more information:
http://www.freepto.mx/en/dev-team/


For users: Burn Freepto on a USB
================================

You can download the latest images from
https://download.freepto.mx

Then follow our documentation:
http://www.freepto.mx/en/get-started/

Documentation
=============

Italiano:
* https://we.riseup.net/freepto-wiki/freepto-docs
* https://www.freepto.mx/

Castellano:
* https://we.riseup.net/freepto-wiki/freepto-docs-es
* https://www.freepto.mx/es/

English:
* https://we.risep.net/freepto-wiki/freepto-docs-en
* https://www.freepto.mx/en

Screenshots
============

![](http://www.freepto.mx/static/syslinux-berenjena.png)
![](http://www.freepto.mx/static/paranoiatools.png)
