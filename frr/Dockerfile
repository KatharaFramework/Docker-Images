FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN curl -s https://deb.frrouting.org/frr/keys.asc | apt-key add -   
   
RUN echo "deb https://deb.frrouting.org/frr $(lsb_release -s -c) \"frr-9\"" | tee -a /etc/apt/sources.list.d/frr.list 

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update && apt install -y frr frr-pythontools frr-rpki-rtrlib

RUN sed -i -e 's/service/no service/' /etc/frr/vtysh.conf \
    && rm /etc/frr/frr.conf

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN sed -i 's|ExecStart=/usr/lib/frr/frrinit.sh start|ExecStart=/usr/bin/su -c "/usr/lib/frr/frrinit.sh start"|' /lib/systemd/system/frr.service && \
	sed -i 's|ExecStop=/usr/lib/frr/frrinit.sh stop|ExecStop=/usr/bin/su -c "/usr/lib/frr/frrinit.sh stop"|' /lib/systemd/system/frr.service && \
	sed -i 's|ExecReload=/usr/lib/frr/frrinit.sh reload|ExecReload=/usr/bin/su -c "/usr/lib/frr/frrinit.sh reload"|' /lib/systemd/system/frr.service && \
	sed -i 's|ExecStart=/usr/lib/frr/frrinit.sh start|ExecStart=/usr/bin/su -c "/usr/lib/frr/frrinit.sh start"|' /lib/systemd/system/frr\@.service	&& \
	sed -i 's|ExecStop=/usr/lib/frr/frrinit.sh stop|ExecStop=/usr/bin/su -c "/usr/lib/frr/frrinit.sh stop"|' /lib/systemd/system/frr\@.service && \
	sed -i 's|ExecReload=/usr/lib/frr/frrinit.sh reload|ExecReload=/usr/bin/su -c "/usr/lib/frr/frrinit.sh reload"|' /lib/systemd/system/frr\@.service
