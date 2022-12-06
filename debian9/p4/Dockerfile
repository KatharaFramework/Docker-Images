FROM kathara/base:debian9

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
	protobuf-compiler

RUN git clone --recursive https://github.com/p4lang/p4c.git && \
    cd p4c && mkdir build && cd build && \
	cmake .. && \
	make -j4 && \
	make install && ldconfig && \
	cd / && rm -Rf p4c/

RUN git clone --depth=1 -b v1.43.2 https://github.com/google/grpc.git && \
	cd grpc && \
	git submodule update --init --recursive && \
	mkdir -p cmake/build && cd cmake/build && \
	cmake ../.. && make && \
	make install && ldconfig && \
	cd / && rm -Rf grpc && \
	git clone https://github.com/p4lang/PI && \
 	cd PI && \
    git submodule update --init && \
	./autogen.sh && \
	./configure --with-proto && make && \ 
	make install && ldconfig && \
	cd / && rm -Rf PI

RUN git clone https://github.com/p4lang/behavioral-model && \
	cd behavioral-model && \
    sed -i 's/sudo//g' ci/install-thrift.sh && bash ci/install-thrift.sh && \
	sed -i 's/sudo//g' ci/install-nanomsg.sh && bash ci/install-nanomsg.sh && \
	ldconfig && \
	sed -i 's/sudo//g' ci/install-nnpy.sh && bash ci/install-nnpy.sh && \
	./autogen.sh && \
	./configure --with-pi && \
	make && \
	make install && ldconfig

RUN cd behavioral-model/tools && make install && \
	cd / && mv behavioral-model/tools . && \
	rm -Rf behavioral-model/

RUN python3 -m pip install --no-cache-dir p4runtime && \
	git clone https://github.com/p4lang/tutorials.git && \
	mv tutorials/utils/p4runtime_lib /usr/local/lib/python3.7/site-packages/p4runtime_lib && \
	rm -Rf tutorials

ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION python
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python3.7/site-packages/

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/