# Stage to build Routinator
# Cannot use the apt package since it is only amd64
FROM rust:latest AS routinator-build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    apt install -y libssl-dev git

WORKDIR /tmp 

RUN git clone https://github.com/NLnetLabs/routinator && \
	cd routinator && \
	cargo build --release --locked

# Build the final image
FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update && apt upgrade -y && \ 
    apt install -y libssl3 && \
	apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY --from=routinator-build /tmp/routinator/target/release/routinator /usr/local/bin/routinator
COPY routinator.service /usr/lib/systemd/system/routinator.service

RUN mkdir /etc/routinator