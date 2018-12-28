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
  mingw64-windows-default-manifest \
  unzip \
  wine \
  xorg-x11-server-Xvfb \
  xz \
  zip \
 && dnf clean all

RUN curl --silent --fail --location -o /tmp/wix.zip \
      https://github.com/wixtoolset/wix3/releases/download/wix3111rtm/wix311-binaries.zip \
 && unzip -d /opt/wix /tmp/wix.zip \
 && chmod +x /opt/wix/*.exe

RUN printf '\n\
export WINEDEBUG=fixme-all\n\
export PATH=$PATH:/opt/wix\n\
' >> /root/.bashrc

RUN printf '@EXIT' > /tmp/wine-noop.cmd \
 && WINEDEBUG=-all wine cmd.exe /c /tmp/wine-noop.cmd \
 && wineserver -k \
 && rm /tmp/wine-noop.cmd

