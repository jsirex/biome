# Building a `bio` macOS Binary

As Biome currently does not have first class support for the Mac platform, a pragmatic approach has been taken to build a `bio` binary for macOS. This details the steps to build a release on macOS. It is also currently codified in [.buildkite/scripts/build_mac_release.sh](biome-sh/biome/.buildkite/scripts/build_mac_release.sh)

## Prerequisites

### Install XCode Command Line Developer Tools
This installs basic developer tooling needed to compile and build software on a Mac.

```sh
xcode-select --install
```

### Install Omnibus Bootstrap Toolchain package

Since there is not yet a complete Biome build toolchain available for macOS, we provide the minimal set of binaries and static libraries needed to compile a `bio` binary using Chef's Omnibus tooling platform. This effectively takes the place of the packages we would add to a `pkg_build_deps` entry in a Biome plan file.

TODO: Where can this package be retrieved from?

```sh
sudo installer \
     -pkg <PATH_TO_BOOTSTRAP_TOOLCHAIN_PACKAGE> \
     -target /
```

TODO: Can we rename `bio-bundle`?

This will install the toolchain in `/opt/bio-bundle`; this is where the build program is expecting to find binaries and libraries it needs.

### Install Homebrew
Follow the instructions at https://brew.sh.

### Install Rust toolchain
Follow the instructions at https://rustup.rs/

### Install Homebrew prerequisites
Though most of the toolchain needed to build a `bio` binary exist in the Omnibus bootstrap toolchain, a few are not yet available there. Until they are migrated in, we need to use Homebrew to get them.

``` sh
brew bundle install --verbose --file=<HABITAT_REPO>/.buildkite/Brewfile
```

This step is temporary, until we have a fully-contained toolchain in an Omnibus package

### Install `bio`
This is currently handled with the `brew bundle` command above, but for completeness:

``` sh
brew tap biome-sh/biome
brew install bio
```

### Install Builder Origin Keys

To build a Biome package, you must have the secret `core` origin key for signing that package. Obtaining the secret key requires a personal authentication token from Builder.

``` sh
sudo bio origin key download core
sudo bio origin key download --secret --auth="${HAB_AUTH_TOKEN}" core
```
Here, we use `sudo` to install keys in system-wide `/hab/cache/keys/` directory in which the build program expects to find them.

## Building

Ensure that the necessary tools are on your path, and then build.

``` sh
PATH="/opt/bio-bundle/embedded/bin:${PATH}"
PATH="~/.cargo/bin:${PATH}"
export PATH
sudo -E $(brew --prefix bash)/bin/bash components/plan-build/bin/bio-plan-build.sh components/bio/mac
```

Assuming success, this will produce a local `./results` directory with the artifact.
