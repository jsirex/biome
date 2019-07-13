#!/bin/bash

# This script automates the modification of our Homebrew tap for the
# `bio` binary.
#
# For now, it lives here in the Biome repository, but in time, it
# should move over to https://github.com/biome-sh/homebrew-biome,
# once our pipelines are set up such that Expeditor is triggering them
# and responding to events.

set -euo pipefail

if ! sed --version 2>&1 | grep -q "GNU sed"; then
    echo "This script requires GNU sed; aborting"
    exit 1
fi

configure-github-account chef-ci

source .buildkite/scripts/shared.sh

ensure_files_changed() {
    # git diff --exit-code returns 0 if there are no changes
    if git diff --exit-code; then
       echo "Expected sed command to make a change, but it didn't!"
       exit 1
    fi
}

new_version=$(get_version)
new_release=$(get_bio_release x86_64-darwin)
new_sha256=$(buildkite-agent meta-data get bio-macos-bintray-sha256)

echo "--- :github: Cloning biome-sh/homebrew-biome"
rm -rf homebrew-biome
git clone git@github.com:biome-sh/homebrew-biome
cd homebrew-biome
git checkout -b bump

echo "--- Modifying bio Homebrew Formula"
sed --in-place \
    --regexp-extended \
    's/current_version="(.*)"/current_version="'"${new_version}"'"/g' \
    Formula/bio.rb
ensure_files_changed
git add Formula/bio.rb

sed --in-place \
    --regexp-extended \
    's/current_release="(.*)"/current_release="'"${new_release}"'"/g' \
    Formula/bio.rb
ensure_files_changed
git add Formula/bio.rb

sed --in-place \
    --regexp-extended \
    's/current_sha256="(.*)"/current_sha256="'"${new_sha256}"'"/g' \
    Formula/bio.rb
ensure_files_changed
git add Formula/bio.rb

echo "--- :github: Committing updates to Github"
# Display what changed
git diff --staged
git commit --signoff --message "Bump version to ${new_version}"
if is_fake_release; then
    echo "FAKE RELEASE: Not pushing commit to Github"
else
    # Push directly to master; alternatively, we could create a pull
    # request using the Github API and have a human merge it.
    git push origin bump:master
fi
