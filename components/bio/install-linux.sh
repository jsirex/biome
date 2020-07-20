#!/bin/bash
#
set -eou pipefail

# If the variable `$DEBUG` is set, then print the shell commands as we execute.
if [ -n "${DEBUG:-}" ]; then set -x; fi

BIO_BINARY_URL=https://github.com/biome-sh/biome/releases/download/bio-1.6.42/bio-1.6.42-x86_64-linux
BIO_BINARY_PATH=/tmp/$(basename "$BIO_BINARY_URL")

if [ -x $BIO_BINARY_PATH ]; then
    echo "Using cached binary"
else
    curl -sSL "$BIO_BINARY_URL" > "$BIO_BINARY_PATH"
fi

chmod +x "$BIO_BINARY_PATH"

"$BIO_BINARY_PATH" pkg install -fb biome/bio
