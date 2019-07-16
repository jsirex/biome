#!/bin/bash

set -euo pipefail

source .buildkite/scripts/shared.sh

# TODO: bintray user = chef-releng-ops!
if is_fake_release; then
    bintray_repository=unstable
else
    bintray_repository=stable
fi
echo "--- Preparing to push artifacts to the ${bintray_repository} Bintray repository"

# We need to upload (but not publish) artifacts to Bintray right now.
channel=$(get_release_channel)

# TODO (CM): extract set_bio_binary function to a common library and
# use it here

echo "--- :habicat: Installing biome/bio-bintray-publish from '${channel}' channel"
sudo HAB_LICENSE="${HAB_LICENSE}" \
     bio pkg install \
     --channel="${channel}" \
     biome/bio-bintray-publish

echo "--- :buildkite: Retrieving macOS biome/bio artifact"
bio_artifact=$(get_bio_artifact "x86_64-darwin")
buildkite-agent artifact download "${bio_artifact}" .

echo "--- :habicat: Uploading macOS biome/bio to Bintray"
# We upload to the stable channel, but we don't *publish* until
# later.
#
# -s = skip publishing
# -r = the repository to upload to

# TODO (CM): why do we need the HAB_BLDR_CHANNEL here?
sudo HAB_BLDR_CHANNEL="${channel}" \
     BINTRAY_USER="${BINTRAY_USER}" \
     BINTRAY_KEY="${BINTRAY_KEY}" \
     BINTRAY_PASSPHRASE="${BINTRAY_PASSPHRASE}" \
     HAB_LICENSE="${HAB_LICENSE}" \
     bio pkg exec biome/bio-bintray-publish \
         publish-bio \
         -s \
         -r "${bintray_repository}" \
         "${bio_artifact}"

source results/last_build.env
shasum=$(awk '{print $1}' "results/${pkg_artifact:?}.sha256sum")
cat << EOF | buildkite-agent annotate --style=success --context=bintray-bio-macos
<h3>Biome Bintray Binary (${pkg_target:?})</h3>
Artifact: <code>${pkg_artifact}</code>
<br/>
SHA256: <code>${shasum}</code>
EOF
buildkite-agent meta-data set bio-macos-bintray-sha256 "${shasum}"
