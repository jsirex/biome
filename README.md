<img src="https://github.com/biome-sh/biome/blob/master/www/source/images/biome-logo.png" width="200">

[![Build Status](https://badge.buildkite.com/f527cd3d7851756ed1a5f6ec463dd41e7145f7941fd932672a.svg)](https://buildkite.com/chef/biome-sh-biome-master-verify?branch=master)
[![Slack](http://slack.biome.sh/badge.svg)](http://slack.biome.sh/)
[![Discourse status](https://img.shields.io/discourse/https/meta.discourse.org/status.svg?style=flat)](https://forums.biome.sh)
[![Open Source Helpers](https://www.codetriage.com/biome-sh/biome/badges/users.svg)](https://www.codetriage.com/biome-sh/biome)


[Biome](http://biome.sh) is open source software that creates platform-independent build artifacts and provides built-in deployment and management capabilities.

The goal of Biome is to allow you to automate your application behavior when you create your application, and then bundle your application with the automation it needs to behave with the correct run time behavior, update strategies, failure handling strategies, and scaling behavior, wherever you choose to deploy it.

See a quick demo of how to build, deploy and manage an application with Biome:

[![Build, Deploy and Manage with Biome (5:33)](images/overview-youtube-image.jpg)](http://www.youtube.com/watch?v=VW1DwDezlqM)

# Table of Contents
* [Diagrams](#diagrams)
* [Hands-on Demos](#hands-on-demos)
* [Install](#install)
* [Contribute](#contribute)
* [Documentation](#documentation)
* [Code Organization](#code-organization)
* [Roadmap](#roadmap)
* [Community and support](#community-and-support)
* [Building](#building)
* [Further reference material](#further-reference-material)
* [Code of Conduct](#code-of-conduct)
* [License](#license)

## Diagrams
Graphics that will help you and your team better understand the concepts and how they fit together into the larger Biome ecosystem.
### Where Biome Fits

[![Biome Flow Infographic](images/biome-flow-infographic.png)](http://biome.sh#reference-diagram)

Try the interactive infographics on the [website](http://biome.sh#reference-diagram)!

### How Biome Works
* [Architecture Overview](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/biome-architecture-overview.png)
* [Initial Package Build Flow](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/biome-initial-package-build-flow.png)
* [Application Rebuild Flow](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/biome-application-rebuild-flow.png)
* [Dependency Update Flow](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/biome-dependency-update-flow.png)
* [Promote Packages Through Channels](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/biome-promote-packages-through-channels.png)

### Biome and **Docker**
* [Initial Docker Container Publishing Flow](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/biome-initial-docker-container-publishing-flow.png)
* [Automated Docker Container Publishing Flow](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/biome-automated-docker-container-publishing-flow.png)

### Biome and **Kubernetes**
* [Three Tiers of Service Deployment](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/biome-and-kubernetes-three-tiers-of-service-deployment.png)
* [Deploy Services to Kubernetes with Biome](https://github.com/biome-sh/biome/raw/master/www/source/images/infographics/deploy-services-to-kubernetes-with-biome-flow.png)

*View all diagrams in [Docs](https://www.biome.sh/docs/diagrams/)*

## Hands-on Demos
Choose any topic to begin learning how Biome can help your team build, deploy, and manage all of your applications - both new and legacy - in a cloud-native way:
* [Package a sample application (15 mins)](https://www.biome.sh/demo/packaging-system/steps/1/)
* [Set up automated deployments (20 mins)](https://www.biome.sh/demo/build-system/steps/1/)
* [Auto-update a running application (15 mins)](https://www.biome.sh/demo/process-supervisor/steps/1/)

*View all demos and tutorials in [Learn](https://www.biome.sh/learn/)*


## Install

You can download Biome from the [Biome downloads page](https://www.biome.sh/docs/install-biome/).

Once you have downloaded it, follow the instructions on the page for your specific operating system.

If you are running macOS and use [Homebrew](https://brew.sh), you can use our official [Homebrew tap](https://github.com/biome-sh/homebrew-biome).
```
$ brew tap biome-sh/biome
$ brew install bio
```

If you are running Windows and use [Chocolatey](https://chocolatey.org), you can install our [chocolatey package](https://chocolatey.org/packages/biome)
```
C:\> choco install biome
```

If you do _not_ run Homebrew or Chocolatey, or if you use Linux, you can use the [Biome install
script](https://github.com/biome-sh/biome/blob/master/components/bio/install.sh) from a bash shell.

```
$ curl https://raw.githubusercontent.com/biome-sh/biome/master/components/bio/install.sh | sudo bash
```

## Contribute

We are always looking for more opportunities for community involvement. Interested in contributing? Check out our [CONTRIBUTING.md](CONTRIBUTING.md) to get started!

## Documentation

Get started with the [Biome tutorials](https://www.biome.sh/learn/) or plunge into the [complete documentation](https://www.biome.sh/docs/).

## Code Organization

### Core Plans

The Biome plans that are built and maintained by Biome's Core Team are in [their own repo.](https://github.com/habitat-sh/core-plans)

### Biome Supervisor and other core components

The code for the Biome Supervisor and other core components are in the [components directory](https://github.com/biome-sh/biome/tree/master/components).

### Docs

Biome's website and documentation source is located in the `www` directory of the Biome source code. See [its README](www/README.md) for more information.

## Roadmap

The Biome project's roadmap is public and is on our [community page](https://www.biome.sh/community/).

The Biome core team's project tracker is also public and on [Github.](https://github.com/biome-sh/biome/projects/1)

## Community and support

* [Biome Slack](http://slack.biome.sh)
* [Forums](https://forums.biome.sh)
* Community triage is every Tuesday at 10am Pacific. The link to participate is shared in the [Biome Slack channel](http://slack.biome.sh), and videos are posted on the [Biome YouTube channel](https://youtube.com/channel/UC0wJZeP2dfPZaDUPgvpVpSg).

## Building
See [BUILDING.md](BUILDING.md) for platform specific info on building Biome from source.

## Further reference material

* [The Rust Programming Language](http://doc.rust-lang.org/book/)
* [Rust by Example](http://rustbyexample.com/)
* [Introduction to Bash programming](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html)
* [Advanced Bash-Scripting Guide](http://www.tldp.org/LDP/abs/html/)
* [Bash Cheat Sheet](http://tldp.org/LDP/abs/html/refcards.html)
* [Writing Robust Bash Shell Scripts](http://www.davidpashley.com/articles/writing-robust-shell-scripts/)
* [Wikibook: Bourne Shell Scripting](https://en.wikibooks.org/wiki/Bourne_Shell_Scripting)
* [What is the difference between test, \[ and \[\[ ?](http://mywiki.wooledge.org/BashFAQ/031)
* [POSIX Shell Command Language](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html)

## Code of Conduct
Participation in the Biome community is governed by the [code of conduct](https://github.com/biome-sh/biome/blob/master/CODE_OF_CONDUCT.md).

## License

Copyright (c) 2016 Chef Software Inc. and/or applicable contributors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
