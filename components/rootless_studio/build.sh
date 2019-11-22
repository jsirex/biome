#!/bin/sh -e

BIO_VERSION=$(cat ../../VERSION)
BIO_TARGET=x86_64-linux

docker build \
       -t biomesh/bio-"$BIO_TARGET":"$BIO_VERSION" \
       --no-cache \
       --build-arg BIO_VERSION="$BIO_VERSION" \
       --build-arg BIO_TARGET="$BIO_TARGET" \
       .

docker build \
       -t biomesh/default-studio-"$BIO_TARGET":"$BIO_VERSION" \
       --no-cache \
       --build-arg BIO_VERSION="$BIO_VERSION" \
       --build-arg BIO_TARGET="$BIO_TARGET" \
       ./default
