# Docker Images

This repository contains `Dockerfile`s used to build Kathará images. A list of the Docker images we provide can be found at [this page](https://hub.docker.com/u/kathara/) in the Docker Hub.
Images are built both with `docker build` and with `docker buildx` for multi-architecture support.
Currently our `latest` images are based on Debian 12 and are compiled for `amd64` and `arm64`.
If you need images based on other Linux distributions, feel free to create a PR with other Dockerfiles.

Currently available images are:
- `kathara/common`: used to build all other images. It contains a variety of commonly used network tools.
    - Available tags: `kathara/common:10` (Debian 10) and `kathara/common:12` (Debian 12).
- `kathara/apache`: extends the common image by adding the [Apache](https://httpd.apache.org) webserver.
    - Available tags: `kathara/apache:latest` (Debian 12).
- `kathara/bind`: extends the common image by adding the [BIND9](https://bind9.net) DNS daemon.
    - Available tags: `kathara/bind:9.11` (Debian 10 & BIND9 v9.11) and `kathara/bind:latest` (Debian 12 & latest BIND9).
- `kathara/base`: extends the common image by adding BIND9 and Apache.
    - Available tags: `kathara/base:latest` (Debian 12 & latest BIND9).
- `kathara/quagga`: extends the base image adding [Quagga](https://www.nongnu.org/quagga/).
    - Available tags: `kathara/quagga:latest` (Debian 12).
- `kathara/frr`: extends the base image adding [FRRouting](https://frrouting.org/).
    - Available tags: `kathara/frr:7` (Debian 10 & FRR 7), `kathara/frr:8` (Debian 12 & FRR 8), `kathara/frr:9` (Debian 12 & FRR 9), `kathara/frr:latest` (Debian 12 & FRR 10).
- `kathara/openbgpd`: extend the base image adding the [OpenBGPD daemon](https://www.openbgpd.org/).
    - Available tags: `kathara/openbgpd:latest` (Debian 12).
- `kathara/krill`: extends the base image adding [Krill RPKI Certificate Authority](https://www.nlnetlabs.nl/projects/rpki/krill/).
    - Available tags: `kathara/krill:latest` (Debian 12).
- `kathara/routinator`: extends the base image adding [Routinator RPKI Relying Party](https://www.nlnetlabs.nl/projects/rpki/routinator/).
    - Available tags: `kathara/routinator:latest` (Debian 12).
- `kathara/rpki-client`: extends the base image adding [OpenBGPD RPKI Client](https://www.rpki-client.org).
    - Available tags: `kathara/rpki-client:latest` (Debian 12).
- `kathara/bird`: extends the base image adding [BIRD](https://bird.network.cz/).
    - Available tags: `kathara/bird:latest` (Debian 12).
- `kathara/rift-python`: extends the base image adding [Routing In Fat Trees (RIFT) Python Implementation](https://github.com/brunorijsman/rift-python).
    - Available tags: `kathara/rift-python:latest` (Debian 12).
- `kathara/openvswitch`: extends the base image adding [OpenVSwitch](https://www.openvswitch.org/) and [Ryu SDN controller](https://osrg.github.io/ryu/).
    - Available tags: `kathara/openvswitch:latest` (Debian 12).
- `kathara/pox`: extends the base image adding [POX](https://github.com/noxrepo/pox) (Python based SDN Controller) and `python3-networkx`.
    - Available tags: `kathara/pox:latest` (Debian 12).
- `kathara/bmv2`: extends the base image adding [Behavioral Model (bmv2)](https://github.com/p4lang/behavioral-model) to compile and run P4-compliant programmable switches.
    - Available tags: `kathara/bmv2:latest` (Debian 12).

## Building from source
To build an image from source, run `make build_<image_name>` to build for the current architecture. `<image_name>` is one of the folders of the repository.
To build an image with `docker buildx` for multi-architectures use the command `make build_multi_<image_name>`.
**Beware**: building images with `docker buildx` automatically push the images on the Kathará Docker Hub. If you are not allowed to push, change the `Makefile` before running `make`.

Example: `make build_quagga` or `make build_multi_quagga`.

## Extend Kathará Images

The easiest way to extend a Kathará image is to clone this repository, change the Dockerfile according to your needings and locally build the new image.

If you instead want to alter (locally) an existing Kathará image, refer to the following steps:
1. `docker pull kathara/<image_name>`
2. `docker run -tid --name <container_name> kathara/<image_name>`
3. `docker exec -ti <container_name> bash`
4. Do your thing, then exit.
5. `docker commit <container_name> kathara/<image_new_name>`
6. `docker rm -f <container_name>`
