#!/bin/bash

# We need to upload (but not publish) artifacts to Bintray right now.

set -euo pipefail

source .buildkite/scripts/shared.sh
export HAB_LICENSE="accept-no-persist"

set_bio_binary

# TODO: bintray user = chef-releng-ops!

if is_fake_release; then
    bintray_repository=unstable
else
    bintray_repository=stable
fi
echo "--- Preparing to push artifacts to the ${bintray_repository} Bintray repository"

channel=$(get_release_channel)

# TODO (CM): extract set_bio_binary function to a common library and
# use it here

echo "--- :habicat: Installing biome/bio-bintray-publish from '${channel}' channel"
sudo HAB_LICENSE="accept-no-persist" "${bio_binary:?}" pkg install \
     --channel="${channel}" \
     biome/bio-bintray-publish

# TODO (CM): determine artifact name for given bio identifier
#            could save this as metadata, or just save the artifact in
#            BK directly

echo "--- :habicat: Uploading biome/bio to Bintray"

bio_artifact=$(get_bio_artifact "${BUILD_PKG_TARGET}")

# For this section we will manually pull down the windows hart from bldr
# rather than rewrite the bintray publish plugin for windows. The existing
# implementation doesn't support the upload, so we'll stage the windows
# file in the artifact cache on linux and utilize the existing code.
if [ "$BUILD_PKG_TARGET" = "x86_64-windows" ]; then
    version=$(get_version)
    windows_ident=$(latest_from_builder x86_64-windows "${channel}" bio "${version}")
    echo "--- Downloading Windows version directly from bldr: $windows_ident"
    sudo curl "https://bldr.habitat.sh/v1/depot/pkgs/$windows_ident/download?target=$BUILD_PKG_TARGET" -o "/hab/cache/artifacts/$bio_artifact"
else
    sudo HAB_LICENSE="accept-no-persist" "${bio_binary:?}" pkg install biome/bio --channel="${channel}"
fi

# We upload to the stable channel, but we don't *publish* until
# later.
#
# -s = skip publishing
# -r = the repository to upload to
sudo HAB_LICENSE="accept-no-persist" \
     HAB_BLDR_CHANNEL="${channel}" \
     BINTRAY_USER="${BINTRAY_USER}" \
     BINTRAY_KEY="${BINTRAY_KEY}" \
     BINTRAY_PASSPHRASE="${BINTRAY_PASSPHRASE}" \
     "${bio_binary:?}" pkg exec biome/bio-bintray-publish \
         publish-bio \
         -s \
         -r "${bintray_repository}" \
         "/hab/cache/artifacts/${bio_artifact}"

source results/last_build.env
shasum=$(awk '{print $1}' "results/${pkg_artifact:?}.sha256sum")
cat << EOF | buildkite-agent annotate --style=success --context=bintray-bio
<h3>Biome Bintray Binary (${pkg_target:?})</h3>
Artifact: <code>${pkg_artifact}</code>
<br/>
SHA256: <code>${shasum}</code>
EOF
