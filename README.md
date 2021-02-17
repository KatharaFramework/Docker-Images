# Docker Images

This repository contains `Dockerfile`s used to build Kathara images. A list of the Docker images we provided can be found at [this page](https://hub.docker.com/u/kathara/) in the Docker Hub.
Currently our images are based on debian9 and debian10. If you need images based on other Linux distributions, feel free to create a PR with other Dockerfiles.

Currently available images are:
- kathara/base: used to build all other images. It contains a variety of network tools and some complex services like bind, apache, etc.
- kathara/quagga: extends the base image adding the [Quagga routing daemon](https://www.nongnu.org/quagga/).
- kathara/frr: extends the base image adding [FRRouting](https://frrouting.org/).
- kathara/sdn: extends the base image adding [OpenVSwitch](https://www.openvswitch.org/) and [Ryu SDN controller](https://osrg.github.io/ryu/).

## Building from source
To build an image from source, enter the directory according to your preferred base image and run `make <image_name>`.

Example: `make quagga`

## Extend Kathará Images

The easiest way to extend a Kathará image is to clone this repository, change the Dockerfile according to your needings and locally build the new image.

If you instead prefer to alter (locally) an existing Kathará image refer to the following steps (remember that, by default, Docker needs root or sudo on Linux).
1. `docker pull kathara/<image_name>`
2. `docker run -tid --name <image_new_name> kathara/<image_name>`
3. `docker exec -ti  <image_new_name> bash`
4. Do your thing, then exit.
5. `docker commit <image_new_name> kathara/<image_new_name>`
6. `docker rm -f <image_new_name>`
