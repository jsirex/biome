#!/usr/bin/env bash

# Builds a "cleanroom" Docker container to run BATS tests in, and then
# executes the tests in that container, mounting the tests and Biome
# binaries as needed.

if [ $# -eq 0 ] ; then
    TESTS="."
else
    TESTS="$*"
fi

docker build -t bio-bats-cleanroom "$(pwd)"/test/integration

docker run -it --rm \
       --mount type=bind,source="$(pwd)/test/integration",target=/test \
       --mount type=bind,source="$(pwd)/target/debug/bio-launch",target=/bin/bio-launch \
       --mount type=bind,source="$(pwd)/target/debug/bio-sup",target=/bin/bio-sup \
       --mount type=bind,source="$(pwd)/target/debug/bio",target=/bin/bio \
       --env HAB_BIN_DIR=/bin \
       --workdir=/test \
       --name bio-bats \
       bio-bats-cleanroom \
       bats "${TESTS}"