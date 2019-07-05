#!/usr/bin/env bash

set -euo pipefail

export HAB_LICENSE="accept-no-persist"

sudo bio pkg install core/busybox-static biome/bio biome/bio-backline

# Current studio has the expectation that busybox and bio live in the libexec directroy
# These two lines should be removed at a later date to validate this is no longer a requirement
# While not explicily mentioned, resolving biome-sh/biome#6509 will likely remove this 
# explicit requirement.
cp "$(bio pkg path core/busybox-static)"/bin/busybox libexec/busybox
cp "$(bio pkg path biome/bio)"/bin/bio libexec/bio

HAB_STUDIO_BACKLINE_PKG="$(< "$(bio pkg path biome/bio-backline)"/IDENT)"
studio_command="sudo --preserve-env $(realpath bin/bio-studio.sh)"

export HAB_STUDIO_BACKLINE_PKG

./test/shared/test-all.sh "${studio_command}"


rm libexec/bio
rm libexec/busybox
