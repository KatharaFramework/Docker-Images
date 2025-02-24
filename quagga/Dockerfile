FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN echo "deb http://deb.debian.org/debian buster main" | tee /etc/apt/sources.list.d/buster.list

RUN apt update && \
	apt install  -y --no-install-recommends \
	quagga && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

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

RUN echo "kathara/quagga image (this image) is deprecated. It will not be updated in the future." > /var/kathara/quagga_deprecated