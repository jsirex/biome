#!/bin/bash

# A simple test assertion that running `bio sup --help` will not
# attempt to install `biome/bio-sup` if that pkg is not present.

set -ou pipefail

export TESTING_FS_ROOT
TESTING_FS_ROOT=$(mktemp -d)
export HAB_SUP_BINARY
HAB_SUP_BINARY=''

print_help() {
  program=$(basename "$0")
  echo "$program

Test \`bio sup --help\` will not install biome/bio-sup.

USAGE:
  $program <path-to-bio-binary>

ARGS:
  <path-to-bio-binary>  The name or path of the bio binary under test (eg: './target/debug/bio' or
simply 'bio'). In the latter case when just passing the binary name, the shell will search in \$PATH.
"
}

if [[ $# -eq 0 ]] ; then
  print_help
  echo
  echo "--- <path-to-bio-binary> must be specified!"
  exit 1
else
  HAB_BINARY="$1"
fi

echo "--- Running \`$HAB_BINARY sup --help\` - which should NOT attempt an install of biome/bio-sup"

bio_bin_run="$($HAB_BINARY sup --help)"
echo "--- Expecting help message, not install message:"
echo "--- $bio_bin_run"

if [ -z "$bio_bin_run" ]; then
  echo
  echo "--- ERROR: $HAB_BINARY was not the proper executable bio binary!"
  exit 1
elif [ -d "$TESTING_FS_ROOT/hab/pkgs/biome/bio-sup" ]; then
  echo
  echo "--- ERROR: detected an installation of biome/bio-sup"
  exit 1
fi

echo "--- Success!"
