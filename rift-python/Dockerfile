FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN git clone https://github.com/brunorijsman/rift-python /rift && \
    sed -i 's/\(.*\)==.*/\1/g' /rift/requirements-3-10.txt && \
    python3 -m pip install --no-cache-dir --break-system-packages -r /rift/requirements-3-10.txt
    
RUN mkdir /etc/rift