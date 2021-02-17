FROM kathara/base:debian10

RUN curl -s https://deb.frrouting.org/frr/keys.asc | apt-key add -   
   
RUN echo deb https://deb.frrouting.org/frr $(lsb_release -s -c) "frr-stable" | tee -a /etc/apt/sources.list.d/frr.list 

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y frr frr-pythontools

RUN sed -i -e 's/service/no service/' /etc/frr/vtysh.conf \
    && rm /etc/frr/frr.conf

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
