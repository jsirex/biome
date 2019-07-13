#!/bin/bash

set -euo pipefail

source .buildkite/scripts/shared.sh


########################################################################

# `component` should be the subdirectory name in `components` where a
# particular component code resides.
#
# e.g. `bio` for `biome/bio`, `plan-build` for `biome/bio-plan-build`,
# etc.
component=${1}

channel=$(get_release_channel)

# `set_bio_binary` currently _must_ be called first!
set_bio_binary
import_keys

echo "--- :zap: Cleaning up old studio, if present"
${bio_binary} studio rm

echo "--- :habicat: Building components/${component}"

# The binlink dir is set by releng, but seems to be messing things up
# for us in the studio.
unset HAB_BINLINK_DIR
export HAB_ORIGIN=core

# Eww
#
# CI_OVERRIDE_CHANNEL is basically used to tell the studio which
# bio/backline to grab
if [[ "${new_studio:-}" ]]; then
    CI_OVERRIDE_CHANNEL="${channel}" HAB_BLDR_CHANNEL="${channel}" ${bio_binary} pkg build "components/${component}"
else
    HAB_BLDR_CHANNEL="${channel}" ${bio_binary} pkg build "components/${component}"
fi
source results/last_build.env

# TODO (SM): The 0.59.0 bio cli that we rely on for x86_64-linux builds 
# doesn't emit pkg_target. Until we've sufficiently bootstrapped ourselves
# we need to set it. This can be removed when studio-ci-common pulls 0.63.0 
# or newer. This is safe to do because the x86_64-linux-kernel2 builds will
# already have this value set.
: "${pkg_target:=x86_64-linux}"

echo "--- :habicat: Uploading ${pkg_ident:-} to Builder in the '${channel}' channel"
${bio_binary} pkg upload \
    --channel="${channel}" \
    --auth="${HAB_AUTH_TOKEN}" \
    "results/${pkg_artifact:-}"

set_target_metadata "${pkg_ident}" "${pkg_target}"

echo "--- :writing_hand: Recording Build Metadata"
case "${component}" in
    "bio")
        echo "--- :buildkite: Storing artifact ${pkg_ident:?}"
        # buildkite-agent artifact upload "results/${pkg_artifact}"
        set_bio_ident "${pkg_target:?}" "${pkg_ident:?}"
        set_bio_release "${pkg_target:?}" "${pkg_release:?}"
        set_bio_artifact "${pkg_target:?}" "${pkg_artifact:?}"
        ;;
    "studio")
        echo "--- :buildkite: Recording metadata for ${pkg_ident}"
        # buildkite-agent artifact upload "results/${pkg_artifact}"
        set_studio_ident "${pkg_target:?}" "${pkg_ident:?}"
        ;;
    "backline")
        echo "--- :buildkite: Recording metadata for ${pkg_ident}"
        set_backline_ident "${pkg_target}" "${pkg_ident}"
        set_backline_artifact "${pkg_target}" "${pkg_artifact}"
        ;;
    *)
        echo "--- :buildkite: Not recording metadata for ${component}" 
        ;;
esac
echo "<br>* ${pkg_ident:?} (${pkg_target:?})" | buildkite-agent annotate --append --context "release-manifest"
