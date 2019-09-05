FROM  ubuntu:18.04 as builder

RUN apt-get -qq update -y && \
  apt-get -qq install -y \
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


COPY . /IfcOpenShell
WORKDIR /IfcOpenShell
RUN python build-all.py
