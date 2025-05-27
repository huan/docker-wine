# docker-wine

![Docker](https://github.com/huan/docker-wine/workflows/Docker/badge.svg)

[![dockeri.co](https://dockeri.co/image/zixia/wine)](https://hub.docker.com/r/zixia/wine/)

Docker Base Image for Wine Also Supports Arm Architecture

## Features

1. `WINEARCH=i386`
1. `gecko`
1. `winetricks win7`
1. `winetricks riched20`
1. User:Group `user:group`
1. [winescript](https://www.linux.org/threads/running-windows-batch-files-on-linux.11205/) to run `.bat` like a `.sh`
1. `support arm`

## Usage

### Versioning

The docker image has two schema of the versioning:

1. `X.Y` (X >=1 ): This is for the wine version.
    1. `zixia/wine:4.0`: wine-4.0
    1. `zixia/wine:5.0`: wine-5.0
1. `x.y` (x = 0): This is for the docker image version.
    1. `zixia/wine:0.2`: docker-wine version 0.2
1. `arm64` (arm64): This is for the docker image of arm64 architecture.

## Links

## History

### master v0.6

1. Added support for armhf and arm64 architectures

### master v0.5

1. Upgrade to Debian 11 (bullseye)

### v0.4 (Aug 24, 2021)

1. Upgrade to Wine version 6
1. Rename default branch from `master` to `main`

### v0.3 (Jan 9, 2020)

1. Use Debian 10 (Buster) to replace Ubuntu 19.10 (Eoan) (Issue [#3](https://github.com/huan/docker-wine/issues/3))

### v0.2 (Mar 12, 2020)

1. Wine v5.0 with Ubuntu 19.10 (eoan)
1. Add `winescript`
1. Enable GitHub Actions with Docker Hub Deploying

### v0.1 (Feb 17, 2020)

1. Project created for:
    1. [DoChat](https://github.com/huan/docker-wechat)
    1. [DoWork](https://github.com/huan/docker-wxwork)
    1. [Docker Windows](https://github.com/huan/docker-windows)
1. Wine v4.0.2 with Ubuntu 19.10 (eoan)

## Thanks

- [Support linux armhf/arm64 #10](https://github.com/huan/docker-wine/pull/10) from [@linrol](https://github.com/linrol) and [@tobiasdiez](https://github.com/tobiasdiez)

## Author

[Huan LI](https://github.com/huan) ([李卓桓](http://linkedin.com/in/zixia)) zixia@zixia.net

[![Profile of Huan LI (李卓桓) on StackOverflow](https://stackexchange.com/users/flair/265499.png)](https://stackexchange.com/users/265499)

## Copyright & License

- Code & Docs © 2020-now Huan LI \<zixia@zixia.net\>
- Code released under the Apache-2.0 License
- Docs released under Creative Commons
