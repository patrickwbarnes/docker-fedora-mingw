FROM fedora:latest

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# We install the Microsoft repository for PowerShell.
# compat-openssl10 is required by PowerShell (as of 2019-04).
# https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6#fedora

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc \
 && curl --location --fail -o /etc/yum.repos.d/microsoft.repo https://packages.microsoft.com/config/rhel/7/prod.repo \
 && dnf -y install \
  compat-openssl10 \
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
  powershell \
  unzip \
  upx \
  wine-core \
  winetricks \
  xorg-x11-server-Xvfb \
  xz \
  zip \
 && dnf clean all

ENV WINEDEBUG=fixme-all POWERSHELL_TELEMETRY_OPTOUT=1

# Initialize Wine environment during image build
RUN printf '@EXIT' > /tmp/wine-noop.cmd \
 && WINEDEBUG=-all wine cmd.exe /c /tmp/wine-noop.cmd \
 && wineserver -k \
 && rm /tmp/wine-noop.cmd

