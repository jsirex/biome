#!/bin/bash
# This test is designed to catch the regression described in 
# https://github.com/habitat-sh/habitat/issues/6771
# 
# When a user runs `bio studio enter` for the first time after installing a
# new Biome release, the `biome/bio-studio` package won't be present on the 
# system and the cli will automatically download and install the appropirate 
# package. Since we always install the studio as part of our build process to 
# ensure we're using the correct version, this behavior needs to be exercised 
# as its own test. 

set -euo pipefail

# Ensure there are no studios installed
while [ -d /hab/pkgs/biome/bio-studio ]; do 
  bio pkg uninstall biome/bio-studio
done

# 'studio enter' requires a signing key to be present for the current origin
echo "--- Generating signing key for $HAB_ORIGIN"
bio origin key generate "$HAB_ORIGIN" 

echo "--- Creating new studio"
bio studio new

echo "--- $(bio studio version)"
