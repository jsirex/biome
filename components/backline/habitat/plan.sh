pkg_name=bio-backline
pkg_origin=biome
pkg_maintainer="The Biome Maintainers <humans@biome.sh>"
pkg_license=('Apache-2.0')
pkg_build_deps=()

pkg_deps=(biome/bio-plan-build
          core/diffutils
          core/less
          core/make
          core/mg
          core/util-linux
          core/vim
          core/ncurses)

pkg_version() {
  if [[ -n "${DO_FAKE_RELEASE:-}" ]]; then
    cat "$SRC_PATH/../../VERSION_FAKE"
  else
    cat "$SRC_PATH/../../VERSION"
  fi
}
 
do_before() {
  do_default_before
  update_pkg_version
}

do_build() {
  return 0
}

do_install() {
  return 0
}
