#!/usr/bin/env bash

set -euo pipefail 

export HAB_LICENSE="accept-no-persist"

bio studio rm

studio_command="bio studio"

./test/shared/test-all.sh "${studio_command}"

