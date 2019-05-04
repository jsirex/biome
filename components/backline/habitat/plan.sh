pkg_name=bio-backline
pkg_origin=biome
pkg_version=$(cat "$SRC_PATH/../../VERSION")
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

do_build() {
  return 0
}

do_install() {
  return 0
}
