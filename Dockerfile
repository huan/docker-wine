FROM ubuntu:eoan

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

ENV \
  LANG='C.UTF-8' \
  LC_ALL='C.UTF-8' \
  TZ=Asia/Shanghai \
  WINEDEBUG=-all

RUN apt-get update \
  && apt-get install -y \
    # https://github.com/wszqkzqk/deepin-wine-ubuntu/issues/188#issuecomment-554599956
    # https://zj-linux-guide.readthedocs.io/zh_CN/latest/tool-install-configure/%5BUbuntu%5D%E4%B8%AD%E6%96%87%E4%B9%B1%E7%A0%81/
    ttf-wqy-microhei \
    ttf-wqy-zenhei \
    xfonts-wqy \
    \
    apt-transport-https \
    ca-certificates \
    cabextract \
    curl \
    gnupg2 \
    gosu \
    language-pack-zh-hans \
    software-properties-common \
    tzdata \
    unzip \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -fr /tmp/*

RUN dpkg --add-architecture i386 \
  && curl -sL https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
  && apt-add-repository 'deb http://dl.winehq.org/wine-builds/ubuntu/ eoan main' \
  && echo 'i386 Architecture & Wine Repo Added' \
  && apt-get install -y \
    winehq-stable \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -fr /tmp/*

RUN groupadd group \
  && useradd -m -g group user \
  && usermod -a -G audio user \
  && usermod -a -G video user \
  && chsh -s /bin/bash user \
  && echo 'User Created'

ARG GECKO_VER=2.47.1
ARG MONO_VER=4.9.4

RUN mkdir -p /usr/share/wine/{gecko,mono} \
  && curl -sL -o /usr/share/wine/gecko/wine-gecko-${GECKO_VER}-x86.msi \
    "https://dl.winehq.org/wine/wine-gecko/${GECKO_VER}/wine-gecko-${GECKO_VER}-x86.msi" \
  && curl -sL -o /usr/share/wine/mono/wine-mono-${MONO_VER}.msi \
    "https://dl.winehq.org/wine/wine-mono/${MONO_VER}/wine-mono-${MONO_VER}.msi" \
  && chown -R user:group /usr/share/wine/{gecko,mono} \
  && echo 'Gecko & Mono Downloaded' \
  \
  && curl -sL -o /usr/local/bin/winetricks \
    https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
  && chmod +x /usr/local/bin/winetricks \
  && echo 'Winetricks Installed' \
  \
  && su user -c 'WINEARCH=win32 wine wineboot' \
  \
  # wintricks
  && su user -c 'winetricks -q win7' \
  && su user -c 'winetricks -q riched20' \
  \
  # Clean
  && rm -fr /usr/share/wine/{gecko,mono} \
  && rm -fr /home/user/{.cache,tmp}/* \
  && rm -fr /tmp/* \
  && echo 'Wine Initialized'

COPY [A-Z]* /

LABEL \
    org.opencontainers.image.authors="Huan (李卓桓) <zixia@zixia.net>" \
    org.opencontainers.image.description="Docker Base Image for Wine" \
    org.opencontainers.image.documentation="https://github.com/huan/docker-wine/#readme" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.source="git@github.com:huan/docker-wine.git" \
    org.opencontainers.image.title="Docker Base Image for Wine" \
    org.opencontainers.image.url="https://github.com/huan/docker-wine" \
    org.opencontainers.image.vendor="Huan LI (李卓桓)"
