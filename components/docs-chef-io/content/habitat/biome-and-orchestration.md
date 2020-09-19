+++
title = "Biome and Container Orchestration"
description = "Biome and Container Orchestration"

[menu]
  [menu.bioitat]
    title = "Biome and Container Orchestration"
    identifier = "habitat/containers/biome-and-orchestration"
    parent = "habitat/containers"

+++

**Example: [Kubernetes](https://kubernetes.io/)**

Kubernetes is a portable, extensible open-source platform for managing containerized workloads and services that has declarative configuration and automation. Applications are run within Docker containers, grouped into pods. Kubernetes provides the control plane and API layer to schedule those pods.

Biome is not a scheduling tool, and does not schedule container resources such as replicas, deployments, firewalls, networking, geo-location (affinity), etc. Instead, Biome's responsibility is the service running inside the container. The [Biome Supervisor](https://www.habitat.sh/docs/using-habitat/#overview) provides topologies, application binding, ring encryption, and dynamic configuration and other features not present in Kubernetes.

Since Biome and Kubernetes are both able to manage services, using the [Biome Operator](https://www.habitat.sh/get-started/kubernetes/) with Kubernetes empowers users to use Biome's runtime features by operating in a Kubernetes native way. Where Biome and Kubernetes overlap, the Biome Operator defers control to Kubernetes.

