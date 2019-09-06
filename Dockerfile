FROM  ubuntu:18.04 as builder

RUN apt-get -qq update -y && \
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
  libfreetype6-dev \
  libx11-dev \
  mesa-common-dev


COPY . /IfcOpenShell
WORKDIR /IfcOpenShell/nix
RUN python build-all.py
