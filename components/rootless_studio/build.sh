#!/bin/sh -e

BIO_VERSION="${1:-0.85.0}"

docker build --no-cache --build-arg BIO_VERSION="$BIO_VERSION" -t biomesh/bio:"$BIO_VERSION" .
docker build --no-cache --build-arg BIO_VERSION="$BIO_VERSION" -t biomesh/default-studio-x86_64-linux:"$BIO_VERSION" ./default
