#!/bin/bash

# This is a shim for testing behavior that requires `bio studio enter`.
# It takes a single argument which is the test to run on the inside of 
# the studio, and passes that to the expect studio-driver script.


set -euo pipefail 

studio_test="${1}"

bio pkg install core/expect
bio pkg binlink core/expect expect --force

echo "--- Generating signing key for $HAB_ORIGIN"
bio origin key generate "$HAB_ORIGIN" 

echo "--- Using bio-studio $(bio studio version)"

echo "--- $studio_test"
expect test/end-to-end/studio-driver.exp "$studio_test"
