FROM kathara/common:latest
LABEL org.opencontainers.image.authors="Kathara Team <contact@kathara.org>"

RUN apt update
RUN apt upgrade -y
RUN apt install -y --no-install-recommends \
	apache2 \
	apache2-bin \
	bind9 \
	bind9-utils \
	openssh-server \
	openssh-sftp-server && \
	apt clean && \
	rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN ln -s /etc/init.d/named /etc/init.d/bind