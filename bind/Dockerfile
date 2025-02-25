FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update && \
	apt upgrade -y && \
	apt install -y --no-install-recommends \
	bind9 \
	bind9-utils && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN ln -s /etc/init.d/named /etc/init.d/bind