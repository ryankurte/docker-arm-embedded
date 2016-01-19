FROM ubuntu
MAINTAINER Ryan Kurte <ryankurte@gmail.com>
LABEL Description="Docker image for building arm-embedded projects"

# General dependencies
RUN apt-get update && apt-get install -y \
  git \
  subversion \
  cmake \
  build-essential \
  make \
  automake

# arm-none-eabi toolchain
RUN apt-add-repository ppa:terry.guo/gcc-arm-embedded && \
  apt-get update && \
  apt-get install -y gcc-arm-none-eabi


