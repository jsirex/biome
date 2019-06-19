FROM alpine
MAINTAINER Yauhen Artsiukhou <jsirex@gmail.com>
RUN set -ex \
  && apk add --no-cache ca-certificates wget bash \
  && wget -q -O /usr/local/bin/bio https://github.com/biome-sh/biome/releases/download/0.82.0/bio\
  && chmod +x /usr/local/bin/bio
