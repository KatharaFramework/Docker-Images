FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y
RUN apt install -y \
	gcc \
	libffi-dev \
	libssl-dev \
	libxml2-dev \
	libxslt1-dev \
	openvswitch-common \
	openvswitch-switch \
	zlib1g-dev

RUN python3 -m pip install --no-cache-dir --break-system-packages eventlet==0.30.2
RUN python3 -m pip install --no-cache-dir --break-system-packages ryu

RUN /usr/bin/ovsdb-tool create /etc/openvswitch/conf.db
RUN mkdir -pv /var/run/openvswitch/

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
