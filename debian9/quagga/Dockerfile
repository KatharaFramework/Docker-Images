FROM kathara/base

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y

RUN wget http://snapshot.debian.org/archive/debian/20161019T045440Z/pool/main/q/quagga/quagga_1.0.20160315-3_amd64.deb

RUN dpkg -i quagga_1.0.20160315-3_amd64.deb || true

RUN apt install -y \
	cron \
	logrotate

RUN dpkg -i quagga_1.0.20160315-3_amd64.deb

RUN apt-mark hold quagga

RUN rm quagga_1.0.20160315-3_amd64.deb

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN mkdir /var/log/zebra
RUN chmod -R 777 /var/log/quagga
RUN chmod -R 777 /var/log/zebra
RUN ln /etc/init.d/quagga /etc/init.d/zebra
RUN ln -s /etc/quagga /etc/zebra

COPY zebra.conf /etc/quagga/zebra.conf
RUN chown quagga:quagga /etc/quagga/zebra.conf
RUN chmod 640 /etc/quagga/zebra.conf
