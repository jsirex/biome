+++
title = "Get Biome"
description = "Install the Biome CLI and configure your workstation for Biome development"

aliases = ["/habitat/install-habitat/"]

[menu]
  [menu.biome]
    title = "Get Biome"
    identifier = "habitat/get_started/installing-packages"
    parent = "habitat/get_started"
    weight = 10

+++
[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/install_habitat.md)

Below you'll find installation instructions for each platform and their requirements. The Biome CLI is currently supported on Linux, Mac, and Windows.

## Download and Install the Biome CLI Tool

From building packages to running services, everything in Biome is done through the bio command-line interface (CLI) tool. To get started using Biome, you need to download and install the bio CLI tool that corresponds to your workstation OS.
hr

### Biome for Linux

Biome for Linux requires a 64-bit processor with kernel 2.6.32 or later. On Linux, exporting your Biome artifact to a Docker image requires the Docker Engine supplied by Docker. Packages from distribution-specific or otherwise alternative providers are currently not supported.

Once you have downloaded the package, extract the bio binary with tar to `/usr/local/bin` or add its location to your `PATH` (e.g. `tar -xvzf bio.tgz -C /usr/local/bin --strip-components 1`).

[Download Biome for Linux](https://downloads.chef.io/products/habitat)

#### Install Biome from the Command Line

Alternatively, you can install Biome via the command line by downloading and running the installation script:

```shell
curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/bio/install.sh | sudo bash
```

#### Install Biome for Linux Kernel 2.x from the Command Line

Please note that support for Linux Kernel 2.x is limited. Not all core plans are available for Kernel 2.x, nor are there plans to backport all of the existing core plans to Kernel 2.x.  Kernel 2.x is legacy technology by definition, and its use should be viewed as a stop-gap to provide interim solutions for old systems, as they are upgraded to more recent versions of the Linux kernel.

```bash
curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/bio/install.sh | sudo bash -s -- -t x86_64-linux-kernel2
```

## Biome for Mac

Requires 64-bit processor running 10.9 or later

Once you have downloaded the `bio` CLI, unzip it onto your machine. Unzipping to `/usr/local/bin` should place it on your `PATH`. In order to use the Biome Studio, you'll also need to install Docker for Mac.

[Download Biome for Mac](https://downloads.chef.io/products/habitat)

[Download Docker for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)

#### Install Biome Using Homebrew

Biome can also be installed with Homebrew, by running the following commands:

```bash
brew tap biome-sh/biome
brew install bio
```

### Biome for Windows

Minimum Windows version supported: Windows Server 2012  or Windows 8 64-bit

Chocolatey is a package manager for Windows. You can use it to easily install, configure, upgrade, and even uninstall Windows software packages. We recommend using Chocolatey for installing Biome.

Install Biome with Chocolatey, by running the following command:

```powershell
choco install biome
```

#### Install Biome using a Powershell install script

Alternatively, you can install Biome by downloading and running the installation script:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/habitat-sh/habitat/master/components/bio/install.ps1'))
```

#### Installing Biome for Windows using the dowloaded Biome package.

Downloaded the `bio` CLI, unzip it onto your machine. We suggest unzipping to `C:\habitat`, so that the full path to Biome is similar to `C:\biome\bio-0.79.1-20190410221450-x86_64-windows`. If you've downloaded a more recent version of Biome, you'll see a different set of numbers following `bio-`. Replace the package name used in these examples with the filename you see on your computer. Next, add that folder to your `PATH` variable so your computer will know where to find it. Here's how to do that with Powershell:

```powershell
$env:PATH += ";C:\biome\bio-0.79.1-20190410221450-x86_64-windows\"
```

To use a Docker Biome Studio as an isolated environment, you'll also need to install Docker for Windows.

Docker for Windows requires 64-bit Windows 10 Pro, Enterprise, or Education editions (1607 Anniversary Update, Build 14393 or later) with Hyper-V enabled

[Download Biome for Windows](https://downloads.chef.io/products/habitat)

[Download Docker for Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows)
