FROM kathara/base
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

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
    libelf-dev \
	libtool \
	llvm \
	protobuf-compiler

WORKDIR /tmp 

RUN git clone --recursive https://github.com/p4lang/p4c.git && \
    cd p4c && mkdir build && cd build && \
	cmake .. -DENABLE_EBPF=OFF -DENABLE_UBPF=OFF -DENABLE_DPDK=OFF -DENABLE_P4TC=OFF && \
	make -j$(nproc --ignore=4) && \
	make install && ldconfig && \
	cd .. && rm -Rf p4c/

RUN git clone --depth=1 -b v1.43.2 https://github.com/google/grpc.git && \
	cd grpc && \
	git submodule update --init --recursive && \
	mkdir -p cmake/build && cd cmake/build && \
	cmake ../.. && make -j$(nproc --ignore=4) && \
	make install && ldconfig && \
	cd ../.. && rm -Rf grpc && \
	git clone https://github.com/p4lang/PI && \
 	cd PI && \
    git submodule update --init && \
	./autogen.sh && \
	./configure --with-proto && make -j$(nproc --ignore=4) && \
	make install && ldconfig && \
	cd .. && rm -Rf PI

WORKDIR /

RUN git clone https://github.com/p4lang/behavioral-model && \
	cd behavioral-model && \
    sed -i 's/sudo//g' ci/install-thrift.sh && bash ci/install-thrift.sh && \
	sed -i 's/sudo//g' ci/install-nanomsg.sh && bash ci/install-nanomsg.sh && \
	ldconfig && \
	sed -i 's/sudo//g' ci/install-nnpy.sh && \
	sed -i 's/pip3 install/pip3 install --no-cache-dir --break-system-packages/g' ci/install-nnpy.sh && bash ci/install-nnpy.sh && \	
	./autogen.sh && \
	./configure --with-pi && \
	make -j$(nproc --ignore=4) && \
	make install && ldconfig
	
RUN cd behavioral-model/tools && make install && \
	cd / && mv behavioral-model/tools . && \
	rm -Rf behavioral-model/

RUN python3 -m pip install --no-cache-dir --break-system-packages p4runtime && \
	git clone https://github.com/p4lang/tutorials.git && \
	mv tutorials/utils/p4runtime_lib /usr/local/lib/python$(python3 -c "import platform; v = platform.python_version_tuple(); print(v[0] + '.' + v[1])")/site-packages/p4runtime_lib && \
	rm -Rf tutorials

RUN echo "export PYTHONPATH=\$PYTHONPATH:/usr/local/lib/python$(python3 -c "import platform; v = platform.python_version_tuple(); print(v[0] + '.' + v[1])")/site-packages/" >> /root/.bashrc

ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION python

RUN apt remove -y automake cmake g++ llvm && apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/