FROM ghcr.io/linuxserver/baseimage-rdesktop-web:bionic

ENV WINEARCH=win32
ENV WINEDLLOVERRIDES="mscoree="
ENV CUSTOM_PORT=3002

RUN \
 echo "**** install packages ****" && \
 dpkg --add-architecture i386 && \
 apt-get update && \
 apt-get install -y \
        wget \
        cabextract && \
 wget -nc -O /tmp/winehq.key https://dl.winehq.org/wine-builds/winehq.key && \
 apt-key add /tmp/winehq.key && \
 rm /tmp/winehq.key && \
 apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y && \
 add-apt-repository ppa:cybermax-dexter/sdl2-backport -y && \
 apt-get update && \
 apt-get install -y \
        winehq-devel && \
 wget -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && \
 chmod +x /usr/bin/winetricks

COPY /root /

EXPOSE 3000
VOLUME /config
