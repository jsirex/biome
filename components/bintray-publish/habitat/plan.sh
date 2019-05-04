# shellcheck disable=2154
pkg_name=bio-bintray-publish
pkg_origin=biome
pkg_version=$(cat "$PLAN_CONTEXT/../../../VERSION")
pkg_maintainer="The Biome Maintainers <humans@biome.sh>"
pkg_license=('apachev2')
pkg_deps=(core/coreutils
          core/util-linux
          core/bash
          core/zip
          core/tar
          core/xz
          core/gzip
          core/jfrog-cli
          core/grep
          core/findutils
          core/gawk
          biome/bio)
pkg_bin_dirs=(bin)

do_build() {
    cp -v "${SRC_PATH}/bin/publish-bio.sh" "${CACHE_PATH}/publish-bio"

    # Use the bash from our dependency list as the shebang. Also, embed the
    # release version of publish-bio.
    sed \
      -e "s,#!/bin/bash$,#!$(pkg_path_for bash)/bin/bash," \
      -e "s,@author@,$pkg_maintainer,g" \
      -e "s,@version@,$pkg_version/$pkg_release,g" \
      -i "${CACHE_PATH}/publish-bio"
}

do_install() {
    install -v -D "${CACHE_PATH}/publish-bio" "${pkg_prefix}/bin/publish-bio"
}
