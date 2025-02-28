# Stage to build Krill
# Cannot use the apt package since it is only amd64
FROM rust:latest AS krill-build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    apt install -y libssl-dev git

WORKDIR /tmp 

RUN git clone https://github.com/NLnetLabs/krill.git && \
    cd krill && \
    cargo build --release --locked

# Build the final image
FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update && apt upgrade -y && \ 
    apt install -y libssl3 haproxy && \
	apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY --from=krill-build /tmp/krill/target/release/krill /usr/local/bin/krill
COPY --from=krill-build /tmp/krill/target/release/krillc /usr/local/bin/krillc
COPY krill.service /usr/lib/systemd/system/krill.service

RUN mkdir /etc/krill