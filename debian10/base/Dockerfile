FROM debian:10

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y
RUN apt install -y \
    apache2 \
    apache2-bin \
    apt-utils \
    apt-transport-https \ 
    arping \
    arptables \
    bind9 \
    bison \
    bridge-utils \
    build-essential \
    curl \
    diffutils \
    dnsutils \
    dublin-traceroute  \
    ethtool \
    expect \
    flex \
    geoip-database \
    git \
    gnupg \
    ieee-data \
    ifupdown \
    iptables \
    iproute2 \
    iputils-ping \
    iputils-tracepath \
    less \
    links \
    lsb-base \
    lsb-release \
    make \
    man-db \
    nano \
    net-tools \
    netbase \
    netcat \
    openssh-client \
    openssh-server \
    openssh-sftp-server \
    openssl \
    paris-traceroute \
    pkg-config \
    python3-scapy \
    rsync \
    screen \
    sed \
    tar \
    tcpdump \
    telnet \
    traceroute \
    wget \
    vim


RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN ln -s /etc/init.d/bind9 /etc/init.d/bind

COPY .bashrc /root/.bashrc

WORKDIR /

VOLUME /hosthome
VOLUME /shared
