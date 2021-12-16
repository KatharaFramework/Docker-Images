# Docker Images

This repository contains `Dockerfile`s used to build Kathará images. A list of the Docker images we provided can be found at [this page](https://hub.docker.com/u/kathara/) in the Docker Hub.
Images are built both with `docker build` and with `docker buildx` for multi-architecture support.
Currently our images are based on Debian 9 (tag `debian9`) and Debian 10 (tag `debian10`) and are compiled for `amd64` and `arm64`. `latest` tag is a retag of `debian10`.
If you need images based on other Linux distributions, feel free to create a PR with other Dockerfiles.

Currently available images are:
- `kathara/base`: used to build all other images. It contains a variety of network tools and some complex services like bind, apache, etc.
- `kathara/quagga`: extends the base image adding the [Quagga routing daemon](https://www.nongnu.org/quagga/).
- `kathara/frr`: extends the base image adding [FRRouting](https://frrouting.org/).
- `kathara/sdn`: extends the base image adding [OpenVSwitch](https://www.openvswitch.org/) and [Ryu SDN controller](https://osrg.github.io/ryu/).
- `kathara/p4`: extends the base image adding [Behavioral Model (bmv2)](https://github.com/p4lang/behavioral-model) to compile P4 code.

## Building from source
To build an image from source, enter the directory according to the desired Debian version and run `make <image_name>` to build for the current architecture.
To build an image with `docker buildx` for multi-architectures use the command `make <image_name>-multi`.
**Beware**: building images with `docker buildx` automatically push the images on the Kathará Docker Hub. If you are not allowed to push, change the `Makefile` before running `make`.

Example: `make quagga` or `make quagga-multi`.

## Extend Kathará Images

The easiest way to extend a Kathará image is to clone this repository, change the Dockerfile according to your needings and locally build the new image.

If you instead want to alter (locally) an existing Kathará image, refer to the following steps:
1. `docker pull kathara/<image_name>`
2. `docker run -tid --name <container_name> kathara/<image_name>`
3. `docker exec -ti <container_name> bash`
4. Do your thing, then exit.
5. `docker commit <container_name> kathara/<image_new_name>`
6. `docker rm -f <container_name>`
