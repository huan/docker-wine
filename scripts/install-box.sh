#!/bin/bash
set -euxo pipefail
# NOTE: Can only run on aarch64 (since box64 can only run on aarch64)
# box64 runs wine-amd64, box86 runs wine-i386.

if [ -z "$TARGETPLATFORM" ]; then
  echo "TARGETPLATFORM is not set. Run docker build with --build-arg TARGETPLATFORM=linux/arm64"
  exit 1
elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then
   # Enable multi-arch
   dpkg --add-architecture armhf && apt-get update

   # Add repo box86 to source list and install box86
   wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
   wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg
   apt update
   apt install box86-generic-arm:armhf -y

   # Add repo box64 to source list and install box64
   wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
   wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg
   apt update && apt install box64 -y
fi
