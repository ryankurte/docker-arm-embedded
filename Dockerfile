FROM ubuntu:latest
MAINTAINER Ryan Kurte <ryankurte@gmail.com>
LABEL Description="Docker image for building arm-embedded projects"

# General dependencies
RUN apt-get update && apt-get install -y \
  git \
  subversion \
  curl \
  cmake \
  make \
  automake \
  autoconf \
  python-setuptools \
  ninja-build \
  python-dev \
  libtool \
  unzip \
  libffi-dev \
  libssl-dev \
  libusb-1.0.0 \
  libusb-1.0.0-dev \
  software-properties-common \
  python-software-properties \
  gawk \
  genromfs \
  ccache \
  clang \
  build-essential \
  python3 \
  python3-dev \
  python3-pip \
  libprotobuf-dev \
  protobuf-compiler \
  libprotobuf-c-dev \
  protobuf-c-compiler \
  python-protobuf

# ARM gcc toolchain and custom ppa
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa && \
  apt-get update && \
  apt-get install -y gcc-arm-embedded

# Python tools
RUN easy_install pip && \
  pip install mbed-cli && \
  pip install platformio && \
  pip install pyserial

# Rust and arm targets
RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y && \
    /root/.cargo/bin/rustup update nightly && \
    /root/.cargo/bin/rustup target add thumbv7m-none-eabi && \
    /root/.cargo/bin/rustup target add thumbv7em-none-eabi && \
    /root/.cargo/bin/rustup target add thumbv7em-none-eabihf
ENV PATH=/root/.cargo/bin:$PATH

# STLink util
RUN git clone https://github.com/texane/stlink.git && \
  cd stlink && mkdir build && cd build && \
  cmake .. && make && make install

# Cleanup
RUN apt-get clean && \
  rm -rf /var/lib/apt

