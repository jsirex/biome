FROM alpine
MAINTAINER Yauhen Artsiukhou <jsirex@gmail.com>
ARG BIO_VERSION=0.90.26
ARG BIO_TARGET=x86_64-linux
RUN set -ex \
  && apk add --no-cache ca-certificates wget bash \
  && wget -q -O /usr/local/bin/bio https://github.com/biome-sh/biome/releases/download/bio-$BIO_VERSION/bio-$BIO_VERSION-$BIO_TARGET\
  && chmod +x /usr/local/bin/bio
