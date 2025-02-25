FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN wget -qO - "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xF23C5A6CF475977595C89F51BA6932366A755776" | gpg --dearmor -o /usr/share/keyrings/deadsnakes.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/deadsnakes.gpg] https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu jammy main " | tee /etc/apt/sources.list.d/deadsnakes.list

RUN apt update && \
	apt install -y --no-install-recommends \
	python3.9 \
	python3.9-distutils && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN python3.9 -m pip install networkx

RUN git clone https://github.com/noxrepo/pox.git && \
	chmod +x /pox/pox.py