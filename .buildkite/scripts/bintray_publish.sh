#!/bin/bash

set -euo pipefail

source .buildkite/scripts/shared.sh

if is_fake_release; then
    bintray_repository=unstable
else
    bintray_repository=stable
fi

echo "--- Preparing to publish artifacts to the ${bintray_repository} Bintray repository"

publish() {
    local target version release repository url

    target=${1}
    version=${2}
    release=${3}
    repository=${4}
    url="https://api.bintray.com/content/biome/${repository}/${target}/${version}-${release}/publish"
    if is_fake_release; then
        echo "--- :warning: If this were a real release, we would have hit ${url}"
    else
        curl -u "${BINTRAY_USER}:${BINTRAY_KEY}" -X POST "${url}"
    fi
}

echo "--- :habicat: Publishing all Biome CLI artifacts in Bintray"

version=$(get_version)

########################################################################
# Linux x86-64-linux Publish
release=$(get_bio_release x86_64-linux)
echo "--- :linux: Publishing x86-64-linux 'bio' ${version}-${release} on Bintray"
publish "bio-x86_64-linux" "${version}" "${release}" "${bintray_repository}"

########################################################################
# Linux x86-64-linux-kernel2 Publish
release=$(get_bio_release x86_64-linux-kernel2)
echo "--- :linux: :two: Publishing x86-64-linux-kernel2 'bio' ${version}-${release} on Bintray"
publish "bio-x86_64-linux-kernel2" "${version}" "${release}" "${bintray_repository}"

########################################################################
# macOS Publish
release=$(get_bio_release x86_64-darwin)
echo "--- :mac: Publishing x86-64-darwin 'bio' ${version}-${release} to Bintray"
publish "bio-x86_64-darwin" "${version}" "${release}" "${bintray_repository}"

########################################################################
# Windows Publish
release=$(get_bio_release x86_64-windows)
echo "--- :windows: Publishing x86-64-windows 'bio' ${version}-${release} to Bintray"
publish "bio-x86_64-windows" "${version}" "${release}" "${bintray_repository}"
