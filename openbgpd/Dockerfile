FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update && apt install -y openbgpd

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*