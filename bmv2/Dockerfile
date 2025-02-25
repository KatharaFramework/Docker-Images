# Stage to build p4c
FROM debian:12 AS p4c

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
	apt install -y --no-install-recommends \
	automake \
	bison \
	build-essential \
	ca-certificates \
	cmake \
	flex \
	git \
	libtool \
	libgc-dev \
	libfl-dev \
	libboost1.81-dev \
	libboost-iostreams1.81-dev \
	libboost-graph1.81-dev \
	llvm \
	python3 \
	pkg-config

WORKDIR /tmp 

RUN mkdir /tmp/output

RUN git clone --recursive https://github.com/p4lang/p4c.git && \
	cd p4c && \
	mkdir build && \
	cd build && \
	cmake .. -DENABLE_EBPF=OFF -DENABLE_UBPF=OFF -DENABLE_DPDK=OFF -DENABLE_P4TC=OFF -DENABLE_P4C_GRAPHS=OFF && \
	make -j$(nproc --ignore=4) && \
	DESTDIR=/tmp/output make install

# Stage to build PI and bmv2
FROM debian:12 AS bm

ENV DEBIAN_FRONTEND="noninteractive"

RUN echo "deb http://deb.debian.org/debian bullseye main" | tee /etc/apt/sources.list.d/bullseye.list && \
 	apt update && \
	apt install -y --no-install-recommends \
	automake \
	bison \
	build-essential \
	ca-certificates \
	cmake \
	flex \
	g++ \
	git \
	libboost1.81-dev \
	libboost-filesystem1.81-dev \
	libboost-program-options1.81-dev \
	libboost-system1.81-dev \
	libboost-test1.81-dev \
	libboost-thread1.81-dev \
	libevent-dev \
	libgmp-dev \
	libnanomsg-dev \
	libpcap-dev \
	libprotobuf-dev \
	libssl-dev \
	libthrift-dev=0.13.0-6 \
	libtool \
	llvm \
	pkg-config \
	python3-dev \
	python3-pip \
	protobuf-compiler \
	sudo \
	thrift-compiler \
	wget

WORKDIR /tmp 

RUN mkdir /tmp/output

RUN git clone --depth=1 -b v1.43.2 https://github.com/google/grpc.git && \
	cd grpc && \
	git submodule update --init --recursive && \
	mkdir -p cmake/build && cd cmake/build && \
	cmake ../.. && make -j$(nproc --ignore=4) && \
	# make install in /tmp/output to export in the next layer
	DESTDIR=/tmp/output make install && \
	# make install in / to compile PI
	make install

RUN git clone https://github.com/p4lang/PI && \
 	cd PI && \
    git submodule update --init && \
	./autogen.sh && \
	./configure --with-proto && \
	make -j$(nproc --ignore=4) && \
	# make install in /tmp/output to export in the next layer
	DESTDIR=/tmp/output make install && \
	# make install in / to compile bmv2
	make install

RUN git clone https://github.com/p4lang/behavioral-model && \
	cd behavioral-model && \
	./autogen.sh && \
	./configure --with-pi && \
 	make -j$(nproc --ignore=4) && \
 	DESTDIR=/tmp/output make install && \
	cd tools && DESTDIR=/tmp/output make install

RUN pip wheel nnpy cffi

# Stage to download the p4runtime_lib
FROM debian:12 AS p4runtime

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update && \
	apt install -y --no-install-recommends \
	git \
	python3-pip

WORKDIR /tmp 

RUN mkdir /tmp/output

RUN git clone https://github.com/p4lang/tutorials.git && \
	mv tutorials/utils/p4runtime_lib /tmp/output

# Build the final image
FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION="python"
ENV PYTHONPATH="$PYTHONPATH:/usr/local/lib/python3.11/site-packages/"

RUN echo "deb http://deb.debian.org/debian bullseye main" | tee /etc/apt/sources.list.d/bullseye.list && \
 	apt update && \
	apt install -y --no-install-recommends \
	libboost-filesystem1.81.0 \
	libboost-iostreams1.81.0 \
	libboost-program-options1.81.0 \
	libboost-system1.81.0 \
	libboost-thread1.81.0 \
	libnanomsg5 \
	libthrift-0.13.0 && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY --from=p4c /tmp/output/usr /usr
COPY --from=bm /tmp/output/usr /usr
COPY --from=bm /tmp/*.whl /tmp
COPY --from=p4runtime /tmp/output/p4runtime_lib /usr/local/lib/python3.11/site-packages/p4runtime_lib

RUN python3 -m pip install --no-cache-dir --break-system-packages thrift /tmp/*.whl 
RUN rm -rf /tmp/*.whl

RUN ldconfig