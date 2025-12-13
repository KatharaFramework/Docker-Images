# Stage to build latest iproute release
FROM debian:12 AS iproute

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
	apt install -y --no-install-recommends \
	bison \
	build-essential \
	ca-certificates \
	flex \
	git \
	libbpf-dev \
	libcap-dev \
	libmnl-dev \
	pkg-config

WORKDIR /tmp

RUN	mkdir output && \
	git clone https://git.kernel.org/pub/scm/network/iproute2/iproute2.git && \
	cd iproute2 && \
	git checkout tags/$(git describe --tags --abbrev=0) && \
	./configure && \
	make -j$(nproc) && \
	DESTDIR=/tmp/output make install

# Build the final image
FROM debian:12
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

COPY .bashrc /root/.bashrc

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
	apt upgrade -y && \
	apt install -y --no-install-recommends \
	apt-utils \
	apt-transport-https \
	arping \
	bridge-utils \
	curl \
	diffutils \
	dnsutils \
	dublin-traceroute \
	ethtool \
	expect \
	git \
	gnupg \
	hping3 \
	iperf3 \
	iptables \
	iputils-ping \
	iputils-tracepath \
	less \
	libbpf1 \
	libelf1 \
	links \
	lsb-base \
	lsb-release \
	make \
	man-db \
	mtr-tiny \
	nano \
	ndisc6 \
	net-tools \
	netbase \
	netcat-openbsd \
	openssh-client \
	openssl \
	procps \
	python3-pip \
	radvd \
	rsync \
	screen \
	sed \
	systemd-userdbd \
	tar \
	tcpdump \
	telnet \
	tmux \
	traceroute \
	tree \
	wget && \
	apt-cache show iproute2 | dpkg --merge-avail && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py /usr/local/bin/systemctl

RUN	chmod +x /usr/local/bin/systemctl

COPY --from=iproute /tmp/output/sbin /sbin
COPY --from=iproute /tmp/output/usr /usr

# Manually flagging iproute2 as installed in the dpkg database so that it is not overwritten by the apt version
RUN echo "iproute2 install" | dpkg --set-selections && \
	sed -i "/^Package: iproute2$/,/^$/ s/Status: install ok not-installed/Status: install ok installed\nVersion: $(ip -V | cut -d ',' -f2 | cut -d '-' -f 2)/" /var/lib/dpkg/status

RUN python3 -m pip install --no-cache-dir --upgrade --break-system-packages pip && \
	python3 -m pip install --no-cache-dir --break-system-packages scapy tabulate

RUN mkdir /var/kathara

WORKDIR /

VOLUME /hosthome
VOLUME /shared