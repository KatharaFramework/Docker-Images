FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update && apt install -y rpki-client stayrtr cron

RUN sed -i -e 's/Type=exec/Type=simple/' /lib/systemd/system/stayrtr.service

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*