FROM kathara/base:debian10

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
	python3-dev \
	python3-pip \
	zlib1g-dev

RUN python3 -m pip install --no-cache-dir ryu

RUN /usr/bin/ovsdb-tool create /etc/openvswitch/conf.db
RUN mkdir -pv /var/run/openvswitch/

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
