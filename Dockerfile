FROM  ubuntu:18.04 as builder

RUN apt-get update -y && \
  apt-get install -y \
  autoconf \
  bison \
  flex \
  git \
  wget \
  unzip \
  cmake \
  gcc \
  g++ \
  libboost-all-dev \
  libicu-dev \
  libpcre3-dev \
  libxml2-dev \
  python-all-dev \
  swig \
  libffi-dev \
  libfreetype6-dev

RUN git clone -b v0.6.0 https://github.com/IfcOpenShell/IfcOpenShell.git
WORKDIR /IfcOpenShell/nix
RUN python build-all.py
