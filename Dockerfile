FROM ubuntu:18.04 as ifopsh_build

# Build IfcOpenShell and dependencies from source, note this takes a while
WORKDIR /
RUN apt-get -y update && apt-get -y install \
  autoconf \
  bison \
  build-essential \
  git \
  make \
  wget \
  python \
  bzip2 \
  libfreetype6-dev \
  mesa-common-dev \
  libgl1-mesa-dev \
  python-pip \
  libftgl-dev \
  cmake \
  unzip \
  libffi-dev

RUN git clone https://github.com/IfcOpenShell/IfcOpenShell.git && cd IfcOpenShell && git checkout v0.6.0
WORKDIR /IfcOpenShell/nix
RUN CXXFLAGS="-O3" BUILD_CFG=Release python build-all.py IfcConvert IfcOpenShell-Python

FROM ubuntu:18.04

RUN apt-get -y update && apt-get -y install python3.6

# Copy IfcConvert and python module for 3.6
COPY --from=ifopsh_build /IfcOpenShell/build/Linux/x86_64/install/ifcopenshell/bin/IfcConvert /usr/bin/IfcConvert
COPY --from=ifopsh_build /IfcOpenShell/build/Linux/x86_64/install/python-3.6.2/lib/python3.6/site-packages/ifcopenshell /ifcopenshell

# Create site package dir
RUN mkdir -p `python3.6 -c 'import site; print(site.getsitepackages()[0])'`
# ... and move module into it
RUN mv /ifcopenshell `python3.6 -c 'import site; print(site.getsitepackages()[0])'`

# Trivial tests
RUN IfcConvert --version