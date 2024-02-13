FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt clean all
RUN apt update
RUN apt install -y zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

# Install Python 3.9
RUN wget https://www.python.org/ftp/python/3.9.17/Python-3.9.17.tar.xz && \
    tar -xf Python-3.9.17.tar.xz && \
    mv Python-3.9.17 /usr/local/share/python3.9 && \
    cd /usr/local/share/python3.9 && \
    ./configure --enable-optimizations --enable-shared && \
    make -j 8 build_all && \
    make -j 8 altinstall && \
    ldconfig /usr/local/share/python3.9

# Install Python3-networkx
RUN python3.9 -m pip install networkx

# Clone and set permissions for pox
RUN git clone https://github.com/noxrepo/pox.git && \
    chmod +x /pox/pox.py
