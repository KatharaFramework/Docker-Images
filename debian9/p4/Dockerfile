FROM kathara/base

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y
RUN apt install -y \
	automake \
	cmake \
	g++ \
	libgc-dev \
	libgmp-dev \
	libpcap-dev \
	libboost-dev \
	libboost-test-dev \
	libboost-program-options-dev \
	libboost-system-dev \
	libboost-filesystem-dev \
	libboost-thread-dev \
	libboost-iostreams-dev \
	libboost-graph-dev \
	libevent-dev \
	libjudy-dev \
	libprotobuf-dev \
	libssl-dev \
	libtool \
	llvm \
	protobuf-compiler \
	python3-pip

RUN git clone --recursive https://github.com/p4lang/p4c.git && \
    cd p4c && mkdir build && cd build && \
	cmake .. && \
	make -j4 && \
	make install && ldconfig && \
	cd / && rm -Rf p4c/

RUN git clone https://github.com/p4lang/behavioral-model && \
	cd behavioral-model && \
    sed -i 's/sudo//g' travis/install-thrift.sh && bash travis/install-thrift.sh && \
	sed -i 's/sudo//g' travis/install-nanomsg.sh && bash travis/install-nanomsg.sh && \
	ldconfig && \
	sed -i 's/sudo//g' travis/install-nnpy.sh && bash travis/install-nnpy.sh && \
	./autogen.sh && \
	./configure && \
	make && \
	make install && ldconfig && \
	cd / && rm -Rf behavioral-model/

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/