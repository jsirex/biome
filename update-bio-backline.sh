#!/bin/bash

set -eoux pipefail

CHANNEL=$1
VERSION=$2

shift 2
sudo bio pkg install -c "$CHANNEL" biome/bio-backline/"$VERSION"
bio pkg upload -u https://bldr.acceptance.biome.sh -c stable "$@" \
    /hab/cache/artifacts/biome-bio-backline-"$VERSION"-*-x86_64-linux.hart
