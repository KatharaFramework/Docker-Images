FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN curl -fsSL https://packages.nlnetlabs.nl/aptkey.asc | gpg --dearmor -o /usr/share/keyrings/nlnetlabs-archive-keyring.gpg && \
	echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/nlnetlabs-archive-keyring.gpg] https://packages.nlnetlabs.nl/linux/debian \
	$(lsb_release -cs) main" | tee /etc/apt/sources.list.d/nlnetlabs.list > /dev/null

RUN apt update && \
	apt install  -y --no-install-recommends \
	krill && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*