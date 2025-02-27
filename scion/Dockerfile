FROM kathara/base
LABEL org.opencontainers.image.authors="Network Security Group, ETH Zurich <netsec.ethz.ch>"

# Install SCION from GitHub release
ARG DEBIAN_FRONTEND="noninteractive"
ARG TARGETARCH

WORKDIR /tmp

RUN wget https://github.com/scionproto/scion/releases/download/v0.12.0/scion_0.12.0_deb_$TARGETARCH.tar.gz && \
    tar xfz scion_0.12.0_deb_$TARGETARCH.tar.gz && \
    apt install ./scion*.deb && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# Strip templating from systemd service files, systemd-replacement-script does not support it
RUN mv /usr/lib/systemd/system/scion-router\@.service /usr/lib/systemd/system/scion-router.service && \
    sed -i 's/%i/br/g' /usr/lib/systemd/system/scion-router.service && \
    mv /usr/lib/systemd/system/scion-control\@.service /usr/lib/systemd/system/scion-control.service && \
    sed -i 's/%i/cs/g' /usr/lib/systemd/system/scion-control.service

# Adjust scion-ip-gateway.service for compatibility with docker environment
RUN sed -i 's/^User=scion/User=root/' /usr/lib/systemd/system/scion-ip-gateway.service && \
    sed -i 's/^Group=scion/Group=root/' /usr/lib/systemd/system/scion-ip-gateway.service && \
    sed -i '/^AmbientCapabilities=cap_net_admin/d' /usr/lib/systemd/system/scion-ip-gateway.service && \
    sed -i '/^\[Service\]/a ExecStartPre=\/bin\/bash -c '"'"'mkdir -p /dev/net; mknod /dev/net/tun c 10 200; chmod 600 /dev/net/tun'"'"'' /usr/lib/systemd/system/scion-ip-gateway.service

WORKDIR /
