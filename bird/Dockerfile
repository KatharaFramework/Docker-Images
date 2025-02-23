FROM debian:12 AS bird

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
	apt install  -y --no-install-recommends \
	autoconf \
	build-essential \
	git \
	libncurses5-dev \
	libncursesw5-dev \
	libreadline6-dev \
	libssh-dev

WORKDIR /tmp

RUN	mkdir output

RUN git clone --recursive https://github.com/CZ-NIC/bird.git && \
	cd bird && \
	git checkout tags/v2.0.8 && \
	autoreconf && \
	./configure --enable-libssh && \
	make -j $(nproc) && make install PREFIX=/tmp/output

# Build the final image
FROM kathara/common:12
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

COPY --from=bird /tmp/output/ /