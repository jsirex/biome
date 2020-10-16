+++
title = "hab CLI Reference"
draft= false

[menu]
  [menu.bioitat]
    title = "hab CLI Reference"
    identifier = "habitat/reference/biome-cli"
    parent = "habitat/reference"
+++

<!-- This is a generated file, do not edit it directly. See https://github.com/habitat-sh/habitat/blob/master/www/scripts/generate-cli-docs.js -->

# Biome Command-Line Interface (CLI) Reference

The commands for the Biome CLI (`bio`) are listed below.

| Applies to Version | Last Updated |
| ++++++- | ++++++++++++ |
| bio 1.5.50/20200303162333 (linux) | 3 Mar 2020 |

## bio



**USAGE**

```
hab <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```



**ALIASES**

```
apply      Alias for: 'config apply'
install    Alias for: 'pkg install'
run        Alias for: 'sup run'
setup      Alias for: 'cli setup'
start      Alias for: 'svc start'
stop       Alias for: 'svc stop'
term       Alias for: 'sup term'
```

**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio bldr](#hab-bldr) | Commands relating to Biome Builder |
| [bio cli](#hab-cli) | Commands relating to Biome runtime config |
| [bio config](#hab-config) | Commands relating to a Service's runtime config |
| [bio file](#hab-file) | Commands relating to Biome files |
| [bio license](#hab-license) | Commands relating to Biome license agreements |
| [bio origin](#bio-origin) | Commands relating to Biome Builder origins |
| [bio pkg](#bio-pkg) | Commands relating to Biome packages |
| [bio plan](#bio-plan) | Commands relating to plans and other app-specific configuration |
| [bio ring](#hab-ring) | Commands relating to Biome rings |
| [bio studio](#bio-studio) | Commands relating to Biome Studios |
| [bio sup](#bio-sup) | The Biome Supervisor |
| [bio supportbundle](#bio-supportbundle) | Create a tarball of Biome Supervisor data to send to support |
| [bio svc](#hab-svc) | Commands relating to Biome services |
| [bio user](#bio-user) | Commands relating to Biome users |
+++

## bio bldr

Commands relating to Biome Builder

**USAGE**

```
bio bldr <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio bldr channel](#hab-bldr-channel) | Commands relating to Biome Builder channels |
| [bio bldr job](#hab-bldr-job) | Commands relating to Biome Builder jobs |
+++

### bio bldr channel

Commands relating to Biome Builder channels

**USAGE**

```
bio bldr channel <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio bldr channel create](#hab-bldr-channel-create) | Creates a new channel |
| [bio bldr channel demote](#hab-bldr-channel-demote) | Atomically demotes selected packages in a target channel |
| [bio bldr channel destroy](#hab-bldr-channel-destroy) | Destroys a channel |
| [bio bldr channel list](#hab-bldr-channel-list) | Lists origin channels |
| [bio bldr channel promote](#hab-bldr-channel-promote) | Atomically promotes all packages in channel |
+++

### bio bldr channel create

Creates a new channel

**USAGE**

```
bio bldr channel create [OPTIONS] <CHANNEL>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-u, --url <BLDR_URL>     Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-o, --origin <ORIGIN>    Sets the origin to which the channel will belong. Default is from 'HAB_ORIGIN' or cli.toml
```

**ARGS**

```
<CHANNEL>    The channel name
```



+++

### bio bldr channel demote

Atomically demotes selected packages in a target channel

**USAGE**

```
bio bldr channel demote [OPTIONS] <SOURCE_CHANNEL> <TARGET_CHANNEL> --origin <ORIGIN>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-o, --origin <ORIGIN>      The origin for the channels. Default is from 'HAB_ORIGIN' or cli.toml
```

**ARGS**

```
<SOURCE_CHANNEL>    The channel from which all packages will be selected for demotion
<TARGET_CHANNEL>    The channel selected packages will be removed from
```



+++

### bio bldr channel destroy

Destroys a channel

**USAGE**

```
bio bldr channel destroy [OPTIONS] <CHANNEL>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-u, --url <BLDR_URL>     Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-o, --origin <ORIGIN>    Sets the origin to which the channel belongs. Default is from 'HAB_ORIGIN' or cli.toml
```

**ARGS**

```
<CHANNEL>    The channel name
```



+++

### bio bldr channel list

Lists origin channels

**USAGE**

```
bio bldr channel list [OPTIONS] [ORIGIN]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-u, --url <BLDR_URL>    Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>    The origin for which channels will be listed. Default is from 'HAB_ORIGIN' or cli.toml
```



+++

### bio bldr channel promote

Atomically promotes all packages in channel

**USAGE**

```
bio bldr channel promote [OPTIONS] <SOURCE_CHANNEL> <TARGET_CHANNEL> --origin <ORIGIN>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-o, --origin <ORIGIN>      The origin for the channels. Default is from 'HAB_ORIGIN' or cli.toml
```

**ARGS**

```
<SOURCE_CHANNEL>    The channel from which all packages will be selected for promotion
<TARGET_CHANNEL>    The channel to which packages will be promoted
```



+++

### bio bldr job

Commands relating to Biome Builder jobs

**USAGE**

```
bio bldr job <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio bldr job cancel](#hab-bldr-job-cancel) | Cancel a build job group and any in-progress builds |
| [bio bldr job demote](#hab-bldr-job-demote) | Demote packages from a completed build job from a specified channel |
| [bio bldr job promote](#hab-bldr-job-promote) | Promote packages from a completed build job to a specified channel |
| [bio bldr job start](#hab-bldr-job-start) | Schedule a build job or group of jobs |
| [bio bldr job status](#hab-bldr-job-status) | Get the status of one or more job groups |
+++

### bio bldr job cancel

Cancel a build job group and any in-progress builds

**USAGE**

```
bio bldr job cancel [FLAGS] [OPTIONS] <GROUP_ID>
```

**FLAGS**

```
-f, --force      Don't prompt for confirmation
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<GROUP_ID>    The job group id that was returned from "bio bldr job start" (ex: 771100000000000000)
```



+++

### bio bldr job demote

Demote packages from a completed build job from a specified channel

**USAGE**

```
bio bldr job demote [FLAGS] [OPTIONS] <GROUP_ID> <CHANNEL>
```

**FLAGS**

```
-i, --interactive    Allow editing the list of demotable packages
-h, --help           Prints help information
-V, --version        Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-o, --origin <ORIGIN>      Limit the demotable packages to the specified origin
```

**ARGS**

```
<GROUP_ID>    The job group id that was returned from "bio bldr job start" (ex: 771100000000000000)
<CHANNEL>     The name of the channel to demote from
```



+++

### bio bldr job promote

Promote packages from a completed build job to a specified channel

**USAGE**

```
bio bldr job promote [FLAGS] [OPTIONS] <GROUP_ID> <CHANNEL>
```

**FLAGS**

```
-i, --interactive    Allow editing the list of promotable packages
-h, --help           Prints help information
-V, --version        Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-o, --origin <ORIGIN>      Limit the promotable packages to the specified origin
```

**ARGS**

```
<GROUP_ID>    The job group id that was returned from "bio bldr job start" (ex: 771100000000000000)
<CHANNEL>     The target channel name
```



+++

### bio bldr job start

Schedule a build job or group of jobs

**USAGE**

```
bio bldr job start [FLAGS] [OPTIONS] <PKG_IDENT> [PKG_TARGET]
```

**FLAGS**

```
-g, --group      Schedule jobs for this package and all of its reverse dependencies
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<PKG_IDENT>     A package identifier (ex: core/redis, core/busybox-static/1.42.2)
<PKG_TARGET>    A package target (ex: x86_64-windows) (default: system appropriate target) [env: HAB_PACKAGE_TARGET=]
```



+++

### bio bldr job status

Get the status of one or more job groups

**USAGE**

```
bio bldr job status [FLAGS] [OPTIONS] <GROUP_ID|--origin <ORIGIN>>
```

**FLAGS**

```
-s, --showjobs    Show the status of all build jobs for a retrieved job group
-h, --help        Prints help information
-V, --version     Prints version information
```

**OPTIONS**

```
-u, --url <BLDR_URL>     Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-l, --limit <LIMIT>      Limit how many job groups to retrieve, ordered by most recent (default: 10)
-o, --origin <ORIGIN>    Show the status of recent job groups created in this origin (default: 10 most recent)
```

**ARGS**

```
<GROUP_ID>    The job group id that was returned from "bio bldr job start" (ex: 771100000000000000)
```



+++

## bio cli

Commands relating to Biome runtime config

**USAGE**

```
bio cli <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio cli completers](#hab-cli-completers) | Creates command-line completers for your shell |
| [bio cli setup](#hab-cli-setup) | Sets up the CLI with reasonable defaults |
+++

### bio cli completers

Creates command-line completers for your shell

**USAGE**

```
bio cli completers --shell <SHELL>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-s, --shell <SHELL>    The name of the shell you want to generate the command-completion [possible values: Bash, Fish, Zsh, PowerShell]
```




+++

### bio cli setup

Sets up the CLI with reasonable defaults

**USAGE**

```
bio cli setup --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```




+++

## bio config

Commands relating to a Service's runtime config

**USAGE**

```
bio config <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio config apply](#hab-config-apply) | Sets a configuration to be shared by members of a Service Group |
| [bio config show](#hab-config-show) | Displays the default configuration options for a service |
+++

### bio config apply

Sets a configuration to be shared by members of a Service Group

**USAGE**

```
bio config apply [OPTIONS] <SERVICE_GROUP> <VERSION_NUMBER> --cache-key-path <CACHE_KEY_PATH> [FILE]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
-r, --remote-sup <REMOTE_SUP>            Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]
-u, --user <USER>                        Name of a user key to use for encryption
```

**ARGS**

```
<SERVICE_GROUP>     Target service group service.group[@organization] (ex: redis.default or foo.default@bazcorp)
<VERSION_NUMBER>    A version number (positive integer) for this configuration (ex: 42)
<FILE>              Path to local file on disk (ex: /tmp/config.toml, default: <stdin>)
```



+++

### bio config show

Displays the default configuration options for a service

**USAGE**

```
bio config show [OPTIONS] <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-r, --remote-sup <REMOTE_SUP>    Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

## bio file

Commands relating to Biome files

**USAGE**

```
bio file <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio file upload](#hab-file-upload) | Uploads a file to be shared between members of a Service Group |
+++

### bio file upload

Uploads a file to be shared between members of a Service Group

**USAGE**

```
bio file upload [OPTIONS] <SERVICE_GROUP> <VERSION_NUMBER> <FILE> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
-r, --remote-sup <REMOTE_SUP>            Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]
-u, --user <USER>                        Name of the user key
```

**ARGS**

```
<SERVICE_GROUP>     Target service group service.group[@organization] (ex: redis.default or foo.default@bazcorp)
<VERSION_NUMBER>    A version number (positive integer) for this configuration (ex: 42)
<FILE>              Path to local file on disk
```



+++

## bio license

Commands relating to Biome license agreements

**USAGE**

```
bio license <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio license accept](#hab-license-accept) | Accept the Biome Binary Distribution Agreement without prompting |
+++

### bio license accept

Accept the Biome Binary Distribution Agreement without prompting

**USAGE**

```
bio license accept
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```





+++

## bio origin

Commands relating to Biome Builder origins

**USAGE**

```
bio origin <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio origin create](#bio-origin-create) | Creates a new Builder origin |
| [bio origin delete](#bio-origin-delete) | Removes an unused/empty origin |
| [bio origin depart](#bio-origin-depart) | Departs membership from selected origin |
| [bio origin info](#bio-origin-info) | Displays general information about an origin |
| [bio origin invitations](#bio-origin-invitations) | Manage origin member invitations |
| [bio origin key](#bio-origin-key) | Commands relating to Biome origin key maintenance |
| [bio origin secret](#bio-origin-secret) | Commands related to secret management |
| [bio origin transfer](#bio-origin-transfer) | Transfers ownership of an origin to another member of that origin |
+++

### bio origin create

Creates a new Builder origin

**USAGE**

```
bio origin create [OPTIONS] <ORIGIN>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>    The origin to be created
```



+++

### bio origin delete

Removes an unused/empty origin

**USAGE**

```
bio origin delete [OPTIONS] <ORIGIN>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>    The origin name
```



+++

### bio origin depart

Departs membership from selected origin

**USAGE**

```
bio origin depart [OPTIONS] <ORIGIN>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>    The origin name
```



+++

### bio origin info

Displays general information about an origin

**USAGE**

```
bio origin info [FLAGS] [OPTIONS] <ORIGIN>
```

**FLAGS**

```
-j, --json       Output will be rendered in json
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>    The origin name to be queried
```



+++

### bio origin invitations

Manage origin member invitations

**USAGE**

```
bio origin invitations <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio origin invitations accept](#bio-origin-invitations-accept) | Accept an origin member invitation |
| [bio origin invitations ignore](#bio-origin-invitations-ignore) | Ignore an origin member invitation |
| [bio origin invitations list](#bio-origin-invitations-list) | List origin invitations sent to your account |
| [bio origin invitations pending](#bio-origin-invitations-pending) | List pending invitations for a particular origin. Requires that you are the origin owner |
| [bio origin invitations rescind](#bio-origin-invitations-rescind) | Rescind an existing origin member invitation |
| [bio origin invitations send](#bio-origin-invitations-send) | Send an origin member invitation |
+++

### bio origin invitations accept

Accept an origin member invitation

**USAGE**

```
bio origin invitations accept [OPTIONS] <ORIGIN> <INVITATION_ID>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>           The origin name the invitation applies to
<INVITATION_ID>    The id of the invitation to accept
```



+++

### bio origin invitations ignore

Ignore an origin member invitation

**USAGE**

```
bio origin invitations ignore [OPTIONS] <ORIGIN> <INVITATION_ID>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>           The origin name the invitation applies to
<INVITATION_ID>    The id of the invitation to ignore
```



+++

### bio origin invitations list

List origin invitations sent to your account

**USAGE**

```
bio origin invitations list [OPTIONS]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```




+++

### bio origin invitations pending

List pending invitations for a particular origin. Requires that you are the origin owner

**USAGE**

```
bio origin invitations pending [OPTIONS] <ORIGIN>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>    The name of the origin you wish to list invitations for
```



+++

### bio origin invitations rescind

Rescind an existing origin member invitation

**USAGE**

```
bio origin invitations rescind [OPTIONS] <ORIGIN> <INVITATION_ID>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>           The origin name the invitation applies to
<INVITATION_ID>    The id of the invitation to rescind
```



+++

### bio origin invitations send

Send an origin member invitation

**USAGE**

```
bio origin invitations send [OPTIONS] <ORIGIN> <INVITEE_ACCOUNT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>             The origin name the invitation applies to
<INVITEE_ACCOUNT>    The account name to invite into the origin
```



+++

### bio origin key

Commands relating to Biome origin key maintenance

**USAGE**

```
bio origin key <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio origin key download](#bio-origin-key-download) | Download origin key(s) |
| [bio origin key export](#bio-origin-key-export) | Outputs the latest origin key contents to stdout |
| [bio origin key generate](#bio-origin-key-generate) | Generates a Biome origin key pair |
| [bio origin key import](#bio-origin-key-import) | Reads a stdin stream containing a public or private origin key contents and writes the key to disk |
| [bio origin key upload](#bio-origin-key-upload) | Upload origin keys to Builder |
+++

### bio origin key download

Download origin key(s)

**USAGE**

```
bio origin key download [FLAGS] [OPTIONS] <ORIGIN> --cache-key-path <CACHE_KEY_PATH> [REVISION]
```

**FLAGS**

```
-e, --encryption    Download public encryption key instead of origin public key
-s, --secret        Download origin private key instead of origin public key
-h, --help          Prints help information
-V, --version       Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>                  Authentication token for Builder (required for downloading origin private keys)
-u, --url <BLDR_URL>                     Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
    --cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```

**ARGS**

```
<ORIGIN>      The origin name
<REVISION>    The origin key revision
```



+++

### bio origin key export

Outputs the latest origin key contents to stdout

**USAGE**

```
bio origin key export [OPTIONS] <ORIGIN> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
-t, --type <PAIR_TYPE>                   Export either the 'public' or 'secret' key. The 'secret' key is the origin private key
```

**ARGS**

```
<ORIGIN>    The origin name
```



+++

### bio origin key generate

Generates a Biome origin key pair

**USAGE**

```
bio origin key generate --cache-key-path <CACHE_KEY_PATH> [ORIGIN]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```

**ARGS**

```
<ORIGIN>    The origin name
```



+++

### bio origin key import

Reads a stdin stream containing a public or private origin key contents and writes the key to disk

**USAGE**

```
bio origin key import --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```




+++

### bio origin key upload

Upload origin keys to Builder

**USAGE**

```
bio origin key upload [FLAGS] [OPTIONS] --cache-key-path <CACHE_KEY_PATH> <ORIGIN|--pubfile <PUBLIC_FILE>>
```

**FLAGS**

```
-s, --secret     Upload origin private key in addition to the public key
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>                  Authentication token for Builder
-u, --url <BLDR_URL>                     Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
    --cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
    --pubfile <PUBLIC_FILE>              Path to a local public origin key file on disk
    --secfile <SECRET_FILE>              Path to a local origin private key file on disk
```

**ARGS**

```
<ORIGIN>    The origin name
```



+++

### bio origin secret

Commands related to secret management

**USAGE**

```
bio origin secret <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio origin secret delete](#bio-origin-secret-delete) | Delete a secret for your origin |
| [bio origin secret list](#bio-origin-secret-list) | List all secrets for your origin |
| [bio origin secret upload](#bio-origin-secret-upload) | Create and upload a secret for your origin |
+++

### bio origin secret delete

Delete a secret for your origin

**USAGE**

```
bio origin secret delete [OPTIONS] <KEY_NAME>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-o, --origin <ORIGIN>      The origin for which the secret will be deleted. Default is from 'HAB_ORIGIN' or cli.toml
```

**ARGS**

```
<KEY_NAME>    The name of the variable key to be injected into the studio
```



+++

### bio origin secret list

List all secrets for your origin

**USAGE**

```
bio origin secret list [OPTIONS]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-o, --origin <ORIGIN>      The origin for which secrets will be listed. Default is from 'HAB_ORIGIN' or cli.toml
```




+++

### bio origin secret upload

Create and upload a secret for your origin

**USAGE**

```
bio origin secret upload [OPTIONS] <KEY_NAME> <SECRET> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>                  Authentication token for Builder
-u, --url <BLDR_URL>                     Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
    --cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
-o, --origin <ORIGIN>                    The origin for which the secret will be uploaded. Default is from HAB_ORIGIN' or cli.toml
```

**ARGS**

```
<KEY_NAME>    The name of the variable key to be injected into the studio. Ex: KEY="some_value"
<SECRET>      The contents of the variable to be injected into the studio
```



+++

### bio origin transfer

Transfers ownership of an origin to another member of that origin

**USAGE**

```
bio origin transfer [OPTIONS] <ORIGIN> <NEW_OWNER_ACCOUNT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<ORIGIN>               The origin name
<NEW_OWNER_ACCOUNT>    The account name of the new origin owner
```



+++

## bio pkg

Commands relating to Biome packages

**USAGE**

```
bio pkg <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio pkg binds](#bio-pkg-binds) | Displays the binds for a service |
| [bio pkg binlink](#bio-pkg-binlink) | Creates a binlink for a package binary in a common 'PATH' location |
| [bio pkg build](#bio-pkg-build) | Builds a Plan using a Studio |
| [bio pkg bulkupload](#bio-pkg-bulkupload) | Bulk Uploads Biome Artifacts to a Depot from a local directory |
| [bio pkg channels](#bio-pkg-channels) | Find out what channels a package belongs to |
| [bio pkg config](#bio-pkg-config) | Displays the default configuration options for a service |
| [bio pkg delete](#bio-pkg-delete) | Removes a package from Builder |
| [bio pkg demote](#bio-pkg-demote) | Demote a package from a specified channel |
| [bio pkg dependencies](#bio-pkg-dependencies) | Returns the Biome Artifact dependencies. By default it will return the direct dependencies of the package |
| [bio pkg download](#bio-pkg-download) | Download Biome artifacts (including dependencies and keys) from Builder |
| [bio pkg env](#bio-pkg-env) | Prints the runtime environment of a specific installed package |
| [bio pkg exec](#bio-pkg-exec) | Executes a command using the 'PATH' context of an installed package |
| [bio pkg export](#bio-pkg-export) | Exports the package to the specified format |
| [bio pkg hash](#bio-pkg-hash) | Generates a blake2b hashsum from a target at any given filepath |
| [bio pkg info](#bio-pkg-info) | Returns the Biome Artifact information |
| [bio pkg install](#bio-pkg-install) | Installs a Biome package from Builder or locally from a Biome Artifact |
| [bio pkg list](#bio-pkg-list) | List all versions of installed packages |
| [bio pkg path](#bio-pkg-path) | Prints the path to a specific installed release of a package |
| [bio pkg promote](#bio-pkg-promote) | Promote a package to a specified channel |
| [bio pkg provides](#bio-pkg-provides) | Search installed Biome packages for a given file |
| [bio pkg search](#bio-pkg-search) | Search for a package in Builder |
| [bio pkg sign](#bio-pkg-sign) | Signs an archive with an origin key, generating a Biome Artifact |
| [bio pkg uninstall](#bio-pkg-uninstall) | Safely uninstall a package and dependencies from the local filesystem |
| [bio pkg upload](#bio-pkg-upload) | Uploads a local Biome Artifact to Builder |
| [bio pkg verify](#bio-pkg-verify) | Verifies a Biome Artifact with an origin key |
+++

### bio pkg binds

Displays the binds for a service

**USAGE**

```
bio pkg binds <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```


**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio pkg binlink

Creates a binlink for a package binary in a common 'PATH' location

**USAGE**

```
bio pkg binlink [FLAGS] [OPTIONS] <PKG_IDENT> [BINARY]
```

**FLAGS**

```
-f, --force      Overwrite existing binlinks
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-d, --dest <DEST_DIR>    Sets the destination directory [env: HAB_BINLINK_DIR=]  [default: /bin]
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
<BINARY>       The command to binlink (ex: bash)
```



+++

### bio pkg build

Builds a Plan using a Studio

**USAGE**

```
bio pkg build [FLAGS] [OPTIONS] <PLAN_CONTEXT> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-D, --docker     Uses a Dockerized Studio for the build
-R, --reuse      Reuses a previous Studio for the build (default: clean up before building)
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
-k, --keys <HAB_ORIGIN_KEYS>             Installs secret origin keys (ex: "unicorn", "acme,other,acme-ops")
-r, --root <HAB_STUDIO_ROOT>             Sets the Studio root (default: /hab/studios/<DIR_NAME>)
-s, --src <SRC_PATH>                     Sets the source path (default: $PWD)
```

**ARGS**

```
<PLAN_CONTEXT>    A directory containing a plan file or a biome/ directory which contains the plan file
```



+++

### bio pkg bulkupload

Bulk Uploads Biome Artifacts to a Depot from a local directory

**USAGE**

```
bio pkg bulkupload [FLAGS] [OPTIONS] <UPLOAD_DIRECTORY>
```

**FLAGS**

```
--auto-build             Enable auto-build for all packages in this upload. Only applicable to SaaS Builder
    --auto-create-origins    Skip the confirmation prompt and automatically create origins that do not exist in the target Builder
    --force                  Skip checking availability of package and force uploads, potentially overwriting a stored copy of a package
-h, --help                   Prints help information
-V, --version                Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-c, --channel <CHANNEL>    Optional additional release channel to upload package to. Packages are always uploaded to unstable, regardless of the value of this option
```

**ARGS**

```
<UPLOAD_DIRECTORY>    Directory Path from which artifacts will be uploaded
```



+++

### bio pkg channels

Find out what channels a package belongs to

**USAGE**

```
bio pkg channels [OPTIONS] <PKG_IDENT> [PKG_TARGET]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<PKG_IDENT>     A fully qualified package identifier (ex: core/busybox-static/1.42.2/20170513215502)
<PKG_TARGET>    A package target (ex: x86_64-windows) (default: system appropriate target) [env: HAB_PACKAGE_TARGET=]
```



+++

### bio pkg config

Displays the default configuration options for a service

**USAGE**

```
bio pkg config <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```


**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio pkg delete

Removes a package from Builder

**USAGE**

```
bio pkg delete [OPTIONS] <PKG_IDENT> [PKG_TARGET]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<PKG_IDENT>     A fully qualified package identifier (ex: core/busybox-static/1.42.2/20170513215502)
<PKG_TARGET>    A package target (ex: x86_64-windows) (default: system appropriate target) [env: HAB_PACKAGE_TARGET=]
```



+++

### bio pkg demote

Demote a package from a specified channel

**USAGE**

```
bio pkg demote [OPTIONS] <PKG_IDENT> <CHANNEL> [PKG_TARGET]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<PKG_IDENT>     A fully qualified package identifier (ex: core/busybox-static/1.42.2/20170513215502)
<CHANNEL>       Demote from the specified release channel
<PKG_TARGET>    A package target (ex: x86_64-windows) (default: system appropriate target) [env: HAB_PACKAGE_TARGET=]
```



+++

### bio pkg dependencies

Returns the Biome Artifact dependencies. By default it will return the direct dependencies of the package

**USAGE**

```
bio pkg dependencies [FLAGS] <PKG_IDENT>
```

**FLAGS**

```
-r, --reverse       Show packages which are dependant on this one
-t, --transitive    Show transitive dependencies
-h, --help          Prints help information
-V, --version       Prints version information
```


**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio pkg download

Download Biome artifacts (including dependencies and keys) from Builder

**USAGE**

```
bio pkg download [FLAGS] [OPTIONS] [--] [PKG_IDENT]...
```

**FLAGS**

```
--ignore-missing-seeds    Ignore packages specified that are not present on the target Builder
    --verify                  Verify package integrity after download (Warning: this can be slow)
-h, --help                    Prints help information
-V, --version                 Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>                          Authentication token for Builder
-u, --url <BLDR_URL> Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-c, --channel <CHANNEL> Download from the specified release channel. Overridden if channel is specified in toml file [env: HAB_BLDR_CHANNEL=]  [default: stable]
    --download-directory <DOWNLOAD_DIRECTORY>    The path to store downloaded artifacts
    --file <PKG_IDENT_FILE>... File with newline separated package identifiers, or TOML file (ending with .toml extension)

-t, --target <PKG_TARGET> Target architecture to fetch. E.g. x86_64-linux. Overridden if architecture is specified in toml file
```

**ARGS**

```
<PKG_IDENT>...    One or more Biome package identifiers (ex: acme/redis)
```



+++

### bio pkg env

Prints the runtime environment of a specific installed package

**USAGE**

```
bio pkg env <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```


**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio pkg exec

Executes a command using the 'PATH' context of an installed package

**USAGE**

```
bio pkg exec <PKG_IDENT> <CMD> [ARGS]...
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```


**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
<CMD>          The command to execute (ex: ls)
<ARGS>...      Arguments to the command (ex: -l /tmp)
```



+++

### bio pkg export

Exports the package to the specified format

**USAGE**

```
bio pkg export [OPTIONS] <FORMAT> <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-c, --channel <CHANNEL>    Retrieve the container's package from the specified release channel [env: HAB_BLDR_CHANNEL=]  [default: stable]
```

**ARGS**

```
<FORMAT>       The export format (ex: cf, docker, mesos, or tar)
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2) or filepath to a Biome Artifact (ex: /home/acme-redis-3.0.7-21120102031201-x86_64-linux.hart)
```



+++

### bio pkg hash

Generates a blake2b hashsum from a target at any given filepath

**USAGE**

```
bio pkg hash [SOURCE]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```


**ARGS**

```
<SOURCE>    A filepath of the target
```



+++

### bio pkg info

Returns the Biome Artifact information

**USAGE**

```
bio pkg info [FLAGS] <SOURCE>
```

**FLAGS**

```
-j, --json       Output will be rendered in json
-h, --help       Prints help information
-V, --version    Prints version information
```


**ARGS**

```
<SOURCE>    A path to a Biome Artifact (ex: /home/acme-redis-3.0.7-21120102031201-x86_64-linux.hart)
```



+++

### bio pkg install

Installs a Biome package from Builder or locally from a Biome Artifact

**USAGE**

```
bio pkg install [FLAGS] [OPTIONS] <PKG_IDENT_OR_ARTIFACT>...
```

**FLAGS**

```
-b, --binlink                Binlink all binaries from installed package(s) into BINLINK_DIR
-f, --force                  Overwrite existing binlinks
    --ignore-install-hook    Do not run any install hooks
-h, --help                   Prints help information
-V, --version                Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>            Authentication token for Builder
    --binlink-dir <BINLINK_DIR>    Binlink all binaries from installed package(s) into BINLINK_DIR [env: HAB_BINLINK_DIR=]  [default: /bin]
-u, --url <BLDR_URL>               Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-c, --channel <CHANNEL>            Install from the specified release channel [env: HAB_BLDR_CHANNEL=]  [default: stable]
```

**ARGS**

```
<PKG_IDENT_OR_ARTIFACT>...    One or more Biome package identifiers (ex: acme/redis) and/or filepaths to a Biome Artifact (ex: /home/acme-redis-3.0.7-21120102031201-x86_64-linux.hart)
```



+++

### bio pkg list

List all versions of installed packages

**USAGE**

```
bio pkg list [OPTIONS] <--all|--origin <ORIGIN>|PKG_IDENT>
```

**FLAGS**

```
-a, --all        List all installed packages
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-o, --origin <ORIGIN>    An origin to list
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio pkg path

Prints the path to a specific installed release of a package

**USAGE**

```
bio pkg path <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```


**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio pkg promote

Promote a package to a specified channel

**USAGE**

```
bio pkg promote [OPTIONS] <PKG_IDENT> <CHANNEL> [PKG_TARGET]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
```

**ARGS**

```
<PKG_IDENT>     A fully qualified package identifier (ex: core/busybox-static/1.42.2/20170513215502)
<CHANNEL>       Promote to the specified release channel
<PKG_TARGET>    A package target (ex: x86_64-windows) (default: system appropriate target) [env: HAB_PACKAGE_TARGET=]
```



+++

### bio pkg provides

Search installed Biome packages for a given file

**USAGE**

```
bio pkg provides [FLAGS] <FILE>
```

**FLAGS**

```
-p               Show full path to file
-r               Show fully qualified package names (ex: core/busybox-static/1.24.2/20160708162350)
-h, --help       Prints help information
-V, --version    Prints version information
```


**ARGS**

```
<FILE>    File name to find
```



+++

### bio pkg search

Search for a package in Builder

**USAGE**

```
bio pkg search [OPTIONS] <SEARCH_TERM>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>    Authentication token for Builder
-u, --url <BLDR_URL>       Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
-l, --limit <LIMIT>        Limit how many packages to retrieve [default: 50]
```

**ARGS**

```
<SEARCH_TERM>    Search term
```



+++

### bio pkg sign

Signs an archive with an origin key, generating a Biome Artifact

**USAGE**

```
bio pkg sign [OPTIONS] <SOURCE> <DEST> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
    --origin <ORIGIN>                    Origin key used to create signature
```

**ARGS**

```
<SOURCE>    A path to a source archive file (ex: /home/acme-redis-3.0.7-21120102031201.tar.xz)
<DEST>      The destination path to the signed Biome Artifact (ex: /home/acme-redis-3.0.7-21120102031201- x86_64-linux.hart)
```



+++

### bio pkg uninstall

Safely uninstall a package and dependencies from the local filesystem

**USAGE**

```
bio pkg uninstall [FLAGS] [OPTIONS] <PKG_IDENT>
```

**FLAGS**

```
-d, --dryrun     Just show what would be uninstalled, don't actually do it
    --no-deps    Don't uninstall dependencies
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--exclude <EXCLUDE>...    Identifier of one or more packages that should not be uninstalled. (ex: core/redis, core/busybox-static/1.42.2/21120102031201)
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio pkg upload

Uploads a local Biome Artifact to Builder

**USAGE**

```
bio pkg upload [FLAGS] [OPTIONS] <HART_FILE>... --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
--force       Skips checking availability of package and force uploads, potentially overwriting a stored copy of a package. (default: false)
    --no-build    Disable auto-build for all packages in this upload
-h, --help        Prints help information
-V, --version     Prints version information
```

**OPTIONS**

```
-z, --auth <AUTH_TOKEN>                  Authentication token for Builder
-u, --url <BLDR_URL>                     Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
    --cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
-c, --channel <CHANNEL>                  Optional additional release channel to upload package to. Packages are always uploaded to unstable, regardless of the value of this option
```

**ARGS**

```
<HART_FILE>...    One or more filepaths to a Biome Artifact (ex: /home/acme-redis-3.0.7-21120102031201-x86_64- linux.hart)
```



+++

### bio pkg verify

Verifies a Biome Artifact with an origin key

**USAGE**

```
bio pkg verify <SOURCE> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```

**ARGS**

```
<SOURCE>    A path to a Biome Artifact (ex: /home/acme-redis-3.0.7-21120102031201-x86_64-linux.hart)
```



+++

## bio plan

Commands relating to plans and other app-specific configuration

**USAGE**

```
bio plan <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio plan init](#bio-plan-init) | Generates common package specific configuration files. Executing without argument will create a biome directory in your current folder for the plan. If PKG_NAME is specified it will create a folder with that name. Environment variables (those starting with 'pkg_') that are set will be used in the generated plan |
| [bio plan render](#bio-plan-render) | Renders plan config files |
+++

### bio plan init

Generates common package specific configuration files. Executing without argument will create a biome directory in

**USAGE**

```
bio plan init [FLAGS] [OPTIONS] [PKG_NAME]
```

**FLAGS**

```
-m, --min        Create a minimal plan file
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-o, --origin <ORIGIN>              Origin for the new app
-s, --scaffolding <SCAFFOLDING>    Specify explicit Scaffolding for your app (ex: node, ruby)
```

**ARGS**

```
<PKG_NAME>    Name for the new app
```



+++

### bio plan render

Renders plan config files

**USAGE**

```
bio plan render [FLAGS] [OPTIONS] <TEMPLATE_PATH>
```

**FLAGS**

```
-n, --no-render    Don't write anything to disk, ignores --render-dir
-p, --print        Prints config to STDOUT
-q, --quiet        Don't print any helper messages.  When used with --print will only print config file
-h, --help         Prints help information
-V, --version      Prints version information
```

**OPTIONS**

```
-d, --default-toml <DEFAULT_TOML>    Path to default.toml [default: ./default.toml]
-m, --mock-data <MOCK_DATA>          Path to json file with mock data for template, defaults to none
-r, --render-dir <RENDER_DIR>        Path to render templates [default: ./results]
-u, --user-toml <USER_TOML>          Path to user.toml, defaults to none
```

**ARGS**

```
<TEMPLATE_PATH>    Path to config to render
```



+++

## bio ring

Commands relating to Biome rings

**USAGE**

```
bio ring <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio ring key](#hab-ring-key) | Commands relating to Biome ring keys |
+++

### bio ring key

Commands relating to Biome ring keys

**USAGE**

```
bio ring key <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio ring key export](#hab-ring-key-export) | Outputs the latest ring key contents to stdout |
| [bio ring key generate](#hab-ring-key-generate) | Generates a Biome ring key |
| [bio ring key import](#hab-ring-key-import) | Reads a stdin stream containing ring key contents and writes the key to disk |
+++

### bio ring key export

Outputs the latest ring key contents to stdout

**USAGE**

```
bio ring key export <RING> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```

**ARGS**

```
<RING>    Ring key name
```



+++

### bio ring key generate

Generates a Biome ring key

**USAGE**

```
bio ring key generate <RING> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```

**ARGS**

```
<RING>    Ring key name
```



+++

### bio ring key import

Reads a stdin stream containing ring key contents and writes the key to disk

**USAGE**

```
bio ring key import --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```




+++

## bio studio



**USAGE**

```
bio studio [FLAGS] [OPTIONS] <SUBCOMMAND> [ARG ..]
```





**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio studio build](#bio-studio-build) | Build using a Studio |
| [bio studio enter](#bio-studio-enter) | Interactively enter a Studio |
| [bio studio new](#bio-studio-new) | Creates a new Studio |
| [bio studio rm](#bio-studio-rm) | Destroys a Studio |
| [bio studio run](#bio-studio-run) | Run a command in a Studio |
| [bio studio version](#bio-studio-version) | Prints version information |
+++

### bio studio build



**USAGE**

```
bio studio [COMMON_FLAGS] [COMMON_OPTIONS] build [FLAGS] [PLAN_DIR]
```

**FLAGS**

```
-R  Reuse a previous Studio state (default: clean up before building)
```





+++

### bio studio enter



**USAGE**

```
bio studio [COMMON_FLAGS] [COMMON_OPTIONS] enter
```






+++

### bio studio new



**USAGE**

```
bio studio [COMMON_FLAGS] [COMMON_OPTIONS] new
```






+++

### bio studio rm



**USAGE**

```
bio studio [COMMON_FLAGS] [COMMON_OPTIONS] rm
```






+++

### bio studio run



**USAGE**

```
bio studio [COMMON_FLAGS] [COMMON_OPTIONS] run [CMD] [ARG ..]
```






+++

### bio studio version









+++

## bio sup



**USAGE**

```
bio sup <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio sup bash](#bio-sup-bash) | Start an interactive Bash-like shell |
| [bio sup depart](#bio-sup-depart) | Depart a Supervisor from the gossip ring; kicking and banning the target from joining again with the same member-id |
| [bio sup run](#bio-sup-run) | Run the Biome Supervisor |
| [bio sup secret](#bio-sup-secret) | Commands relating to a Biome Supervisor's Control Gateway secret |
| [bio sup sh](#bio-sup-sh) | Start an interactive Bourne-like shell |
| [bio sup status](#bio-sup-status) | Query the status of Biome services |
| [bio sup term](#bio-sup-term) | Gracefully terminate the Biome Supervisor and all of its running services |
+++

### bio sup bash

Start an interactive Bash-like shell

**USAGE**

```
bio sup bash
```

**FLAGS**

```
-h, --help    Prints help information
```





+++

### bio sup depart

Depart a Supervisor from the gossip ring; kicking and banning the target from joining again with the same member-id

**USAGE**

```
bio sup depart [OPTIONS] <MEMBER_ID>
```

**FLAGS**

```
-h, --help    Prints help information
```

**OPTIONS**

```
-r, --remote-sup <REMOTE_SUP>    Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]
```

**ARGS**

```
<MEMBER_ID>    The member-id of the Supervisor to depart
```



+++

### bio sup run

Run the Biome Supervisor

**USAGE**

```
bio sup run [FLAGS] [OPTIONS] [--] [PKG_IDENT_OR_ARTIFACT]
```

**FLAGS**

```
-A, --auto-update          Enable automatic updates for the Supervisor itself
-D, --http-disable         Disable the HTTP Gateway completely
    --json-logging         Use structured JSON logging for the Supervisor. Implies NO_COLOR
    --local-gossip-mode    Start the supervisor in local mode
    --no-color             Turn ANSI color off
-I, --permanent-peer       If this Supervisor is a permanent peer
-v                         Verbose output; shows file and line/column numbers
-h, --help                 Prints help information
```

**OPTIONS**

```
--bind <BIND>... One or more service groups to bind to a configuration

    --binding-mode <BINDING_MODE> Governs how the presence or absence of binds affects service startup. strict blocks startup until all binds are present. [default: strict] [values: relaxed, strict]
-u, --url <BLDR_URL> Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined (default: https://bldr.habitat.sh)
    --cache-key-path <CACHE_KEY_PATH> Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
    --ca-certs <CA_CERT_FILE> Used for enabling client-authentication with TLS for the HTTP gateway. Read CA certificate from CA_CERT_FILE. This should contain PEM-format certificate that can be used to validate client requests
    --certs <CERT_FILE> Used for enabling TLS for the HTTP gateway. Read server certificates from CERT_FILE. This should contain PEM-format certificates in the right order (the first certificate should certify KEY_FILE, the last should be a root CA)
    --channel <CHANNEL> Receive Supervisor updates from the specified release channel [default: stable]

    --config-from <CONFIG_DIR> Use package config from this path, rather than the package itself

    --event-stream-application <EVENT_STREAM_APPLICATION> The name of the application for event stream purposes. This will be attached to all events generated by this Supervisor
    --event-stream-connect-timeout <EVENT_STREAM_CONNECT_TIMEOUT> How long in seconds to wait for an event stream connection before exiting the Supervisor. Set to '0' to immediately start the Supervisor and continue running regardless of the initial connection status [env: HAB_EVENT_STREAM_CONNECT_TIMEOUT=]  [default: 0]
    --event-stream-environment <EVENT_STREAM_ENVIRONMENT> The name of the environment for event stream purposes. This will be attached to all events generated by this Supervisor
    --event-meta <EVENT_STREAM_METADATA>... An arbitrary key-value pair to add to each event generated by this Supervisor

    --event-stream-server-certificate <EVENT_STREAM_SERVER_CERTIFICATE> The path to Cinc Automate's event stream certificate in PEM format used to establish a TLS connection

    --event-stream-site <EVENT_STREAM_SITE> The name of the site where this Supervisor is running for event stream purposes

    --event-stream-token <EVENT_STREAM_TOKEN> The authentication token for connecting the event stream to Cinc Automate [env: HAB_AUTOMATE_AUTH_TOKEN=]

    --event-stream-url <EVENT_STREAM_URL> The event stream connection string (host:port) used by this Supervisor to send events to Cinc Automate. This enables the event stream and requires --event-stream-application, --event-stream-environment, and --event- stream-token also be set
    --group <GROUP> The service group; shared config and topology [default: default]

-i, --health-check-interval <HEALTH_CHECK_INTERVAL> The interval (seconds) on which to run health checks [default: 30]

    --key <KEY_FILE> Used for enabling TLS for the HTTP gateway. Read private key from KEY_FILE. This should be a RSA private key or PKCS8-encoded private key, in PEM format
    --listen-ctl <LISTEN_CTL> The listen address for the Control Gateway. If not specified, the value will be taken from the HAB_LISTEN_CTL environment variable if defined [env: HAB_LISTEN_CTL=]  [default: 127.0.0.1:9632]
    --listen-gossip <LISTEN_GOSSIP> The listen address for the Gossip System Gateway [env: HAB_LISTEN_GOSSIP=]  [default: 0.0.0.0:9638]

    --listen-http <LISTEN_HTTP> The listen address for the HTTP Gateway [env: HAB_LISTEN_HTTP=]  [default: 0.0.0.0:9631]

    --org <ORGANIZATION> The organization that the Supervisor and its subsequent services are part of

    --peer <PEER>... The listen address of one or more initial peers (IP[:PORT])

    --peer-watch-file <PEER_WATCH_FILE> Watch this file for connecting to the ring

-r, --ring <RING> The name of the ring used by the Supervisor when running with wire encryption. (ex: bio sup run --ring myring) [env: HAB_RING=]
    --shutdown-timeout <SHUTDOWN_TIMEOUT> The number of seconds after sending a shutdown signal to wait before killing a service process (default: set in plan)
-s, --strategy <STRATEGY> The update strategy; [default: none] [values: none, at-once, rolling]

    --sys-ip-address <SYS_IP_ADDRESS> The IPv4 address to use as the sys.ip template variable. If this argument is not set, the supervisor tries to dynamically determine an IP address. If that fails, the supervisor defaults to using 127.0.0.1
-t, --topology <TOPOLOGY> Service topology; [default: none] [possible values: standalone, leader]
```

**ARGS**

```
<PKG_IDENT_OR_ARTIFACT>    Load the given Biome package as part of the Supervisor startup specified by a package identifier (ex: core/redis) or filepath to a Biome Artifact (ex: home/core-redis-3.0.7-21120102031201-x86_64-linux.hart)
```



+++

### bio sup secret

Commands relating to a Biome Supervisor's Control Gateway secret

**USAGE**

```
bio sup secret <SUBCOMMAND>
```

**FLAGS**

```
-h, --help    Prints help information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio sup secret generate](#bio-sup-secret-generate) | Generate a secret key to use as a Supervisor's Control Gateway secret |
+++

### bio sup secret generate

Generate a secret key to use as a Supervisor's Control Gateway secret

**USAGE**

```
bio sup secret generate
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```





+++

### bio sup sh

Start an interactive Bourne-like shell

**USAGE**

```
bio sup sh
```

**FLAGS**

```
-h, --help    Prints help information
```





+++

### bio sup status

Query the status of Biome services

**USAGE**

```
bio sup status [OPTIONS] [PKG_IDENT]
```

**FLAGS**

```
-h, --help    Prints help information
```

**OPTIONS**

```
-r, --remote-sup <REMOTE_SUP>    Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio sup term

Gracefully terminate the Biome Supervisor and all of its running services

**USAGE**

```
bio sup term [OPTIONS]
```

**FLAGS**

```
-h, --help    Prints help information
```





+++

## bio supportbundle

Create a tarball of Biome Supervisor data to send to support

**USAGE**

```
bio supportbundle
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```





+++

## bio svc

Commands relating to Biome services

**USAGE**

```
bio svc <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio svc key](#hab-svc-key) | Commands relating to Biome service keys |
| [bio svc load](#hab-svc-load) | Load a service to be started and supervised by Biome from a package identifier. If an installed package doesn't satisfy the given package identifier, a suitable package will be installed from Builder |
| [bio svc start](#hab-svc-start) | Start a loaded, but stopped, Biome service |
| [bio svc status](#hab-svc-status) | Query the status of Biome services |
| [bio svc stop](#hab-svc-stop) | Stop a running Biome service |
| [bio svc unload](#hab-svc-unload) | Unload a service loaded by the Biome Supervisor. If the service is running it will additionally be stopped |
+++

### bio svc key

Commands relating to Biome service keys

**USAGE**

```
bio svc key <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio svc key generate](#hab-svc-key-generate) | Generates a Biome service key |
+++

### bio svc key generate

Generates a Biome service key

**USAGE**

```
bio svc key generate <SERVICE_GROUP> --cache-key-path <CACHE_KEY_PATH> [ORG]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```

**ARGS**

```
<SERVICE_GROUP>    Target service group service.group[@organization] (ex: redis.default or foo.default@bazcorp)
<ORG>              The service organization
```



+++

### bio svc load

Load a service to be started and supervised by Biome from a package identifier. If an installed package doesn't

**USAGE**

```
bio svc load [FLAGS] [OPTIONS] <PKG_IDENT>
```

**FLAGS**

```
-f, --force      Load or reload an already loaded service. If the service was previously loaded and running this operation will also restart the service
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--bind <BIND>...                                   One or more service groups to bind to a configuration
    --binding-mode <BINDING_MODE> Governs how the presence or absence of binds affects service startup. strict blocks startup until all binds are present. [default: strict] [values: relaxed, strict]
-u, --url <BLDR_URL> Specify an alternate Builder endpoint. If not specified, the value will be taken from the HAB_BLDR_URL environment variable if defined. (default: https://bldr.habitat.sh)
    --channel <CHANNEL> Receive package updates from the specified release channel [default: stable]

    --group <GROUP> The service group; shared config and topology [default: default]

-i, --health-check-interval <HEALTH_CHECK_INTERVAL> The interval (seconds) on which to run health checks [default: 30]

-r, --remote-sup <REMOTE_SUP> Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]

    --shutdown-timeout <SHUTDOWN_TIMEOUT> The number of seconds after sending a shutdown signal to wait before killing a service process (default: set in plan)
-s, --strategy <STRATEGY> The update strategy; [default: none] [values: none, at-once, rolling]

-t, --topology <TOPOLOGY> Service topology; [default: none] [possible values: standalone, leader]
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio svc start

Start a loaded, but stopped, Biome service

**USAGE**

```
bio svc start [OPTIONS] <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-r, --remote-sup <REMOTE_SUP>    Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio svc status

Query the status of Biome services

**USAGE**

```
bio svc status [OPTIONS] [PKG_IDENT]
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-r, --remote-sup <REMOTE_SUP>    Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio svc stop

Stop a running Biome service

**USAGE**

```
bio svc stop [OPTIONS] <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-r, --remote-sup <REMOTE_SUP> Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]

    --shutdown-timeout <SHUTDOWN_TIMEOUT> The number of seconds after sending a shutdown signal to wait before killing a service process (default: set in plan)
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

### bio svc unload

Unload a service loaded by the Biome Supervisor. If the service is running it will additionally be stopped

**USAGE**

```
bio svc unload [OPTIONS] <PKG_IDENT>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
-r, --remote-sup <REMOTE_SUP> Address to a remote Supervisor's Control Gateway [default: 127.0.0.1:9632]

    --shutdown-timeout <SHUTDOWN_TIMEOUT> The number of seconds after sending a shutdown signal to wait before killing a service process (default: set in plan)
```

**ARGS**

```
<PKG_IDENT>    A package identifier (ex: core/redis, core/busybox-static/1.42.2)
```



+++

## bio user

Commands relating to Biome users

**USAGE**

```
bio user <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio user key](#bio-user-key) | Commands relating to Biome user keys |
+++

### bio user key

Commands relating to Biome user keys

**USAGE**

```
bio user key <SUBCOMMAND>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```




**SUBCOMMANDS**

| Command | Description |
| ++++++- | +++++++++-- |
| [bio user key generate](#bio-user-key-generate) | Generates a Biome user key |
+++

### bio user key generate

Generates a Biome user key

**USAGE**

```
bio user key generate <USER> --cache-key-path <CACHE_KEY_PATH>
```

**FLAGS**

```
-h, --help       Prints help information
-V, --version    Prints version information
```

**OPTIONS**

```
--cache-key-path <CACHE_KEY_PATH>    Cache for creating and searching encryption keys. Default value is hab/cache/keys if root and .hab/cache/keys under the home directory otherwise [env: HAB_CACHE_KEY_PATH=]
```

**ARGS**

```
<USER>    Name of the user key
```



+++

