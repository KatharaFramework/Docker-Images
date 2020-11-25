FROM kathara/base

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y
RUN apt install -y \
	python3-pip \
	gcc \
	python3-dev \
	libffi-dev \
	libssl-dev \
	libxml2-dev \
	libxslt1-dev \
	zlib1g-dev

RUN wget -O openvswitch-common.deb http://ftp.it.debian.org/debian/pool/main/o/openvswitch/openvswitch-common_2.10.0+2018.08.28+git.8ca7c82b7d+ds1-12+deb10u2_amd64.deb && \
    apt install -y ./openvswitch-common.deb && \
    rm openvswitch-common.deb
    
RUN wget -O openvswitch-switch.deb http://ftp.it.debian.org/debian/pool/main/o/openvswitch/openvswitch-switch_2.10.0+2018.08.28+git.8ca7c82b7d+ds1-12+deb10u2_amd64.deb && \
    apt install -y ./openvswitch-switch.deb && \
    rm openvswitch-switch.deb

RUN python3 -m pip install --no-cache-dir ryu

RUN /usr/bin/ovsdb-tool create /etc/openvswitch/conf.db
RUN mkdir -pv /var/run/openvswitch/

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
