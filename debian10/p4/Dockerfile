FROM kathara/base:debian10

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
    sed -i 's/sudo//g' ci/install-thrift.sh && bash ci/install-thrift.sh && \
	sed -i 's/sudo//g' ci/install-nanomsg.sh && bash ci/install-nanomsg.sh && \
	ldconfig && \
	sed -i 's/sudo//g' ci/install-nnpy.sh && bash ci/install-nnpy.sh && \
	./autogen.sh && \
	./configure && \
	make && \
	make install && ldconfig
	
RUN cd behavioral-model/tools && make install && \
	cd / && mv behavioral-model/tools . && \
	rm -Rf behavioral-model/

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/