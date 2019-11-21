#!/bin/bash

# This tests that the version of bio that we are releaseing is the same 
# version embedded in the studio package. Since the studio is built 
# with the previous version of `bio` this is useful to verify that the
# correct version was copied.
 
echo "--- Generating signing key for $HAB_ORIGIN"
bio origin key generate "$HAB_ORIGIN" 

echo "--- Checking bio version in the studio"
expected_version=$(bio --version)

# This needs to be escaped like this so that all of the evaluation
# happens on the inside of the studio and it remainds correctly quoted
bio studio run test \"\$\(bio --version\)\" == \""$expected_version"\"

