#!/bin/bash

if [ $TRAVIS_OS_NAME = 'osx' ]; then
  # Installing dependencies
  brew install automake bison autoconf automake freetype zlib xquartz
  # Building the sources
  python ./nix/build-all.py
else
    # Build the docker image on Linux
    docker build -t ifcopenshell .
fi