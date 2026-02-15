# kaiba-network

This project defines the software components used to host https://kaiba.network.  Components are defined as [NixOS Modules](https://nixos.wiki/wiki/NixOS_modules), then collected into a [NixFlake](https://wiki.nixos.org/wiki/Flakes) for deployment on 

## Services

### Matrix

[Matrix](https://matrix.org/) is a [specification](https://spec.matrix.org/latest/#) for secure, open-network communications.  As the trusted host for [kaiba.network], this project fulfils the "homeserver" role in Matrix's [Client-Server API](https://spec.matrix.org/v1.17/client-server-api/) and [Server-Server API](https://spec.matrix.org/v1.17/server-server-api/).  See the [Architecture](https://spec.matrix.org/latest/#architecture) for finer details. 

In this initial phase, `kaiba.network` will host a single homeserver.  The goal of this project is to scale into deploying secure, "plug-and-play"-style hardware deployments of federated homeserver instances.

#### Synapse Server

We will be deploying [Synapse](https://github.com/element-hq/synapse), an open-source implementation of the Matrix "homeserver" role.  

