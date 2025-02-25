# Docker Images

This repository contains `Dockerfile`s used to build Kathará images. A list of the Docker images we provide can be found at [this page](https://hub.docker.com/u/kathara/) in the Docker Hub.
Images are built both with `docker build` and with `docker buildx` for multi-architecture support.
Currently our `latest` images are based on Debian 12 and are compiled for `amd64` and `arm64`.
If you need images based on other Linux distributions, feel free to create a PR with other Dockerfiles.

Currently available images are:
- `kathara/common`: used to build all other images. It contains a variety of commonly used network tools.
    - Available tags: `kathara/common:latest`.
- `kathara/apache`: extends the common image by adding the [Apache](https://httpd.apache.org) webserver.
    - Available tags: `kathara/apache:latest`.
- `kathara/bind`: extends the common image by adding the [BIND9](https://bind9.net) DNS daemon.
    - Available tags: `kathara/bind:9.11.37` (v9.11.37) and `kathara/bind:latest`.
- `kathara/base`: extends the common image by adding BIND9 and Apache.
    - Available tags: `kathara/base:latest`.
- `kathara/bird`: extends the base image adding [BIRD](https://bird.network.cz/).
    - Available tags: `kathara/bird:latest` (v1.6.8).
- `kathara/bird2`: extends the base image adding [BIRD 2](https://bird.network.cz/).
    - Available tags: `kathara/bird2:2.0.8` (v2.0.8) and `kathara/bird2:latest`.
- `kathara/bird3`: extends the base image adding [BIRD 3](https://bird.network.cz/).
    - Available tags: `kathara/bird3:latest`.
- `kathara/bmv2`: extends the base image adding [Behavioral Model (bmv2)](https://github.com/p4lang/behavioral-model) to compile and run P4-compliant programmable switches.
    - Available tags: `kathara/bmv2:latest` (also retagged as `kathara/p4:latest`).
- `kathara/frr`: extends the base image adding [FRRouting](https://frrouting.org/).
    - Available tags: `kathara/frr:9`, `kathara/frr:10`, and `kathara/frr:latest`.
- `kathara/krill`: extends the base image adding [Krill RPKI Certificate Authority](https://www.nlnetlabs.nl/projects/rpki/krill/).
    - Available tags: `kathara/krill:latest`.
- `kathara/openbgpd`: extend the base image adding the [OpenBGPD daemon](https://www.openbgpd.org/).
    - Available tags: `kathara/openbgpd:latest`.
- `kathara/openvswitch`: extends the base image adding [OpenVSwitch](https://www.openvswitch.org/).
    - Available tags: `kathara/openvswitch:latest` (also retagged as `kathara/sdn:latest`).
- `kathara/pox`: extends the base image adding [POX](https://github.com/noxrepo/pox) (Python based SDN Controller) and `python3-networkx`.
    - Available tags: `kathara/pox:latest`.
- `kathara/quagga`: extends the base image adding [Quagga](https://www.nongnu.org/quagga/).
    - Available tags: `kathara/quagga:latest`.
- `kathara/rift-python`: extends the base image adding [Routing In Fat Trees (RIFT) Python Implementation](https://github.com/brunorijsman/rift-python).
    - Available tags: `kathara/rift-python:latest`.
- `kathara/routinator`: extends the base image adding [Routinator RPKI Relying Party](https://www.nlnetlabs.nl/projects/rpki/routinator/).
    - Available tags: `kathara/routinator:latest`.
- `kathara/rpki-client`: extends the base image adding [OpenBGPD RPKI Client](https://www.rpki-client.org).
    - Available tags: `kathara/rpki-client:latest`.
- `kathara/scion`: extends the base image adding [SCION](https://scion-architecture.net) (Scalability, Control, and Isolation On Next-Generation Networks).
    - Available tags: `kathara/scion:0.12.0` (v0.12.0) and `kathara/scion:latest`.

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
