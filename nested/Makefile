#!/usr/bin/make -f

ARCHITECTURE:=$(shell uname -m)

.PHONY: all internal wrap clean-all clean-internal clean-wrap

all: wrap

clone-kathara: 
	rm -Rf Kathara
	git clone -b "feature-inception" https://github.com/KatharaFramework/Kathara.git

internal: clean-internal clone-kathara
	mkdir -p internal
	cp -R Kathara internal/kathara
ifeq ("${ARCHITECTURE}", "aarch64")
	cp plugin_arm64.tar.gz internal/plugin.tar.gz
else ifeq ("${ARCHITECTURE}", "arm64")
	cp plugin_arm64.tar.gz internal/plugin.tar.gz
else ifeq ("${ARCHITECTURE}", "amd64")
	cp plugin_amd64.tar.gz internal/plugin.tar.gz
else ifeq ("${ARCHITECTURE}", "x86_64")
	cp plugin_amd64.tar.gz internal/plugin.tar.gz
endif
	cp kathara.conf internal
	cp rundocker internal
	cp Dockerfile_template internal/Dockerfile
	sed -i -e "s|__IMAGE__||g" internal/Dockerfile
	cd internal && docker build -t kathara/inception .

wrap: clean-wrap internal
	mkdir -p wrap
	cp -R Kathara wrap/kathara
ifeq ("${ARCHITECTURE}", "aarch64")
	cp plugin_arm64.tar.gz wrap/plugin.tar.gz
else ifeq ("${ARCHITECTURE}", "arm64")
	cp plugin_arm64.tar.gz wrap/plugin.tar.gz
else ifeq ("${ARCHITECTURE}", "amd64")
	cp plugin_amd64.tar.gz wrap/plugin.tar.gz
else ifeq ("${ARCHITECTURE}", "x86_64")
	cp plugin_amd64.tar.gz wrap/plugin.tar.gz
endif
	cp kathara.conf wrap
	cp rundocker wrap
	docker run --name inception-builder -d --privileged -ti -v "$$(pwd)":/shared docker:dind
	docker exec inception-builder /bin/sh -c 'apk add --update make tree tar'
	docker exec inception-builder /bin/sh -c 'until docker info >/dev/null 2>&1; do sleep 1; done; cd /shared && make internal'
	docker exec inception-builder /bin/sh -c 'cd /var/lib/docker && tree -infp | grep "\[c---------\]" | sed "s/\[c---------\]  ./\/var\/lib\/docker/" > c_devs.txt' 
	docker exec inception-builder /bin/sh -c 'cd /var/lib/docker && rm -Rf $$(cat c_devs.txt)' 
	docker exec inception-builder /bin/sh -c 'cd /var/lib/docker && tar cfz image.tar.gz image/ overlay2/'
	docker exec inception-builder /bin/sh -c 'mv /var/lib/docker/image.tar.gz /shared/wrap/image.tar.gz'
	docker rm -f inception-builder
	cp Dockerfile_template wrap/Dockerfile
	sed -i -e "s|__IMAGE__|COPY image.tar.gz \/var\/lib\/docker\/image.tar.gz\n__IMAGE__|g" wrap/Dockerfile
	sed -i -e "s|__IMAGE__|RUN tar xvfz \/var\/lib\/docker\/image.tar.gz -C \/var\/lib\/docker\/ \&\& rm \/var\/lib\/docker\/image.tar.gz|g" wrap/Dockerfile
	cd wrap && docker build -t kathara/inception .

clean-all: clean-internal clean-wrap

clean-internal:
	rm -Rf internal/

clean-wrap:
	docker rm -f inception-builder
	rm -Rf wrap/