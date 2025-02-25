# Stage to build Python dependencies
FROM debian:12 AS python-build

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
	apt install -y --no-install-recommends \
	build-essential \
	python3-dev \
	python3-pip

WORKDIR /tmp

ADD https://raw.githubusercontent.com/brunorijsman/rift-python/refs/heads/master/requirements-3-10.txt /tmp/requirements-3-10.txt

# Only pytricia and netifaces needs gcc to be installed
RUN cat /tmp/requirements-3-10.txt | sed 's/\(.*\)==.*/\1/g' | grep -E 'pytricia|netifaces' > /tmp/requirements-to-build.txt

RUN pip wheel -r /tmp/requirements-to-build.txt

# Build the final image
FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

COPY --from=python-build /tmp/*.whl /tmp

RUN python3 -m pip install --no-cache-dir --break-system-packages /tmp/*.whl
RUN rm -rf /tmp/*

RUN git clone https://github.com/brunorijsman/rift-python /rift && \
	sed -i 's/\(.*\)==.*/\1/g' /rift/requirements-3-10.txt && \
	python3 -m pip install --no-cache-dir --break-system-packages -r /rift/requirements-3-10.txt && \
	find /rift -mindepth 1 ! -name "rift" -exec rm -rf {} + && \
	mkdir /etc/rift