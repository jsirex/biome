#!/usr/bin/env bash

set -euo pipefail 

export HAB_LICENSE="accept-no-persist"

bio studio rm

export STUDIO_ENTER_COMMAND="bio studio enter"

./test/shared/test-all.sh

