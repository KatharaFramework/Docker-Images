FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>, Riccardo Gobbato"

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y

RUN apt install -y zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev libbz2-dev

RUN wget https://www.python.org/ftp/python/3.9.17/Python-3.9.17.tar.xz && \
    tar xfv Python-3.9.17.tar.xz && \
    cd Python-3.9.17 && \
    ./configure --enable-optimizations --enable-shared && \
    make -j8 build_all && \
    make -j8 altinstall && \
    ldconfig && \
    cd .. && rm -rf Python-3.9.17*

RUN apt remove -y zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev libbz2-dev

RUN python3.9 -m pip install networkx

RUN git clone https://github.com/noxrepo/pox.git && \
    chmod +x /pox/pox.py

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
