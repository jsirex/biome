FROM alpine
MAINTAINER Yauhen Artsiukhou <jsirex@gmail.com>
ARG BIO_VERSION=
ARG PACKAGE_TARGET
RUN set -ex \
  && apk add --no-cache ca-certificates wget bash \
  && wget -q -O /usr/local/bin/bio https://github.com/biome-sh/biome/releases/download/bio-$BIO_VERSION/bio-$BIO_VERSION-$PACKAGE_TARGET\
  && chmod +x /usr/local/bin/bio
