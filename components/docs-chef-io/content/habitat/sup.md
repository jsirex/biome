+++
title = "Biome Supervisor"

aliases = ["/habitat/best-practices/"]

date = 2020-10-26T18:47:18-07:00
draft = false

[menu]
  [menu.biome]
    title = "About Supervisors"
    identifier = "habitat/supervisors/sup Supervisors"
    parent = "habitat/supervisors"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/sup.md)

The Supervisor is a process manager that has two primary responsibilities. First, it starts and monitors child services defined in the plan it is running. Second, it receives and acts upon information from the other Supervisors to which it is connected. A service will be reconfigured through application lifecycle hooks if its configuration has changed.

## The Supervisor Ring

Supervisors typically run in a network, which we refer to as a *ring* (although it is more like a peer-to-peer network rather than a circular ring). The ring can be very large; it could contain hundreds or thousands of supervisors. The membership list of this ring is maintained independently by each Supervisor and is known as the *census*.

## Census

The census is the core of the service discovery mechanism in Biome. It keeps track of every Supervisor in the ring, and handles reading, writing, and serializing it with the discovery backend.

Each Supervisor in the system is a *census entry* that together form a *census*. Operations to discover or mutate the state of the census happen through algorithms that arrive at the same conclusion given the same inputs.

An example is leader election: it's handled here by having a consistent (and simple) algorithm for selecting a leader deterministically for the group. We rely on the eventual consistency of every Supervisor's census entry to elect a new leader in a reasonable amount of time.

## Supervisor REST API

The Biome Supervisor provides a HTTP API to expose cluster metadata, statistics, and general diagnostic information useful for monitoring and support in the form of a JSON document. It also provides detailed information about the Biome package that it is supervising, including metadata such as the build and runtime dependencies and their versions.

## Control Gateway

The Supervisor control gateway is used to issue commands to a remote Supervisor. When a new Supervisor is created, a key for the `HAB_CTL_SECRET` environment variable is generated for it by default, if one is not already present; this key is used to authenticate requests that are made via the control gateway.
See the [control gateway]({{< relref "keys#control-gateway" >}}) documentation for more details.
