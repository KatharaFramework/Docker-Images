FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update && \
	apt install  -y --no-install-recommends \
	openvswitch-common \
	openvswitch-switch && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN /usr/bin/ovsdb-tool create /etc/openvswitch/conf.db
RUN mkdir -pv /var/run/openvswitch/

RUN ln -s /bin/true /usr/local/sbin/modprobe

ENV OVS_SBINDIR="/usr/local/sbin"
