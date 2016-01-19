FROM debian
MAINTAINER Ryan Kurte <ryankurte@gmail.com>
LABEL Description="Docker image for building arm-embedded projects"

# General dependencies
RUN apt-get update && apt-get install -y \
  git \
  subversion \
  cmake \
  build-essential \
  make \
  autotools \
  automake

# i386 libc for (some versions of) the toolchain
RUN dpkg --add-architecture i386 && \
  apt-get update && \
  apt-get install -y libc6-i386

# arm-none-eabi toolchain
RUN add-apt-repository ppa:terry.guo/gcc-arm-embedded && \
  apt-get update && \
  apt-get install -y gcc-arm-none-eabi


