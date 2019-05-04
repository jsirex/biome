This is the *old* Docker export code, which is no longer being
developed. To make changes to Docker export code, please look in
[components/pkg-build-docker](../pkg-build-docker) instead.

Changes to this package *will not be built* by either TravisCI or
Biome Builder.

The code still exists in the repository because `bio-pkg-cfize` has a
runtime dependency on `bio-pkg-dockerize`. The `bio-pkg-cfize`
exporter was written around the same time (but before)
`bio-pkg-export-docker` was rewritten. As a result, it uses the older
code.

Long term, `bio-pkg-cfize` should be rewritten in Rust, following the
basic pattern laid out by `bio-pkg-export-docker`. If changes need to
be made to `bio-pkg-cfize` in the meantime, and if those changes
should also require changes to `bio-pkg-dockerize`, try and make the
changes in `bio-pkg-cfize` instead of requiring new builds of old
packages. Newcomers to Biome shouldn't need to be confused by having
"current" packages of `bio-pkg-dockerize` alongside
`bio-pkg-export-docker`.
