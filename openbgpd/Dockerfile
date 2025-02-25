FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update && \
	apt install -y --no-install-recommends \
	openbgpd && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*