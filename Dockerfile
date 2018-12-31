FROM fedora:latest

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN dnf -y install \
  cppcheck \
  dos2unix \
  doxygen \
  findutils \
  flawfinder \
  gcovr \
  git \
  libxslt \
  make \
  mingw64-gcc-c++ \
  mingw64-winpthreads-static \
  pandoc \
  unzip \
  upx \
  wine-core \
  winetricks \
  xorg-x11-server-Xvfb \
  xz \
  zip \
 && dnf clean all

ENV WINEDEBUG=fixme-all

RUN printf '@EXIT' > /tmp/wine-noop.cmd \
 && WINEDEBUG=-all wine cmd.exe /c /tmp/wine-noop.cmd \
 && wineserver -k \
 && rm /tmp/wine-noop.cmd

