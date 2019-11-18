FROM debian:9

RUN apt update
RUN apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y \
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
    dublin-traceroute \
    ethtool \
    expect \
    flex \
    geoip-database \
    git \
    gnupg \
    ieee-data \
    ifupdown \
    inetutils-traceroute \
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
    wget \
    vim

RUN apt clean

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
