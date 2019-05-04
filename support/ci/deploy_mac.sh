#!/bin/bash
# 4 env vars are required for this script
# HAB_ORIGIN_KEY
# BINTRAY_USER
# BINTRAY_PASSPHRASE
# BINTRAY_KEY
# TRAVIS_BUILD_NUMBER

set -eu

var_file="$HOME/tmp/our-awesome-vars"
if [[ -f ${var_file} ]]; then
  echo "--> Located the file with the magic environment variables."
  source "${var_file}"
  rm "${var_file}"
else
  echo "${var_file} does not appear to exist or at least not pass the -f test."
  echo "This script will likely abort shortly."
fi

bio_src_dir="$HOME/code/$TRAVIS_BUILD_NUMBER/biome"
function cleanup {
  echo "--> Removing origin secret keys from cache"
  rm -f /hab/cache/keys/*-*.sig.key
  echo "--> Purging directory '$bio_src_dir'"
  rm -rf "$bio_src_dir"
}
trap cleanup EXIT

bootstrap_dir="$HOME/mac_unstable/$TRAVIS_BUILD_NUMBER"
mac_dir="${bio_src_dir}/components/bio/mac/travis"
mac_bio="${bootstrap_dir}/bio"
gnu_tar=/usr/local/bin/tar
bio_download_url="https://api.bintray.com/content/biome/stable/darwin/x86_64/bio-%24latest-x86_64-darwin.zip?bt_package=bio-x86_64-darwin"
our_path="${HOME}/.cargo/bin:/usr/local/bin:${PATH}"
export HAB_ORIGIN=core
export PATH="${our_path}"

# start fresh
rm -fr "${bootstrap_dir}"
mkdir -p "${bootstrap_dir}"
cd "${bootstrap_dir}"

# this removes the link that was setup below, just in case it exists.
# if we don't do this, then lots of tar related things fail
if [[ -h $gnu_tar ]]; then
  rm /usr/local/bin/tar
fi

# download a bio binary to get us started
wget -O bio.tar.gz "${bio_download_url}"

# install it in a custom location
tar xvzf ./bio.tar.gz --strip 1 -C "${bootstrap_dir}"

# create our origin key
cat << EOF > core.sig.key
SIG-SEC-1
core-20160810182414

${HAB_ORIGIN_KEY}
EOF

echo "--> Clearing any pre-exisiting origin secret keys from cache"
rm -f /hab/cache/keys/*-*.sig.key
echo "--> Importing origin secret key into cache"
${mac_bio} origin key import < ./core.sig.key
rm -f ./core.sig.key

# since this is running on a headless mac, we can't use docker/studio,
# so we need to resort to this hackery
echo "Customizing bintray-publish"
cp -v "$bio_src_dir"/components/bintray-publish/bin/publish-bio.sh "$bootstrap_dir"
program=$bootstrap_dir/publish-bio.sh
pkg_maintainer="The Biome Maintainers <humans@biome.sh>"
our_version=$($mac_bio --version | cut -d ' ' -f 2)

sed \
  -e "s,#!/bin/bash$,#!$(brew --prefix bash)/bin/bash," \
  -e "s,@author@,$pkg_maintainer,g" \
  -e "s,@path@,$our_path,g" \
  -e "s,@version@,$our_version,g" \
  -e "s,tr --delete,tr -d,g" \
  -e "s,sha256sum ,shasum -a 256 ,g" \
  -i "" "$program"

echo "Building bio"
cd "$mac_dir"
./mac-build.sh
echo "Built new version of bio"

# link the brew installed gnu-tar to "tar" otherwise it won't get used
# when publish-bio.sh runs and publish-bio.sh will abort
ln -sf /usr/local/bin/gtar /usr/local/bin/tar
hash -r

cd "${bootstrap_dir}"

echo "Publishing bio to unstable"
# shellcheck disable=2061
release=$(find "$mac_dir"/results -name "biome-bio-0*.hart" | sort -n | tail -n 1)
$program -r unstable "$release"
rm "$release"
rm -rf "$bootstrap_dir"
