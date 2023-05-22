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

COPY 0002-lib-prefix.h-fix-build-with-gcc-10.patch /

RUN git clone https://github.com/Quagga/quagga && \
    cd quagga && ./bootstrap.sh && \
    mv ../0002-lib-prefix.h-fix-build-with-gcc-10.patch . && \
    git apply 0002-lib-prefix.h-fix-build-with-gcc-10.patch && \
    ./configure --enable-user=quagga --enable-group=quagga --enable-vty-group=quagga --prefix=/usr --sysconfdir=/etc/quagga -localstatedir=/var/state/quagga CFLAGS="-fcommon" && \
    make -j$(nproc --ignore=4) && make install && ldconfig && \
    cd .. && rm -Rf quagga/ && \
    useradd -M quagga && usermod -L quagga

RUN apt remove -y autoconf gawk texinfo && apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN mkdir /var/log/quagga
RUN chmod -R 777 /var/log/quagga
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

RUN mkdir -p /var/state/quagga
RUN chown quagga:quagga /var/state/quagga