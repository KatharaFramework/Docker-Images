FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update && \
	apt install -y --no-install-recommends \
	rpki-client \
	stayrtr \
	cron && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN sed -i -e 's/Type=exec/Type=simple/' /lib/systemd/system/stayrtr.service