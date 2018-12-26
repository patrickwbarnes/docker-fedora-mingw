FROM fedora:latest

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN dnf -y install \
  cppcheck \
  dos2unix \
  findutils \
  flawfinder \
  gcovr \
  git \
  libxslt \
  make \
  mingw64-gcc-c++ \
  mingw64-windows-default-manifest \
  wine \
  xorg-x11-server-Xvfb \
 && dnf clean all

RUN printf '\nexport WINEDEBUG=fixme-all\n' >> /root/.bashrc

