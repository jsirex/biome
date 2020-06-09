#!/bin/sh -e

BIO_VERSION=$(cat ../../VERSION)
PACKAGE_TARGET=x86_64-linux

docker build \
       -t biomesh/bio-"$PACKAGE_TARGET":"$BIO_VERSION" \
       --no-cache \
       --build-arg BIO_VERSION="$BIO_VERSION" \
       --build-arg PACKAGE_TARGET="$PACKAGE_TARGET" \
       .

docker build \
       -t biomesh/default-studio-"$PACKAGE_TARGET":"$BIO_VERSION" \
       --no-cache \
       --build-arg BIO_VERSION="$BIO_VERSION" \
       --build-arg PACKAGE_TARGET="$PACKAGE_TARGET" \
       ./default

docker push biomesh/bio-"$PACKAGE_TARGET":"$BIO_VERSION"
docker push biomesh/default-studio-"$PACKAGE_TARGET":"$BIO_VERSION"
