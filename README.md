# Docker Images

This repository contains `Dockerfile`s used to build Kathara images.

Currently available images are:
- kathara/base: used to build all other images. It contains a variety of network tools and some complex services like bind, apache, etc.
- kathara/quagga: extends the base image adding the [Quagga routing daemon](https://www.nongnu.org/quagga/).
- kathara/frr: extends the base image adding [FRRouting](https://frrouting.org/).
- kathara/sdn: extends the base image adding [OpenVSwitch](https://www.openvswitch.org/) and [Ryu SDN controller](https://osrg.github.io/ryu/).

## Building from source
To build an image from source please run `make <image_name>`.

Example: `make quagga`
