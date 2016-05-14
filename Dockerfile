FROM ubuntu:trusty
MAINTAINER Ryan Kurte <ryankurte@gmail.com>
LABEL Description="Docker image for building arm-embedded projects"

# General dependencies
RUN apt-get update && apt-get install -y \
  git \
  subversion \
  cmake \
  make \
  automake \
  python-setuptools \
  ninja-build \
  python-dev \
  libffi-dev \
  libssl-dev \
  software-properties-common \
  python-software-properties \
  gawk

# arm-none-eabi toolchain
RUN add-apt-repository ppa:terry.guo/gcc-arm-embedded && \
  apt-get update && \
  apt-get install -y gcc-arm-none-eabi

# Yotta
RUN easy_install pip && \
  pip install yotta && \
  mkdir -p /usr/local/lib/yotta_modules \
  chown $USER /usr/local/lib/yotta_modules \
  chmod 755 /usr/local/lib/yotta_modules

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt

