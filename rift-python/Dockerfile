FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN git clone https://github.com/brunorijsman/rift-python /rift
RUN sed -i 's/codecov==2.1.12/codecov/g' /rift/requirements-3-10.txt
RUN python3 -m pip install --no-cache-dir -r /rift/requirements-3-10.txt
RUN mkdir /etc/rift