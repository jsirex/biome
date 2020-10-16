+++
title = "Configure the Biome CLI"
description = "Set up the Biome CLI"

[menu]
  [menu.bioitat]
    title = "Set up the Biome CLI"
    identifier = "habitat/get_started/bio-setup Install Biome"
    parent = "habitat/get_started"
    weight = 20

+++

Once Biome has been installed, the `bio` CLI makes it easy to get your workstation configured by guiding through the setup process. To set up your workstation, run `bio cli setup` and follow the instructions.

<img alt="screenshot of bio cli setup output in CLI" src="/images/screenshots/bio-setup.png">

Setup asks you to create a new origin and a set of origin keys.

Optionally, you can also provide a Biome personal access token to upload packages to the public depot and share them with the Biome community. See the [access token documentation](/docs/using-builder/#builder-token) for details on generating and using your access token.

> For more information about using Biome Builder, see the section on [Using Builder](/docs/using-builder/).

You will also be asked if you want to register Supervisor control gateway secret (see [Remote Command-and-Control of Supervisors](/docs/using-habitat/#remote-control) for further details).

During setup, you may elect to provide anonymous usage data of the `bio` CLI tool. This information is used by the Biome team to improve the CLI experience.
For information on the types of data we gather and how we intend to use it, see [Analytics in Biome](/docs/about-analytics).

You can change your settings at any time by re-running the `bio cli setup` command.

<img alt="screenshot of completed bio cli setup in CLI" src="/images/screenshots/bio-setup-complete.png">

That's it. You're all set up and ready to use Biome to build and run packages!
