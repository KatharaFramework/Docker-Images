FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN wget -qO - "https://pkg.labs.nic.cz/gpg" | gpg --dearmor -o /usr/share/keyrings/bird-pkg.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/bird-pkg.gpg] https://pkg.labs.nic.cz/bird3 bookworm main" | tee /etc/apt/sources.list.d/bird.list

RUN apt update && \
	apt install -y --no-install-recommends \
	bird3 && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
