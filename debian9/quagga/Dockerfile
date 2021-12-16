FROM kathara/base:debian9

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y

RUN wget -O quagga.deb http://snapshot.debian.org/archive/debian/20161019T045440Z/pool/main/q/quagga/quagga_1.0.20160315-3_$(dpkg --print-architecture).deb

