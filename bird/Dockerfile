FROM kathara/core:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ARG TARGETARCH

RUN apt update && \
	apt install -y --no-install-recommends \
	bird golang-go && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN git clone https://github.com/alice-lg/birdwatcher.git && \
    cd birdwatcher && \
    sed -i "s/birdwatcher-linux-amd64/birdwatcher-linux-$TARGETARCH/g" install/systemd/birdwatcher4.service && \
    sed -i "s/birdwatcher-linux-amd64/birdwatcher-linux-$TARGETARCH/g" install/systemd/birdwatcher6.service && \
    make dist ARCH=$TARGETARCH && \
    cp -r DIST/* / && cd / && rm -rf birdwatcher