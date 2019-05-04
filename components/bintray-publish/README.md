# Bintray Artifact Publishing

There is one type of artifact currently published to the Biome Bintray
account: a simple platform-native archive containing a `bio` CLI binary. At present, only 64-bit
Linux and 64-bit Mac binaries are being produced and published and more target
platforms may be added in the future.

## Required credentials

In order to publish one or all of these artifact types, there are several
required credentials relating to the Bintray platform:

* `BINTRAY_USER` - Bintray account username, required for `publish-bio`
* `BINTRAY_KEY` - Bintray user API key, required for `publish-bio`
* `BINTRAY_PASSPHRASE` - Passphrase for Bintray GPG signing key, required  for `publish-bio`

## TL;DR Publishing

We use the following in our release process:

1. On your workstation, change your code directory and enter a studio

    ```
    $ cd ~/code
    $ bio studio enter
    ```

1. Install the Bintray publishing code and export your credentials

    ```
    $ bio install biome/bio-bintray-publish
    $ export BINTRAY_USER=yourusername BINTRAY_KEY=yourkey BINTRAY_PASSPHRASE=commongpgkeypassphrase
    ```

1. Publish the Linux and Mac artifacts by selecting the appropriate `.hart` file

    ```
    $ bio pkg exec biome/bio-bintray-publish publish-bio \
      ./results/biome-bio-0.10.2-20160930230245-x86_64-linux.hart
    $ bio pkg exec biome/bio-bintray-publish publish-bio \
      ./biome/components/bio/mac/results/biome-bio-0.10.2-20160930230245-x86_64-darwin.hart
    ```

## Publishing `bio` binaries

The software to publish binaries is shipped and executed as a Biome package
(naturally) which is hosted on the public Builder as the
`biome/bio-bintray-publish` package. Currently this software is only supported
in a Linux environment, so an operator using a Mac workstation may opt to run
the following from a Docker container, a virtual machine, a cloud instance, a
CI worker, etc.

First, install the latest package from Builder:

```sh
bio install biome/bio-bintray-publish
```

Next, ensure that the 3 required credentials are exported as environment
variables. The program will fail if any of the required variables are not
present. Contact a Biome core maintainer if you require access to Bintray.

```sh
export BINTRAY_USER=jdoe BINTRAY_KEY=mykey BINTRAY_PASSPHRASE=gpgkeypassphrase
```

Finally, run the publish program using `bio pkg exec` in order to have the
program's `PATH` correctly set.

```sh
bio pkg exec biome/bio-bintray-publish publish-bio \
  ./results/biome-bio-0.7.0-20160614231131-x86_64-darwin.hart
```

```

## Building publishing package

The `biome/bio-bintray-publish` Plan is located under `support/bintray-publish`:

```sh
# build the package
bio pkg build ./support/bintray-publish

# upload a result to Builder
bio pkg upload \
  ./results/biome-bio-bintray-publish-0.7.0-20160614234255-x86_64-linux.hart

# install a result
bio pkg install \
  ./results/biome-bio-bintray-publish-0.7.0-20160614234255-x86_64-linux.hart
```
