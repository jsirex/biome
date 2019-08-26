FROM alpine
MAINTAINER Yauhen Artsiukhou <jsirex@gmail.com>
ARG BIO_VERSION=0.85.0
RUN set -ex \
  && apk add --no-cache ca-certificates wget bash \
  && wget -q -O /usr/local/bin/bio https://github.com/biome-sh/biome/releases/download/bio-$BIO_VERSION/bio\
  && chmod +x /usr/local/bin/bio
