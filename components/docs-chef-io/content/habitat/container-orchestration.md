+++
title = "Container Orchestration"
description = "Container Orchestration with Biome"

[menu]
  [menu.bioitat]
    title = "Container Orchestration"
    identifier = "habitat/containers/container-orchestration"
    parent = "habitat/containers"

+++

Biome packages may be exported with the Supervisor directly into a [a variety of container formats](/docs/plan-overview/#pkg-exports), but frequently the container is running in a container orchestrator such as Kubernetes or Mesos. Container orchestrators provide scheduling and resource allocation, ensuring workloads are running and available. Containerized Biome packages can run within these runtimes, managing the applications while the runtimes handle the environment surrounding the application (ie. compute, networking, security).
