FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update && \
	apt upgrade -y && \
	apt install -y --no-install-recommends \
	apache2 \
	apache2-bin && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
