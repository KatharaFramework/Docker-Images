FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y
RUN apt install -y libssl-dev haproxy

ENV PATH=$PATH:/root/.cargo/bin
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

RUN git clone https://github.com/NLnetLabs/krill && \
    cd krill && cargo build --release --locked && \
    cd .. && rm -Rf krill/

RUN mkdir /etc/krill

COPY start.sh /start.sh

RUN chmod +x /start.sh

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*