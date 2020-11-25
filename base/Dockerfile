FROM debian:9

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
    ethtool \
    expect \
    flex \
    geoip-database \
    git \
    gnupg \
    ieee-data \
    ifupdown \
    iptables \
    iputils-ping \
    iputils-tracepath \
    less \
    links \
    lsb-base \
    lsb-release \
    make \
    manpages \
    nano \
    net-tools \
    netbase \
    openssh-client \
    openssh-server \
    openssh-sftp-server \
    openssl \
    paris-traceroute \
    pkg-config \
    rsync \
    screen \
    sed \
    tar \
    tcpdump \
    telnet \
    traceroute \
    wget \
    vim

RUN echo "deb http://httpredir.debian.org/debian testing main" | tee /etc/apt/sources.list.d/debian-unstable.list && apt update && DEBIAN_FRONTEND=noninteractive apt install -y dublin-traceroute -t testing && rm /etc/apt/sources.list.d/debian-unstable.list && apt update

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN ln -s /etc/init.d/bind9 /etc/init.d/bind

COPY .bashrc /root/.bashrc

WORKDIR /tmp

RUN FILE_NAME=`wget -q -O - https://mirrors.edge.kernel.org/pub/linux/utils/net/iproute2/ | \
        tac | \
        grep -m 1 -o "iproute2-5[\.0-9]*[0-9]" | \
        head -n 1` && \
    wget -q https://mirrors.edge.kernel.org/pub/linux/utils/net/iproute2/$FILE_NAME.tar.xz && \
    tar xf $FILE_NAME.tar.xz && \
    cd $FILE_NAME && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -r $FILE_NAME && \
    rm $FILE_NAME.tar.xz

WORKDIR /

VOLUME /hosthome
VOLUME /shared
