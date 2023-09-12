FROM debian:12
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

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
    bind9-utils \
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
    hping3 \
    ieee-data \
    ifupdown \
    iperf3 \
    iptables \
    iputils-ping \
    iputils-tracepath \
    less \
    libdublintraceroute-dev \
    libjsoncpp-dev \
    libpcap-dev \
    libtins-dev \
    links \
    lsb-base \
    lsb-release \
    make \
    man-db \
    mrt \
    nano \
    ndisc6 \
    net-tools \
    netbase \
    netcat-openbsd \
    openssh-client \
    openssh-server \
    openssh-sftp-server \
    openssl \
    pkg-config \
    python3-dev \
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
    wget \
    vim

WORKDIR /tmp

RUN FILE_NAME=`wget -q -O - https://mirrors.edge.kernel.org/pub/linux/utils/net/iproute2/ | \
        tac | \
        grep -m 1 -o "iproute2-6[\.0-9]*[0-9]" | \
        head -n 1` && \
    wget -q https://mirrors.edge.kernel.org/pub/linux/utils/net/iproute2/$FILE_NAME.tar.xz && \
    tar xf $FILE_NAME.tar.xz && \
    cd $FILE_NAME && \
    ./configure && \
    make -j$(nproc --ignore=4) && \
    make install && \
    cd .. && \
    rm -r $FILE_NAME && \
    rm $FILE_NAME.tar.xz

RUN python3 -m pip install --no-cache-dir --upgrade --break-system-packages pip && \
    python3 -m pip install --no-cache-dir --break-system-packages scapy dublintraceroute tabulate

RUN ln -s /etc/init.d/named /etc/init.d/bind

RUN wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py -O /usr/local/bin/systemctl && \
    chmod +x /usr/local/bin/systemctl

COPY .bashrc /root/.bashrc

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /

VOLUME /hosthome
VOLUME /shared
