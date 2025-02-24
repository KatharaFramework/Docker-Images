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
	libboost-dev \
	libboost-iostreams-dev \
	libboost-graph-dev \
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
	make -j$(nproc) && \
	DESTDIR=/tmp/output make install

FROM debian:12 AS bm

ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && \
	apt install -y --no-install-recommends \
	automake \
	bison \
	build-essential \
	cmake \
	flex \
	g++ \
	git \
	libboost-dev \
	libboost-filesystem-dev \
	libboost-program-options-dev \
	libboost-system-dev \
	libboost-test-dev \
	libboost-thread-dev \
	libevent-dev \
	libgmp-dev \
	libpcap-dev \
	libssl-dev \
	libtool \
	sudo \
	pkg-config \
	python3-dev \
	python3-pip

WORKDIR /tmp 

RUN mkdir /tmp/output

RUN git clone https://github.com/p4lang/behavioral-model && \
	cd behavioral-model && \
	bash ci/install-thrift.sh && \
	bash ci/install-nanomsg.sh && \
	ldconfig && \
	sed -i 's/pip3 install/pip3 install --no-cache-dir --break-system-packages/g' ci/install-nnpy.sh && \
	./autogen.sh && \
	./configure --with-pi && \
	make -j$(nproc) && \
	DESTDIR=/tmp/output make install

# Build the final image
FROM debian:12
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN cd behavioral-model/tools && make install && \
	cd / && mv behavioral-model/tools . && \
	rm -Rf behavioral-model/

RUN python3 -m pip install --no-cache-dir --break-system-packages p4runtime && \
	git clone https://github.com/p4lang/tutorials.git && \
	mv tutorials/utils/p4runtime_lib /usr/local/lib/python$(python3 -c "import platform; v = platform.python_version_tuple(); print(v[0] + '.' + v[1])")/site-packages/p4runtime_lib && \
	rm -Rf tutorials

RUN echo "export PYTHONPATH=\$PYTHONPATH:/usr/local/lib/python$(python3 -c "import platform; v = platform.python_version_tuple(); print(v[0] + '.' + v[1])")/site-packages/" >> /root/.bashrc

ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION="python"