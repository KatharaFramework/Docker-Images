FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y
RUN apt install -y \
    autoconf \
    gawk \
    libc-ares-dev \
    libreadline-dev \
    libtool \
    texinfo

RUN wget -q https://github.com/Quagga/quagga/releases/download/quagga-1.2.4/quagga-1.2.4.tar.gz && \
    tar xfvz quagga-1.2.4.tar.gz && \
    cd quagga-1.2.4 && \
    ./configure CFLAGS="-fcommon" \
                --enable-user=quagga \
                --enable-group=quagga \
                --enable-vty-group=quaggavty \
                --prefix=/usr \
                --sysconfdir=/etc/quagga \
                --localstatedir=/var/state/quagga && \
    make -j$(nproc --ignore=4) && make install && ldconfig && \
    cd .. && rm -Rf quagga-1.2.4*

RUN addgroup --system quaggavty > /dev/null && \
    addgroup --system quagga > /dev/null && \
    adduser --system --ingroup quagga --home /var/state/quagga --gecos "Quagga routing suite" --shell /bin/false quagga > /dev/null && \
    usermod -aG quaggavty quagga && \
    install -m 755 -o quagga -g quagga -d /var/log/quagga && \
    install -m 755 -o quagga -g quagga -d /var/state/quagga && \
    install -m 775 -o quagga -g quaggavty -d /etc/quagga && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/zebra.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/bgpd.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/ospfd.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/ospf6d.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/isisd.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/ripd.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/ripngd.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/pimd.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/ldpd.conf && \
    install -m 640 -o quagga -g quagga /dev/null /etc/quagga/nhrpd.conf && \
    install -m 640 -o quagga -g quaggavty /dev/null /etc/quagga/vtysh.conf

RUN ln -s /var/log/quagga /var/log/zebra
RUN ln -s /etc/quagga /etc/zebra

COPY zebra.conf /etc/quagga/zebra.conf
RUN chown quagga:quagga /etc/quagga/zebra.conf
RUN chmod 640 /etc/quagga/zebra.conf

COPY debian.conf /etc/quagga/debian.conf
RUN chown quagga:quagga /etc/quagga/debian.conf
RUN chmod 640 /etc/quagga/debian.conf

COPY quagga /etc/init.d/quagga
RUN chown root:root /etc/init.d/quagga
RUN chmod 0755 /etc/init.d/quagga
RUN ln -s /etc/init.d/quagga /etc/init.d/zebra

RUN apt remove -y autoconf gawk texinfo && apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*