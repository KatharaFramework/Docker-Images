FROM kathara/core:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update && \
	apt upgrade -y && \
	apt install -y --no-install-recommends \
	dnsmasq && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
