SHELL := /bin/bash

DOCKER=docker
DOCKER_BUILD=$(DOCKER) build
BUILDX=$(DOCKER) buildx
BUILDX_BUILD=$(BUILDX) build --platform linux/amd64,linux/arm64
versions_frr=9 10
versions_bind=9.11.37
versions_scion=0.12.0

all: build_common build_base build_quagga build_frr build_bird build_openbgpd build_krill build_rpki-client build_routinator build_rift-python build_openvswitch build_pox build_bmv2 build_scion
all-multi: create-builder build_multi_common build_multi_base build_multi_quagga build_multi_frr build_multi_bird build_multi_openbgpd build_multi_krill build_multi_routinator build_multi_rpki-client build_multi_rift-python build_multi_openvswitch build_multi_pox build_multi_bmv2 build_multi_scion delete-builder


build_common:
	echo "Building common latest..."
	$(DOCKER_BUILD) -t kathara/common common; \

build_%: build_common
	latest=0
	if [ -f $*/Dockerfile ]; then \
		echo "Building $* latest..."; \
		$(DOCKER_BUILD) -t kathara/$* $*; \
		latest=1; \
	fi; \
	if [ -f $*/Dockerfile_version ]; then \
		for option in $(versions_$*); do \
			echo "Building $* with option $$option..."; \
			$(DOCKER_BUILD) -f Dockerfile_version --build-arg VERSION=$$option -t kathara/$*:$$option $*; \
		done; \
		if [[ $$latest != 1 ]]; then \
			echo "Tagging $* as latest from $$option..."; \
			$(DOCKER_BUILD) -f Dockerfile_version --build-arg VERSION=$$option -t kathara/$* $*; \
		fi; \
	fi; \
	for x in $$(find $* -name 'Dockerfile-*'); do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '-' -f2); \
		echo "Building $* with version $$tag..."; \
		$(DOCKER_BUILD) -f $$x -t kathara/$*:$$tag $*; \
	done;

build_multi_common: create-builder
	echo "Building common latest..."
	$(BUILDX_BUILD) -t kathara/common --push common

build_multi_%: build_multi_common
	latest=0
	if [ -f $*/Dockerfile ]; then \
		echo "Building $* latest..."; \
		$(BUILDX_BUILD) -t kathara/$* --push $*; \
		latest=1; \
	fi; \
	if [ -f $*/Dockerfile_version ]; then \
		for option in $(versions_$*); do \
			echo "Building $* with option $$option..."; \
			$(BUILDX_BUILD) -f Dockerfile_version --build-arg VERSION=$$option -t kathara/$*:$$option --push $*; \
		done; \
		if [[ $$latest != 1 ]]; then \
			echo "Tagging $* as latest from $$option..."; \
			$(BUILDX_BUILD) -f Dockerfile_version --build-arg VERSION=$$option -t kathara/$* --push $*; \
		fi; \
	fi; \
	for x in $$(find $* -name 'Dockerfile-*'); do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '-' -f2); \
		echo "Building $* with version $$tag..."; \
		$(BUILDX_BUILD) -f $$x -t kathara/$*:$$tag --push $*; \
	done;

create-builder:
	echo "Creating buildx builder..."
	$(BUILDX) create --name kat-builder --use
	$(BUILDX) inspect --bootstrap

delete-builder:
	$(BUILDX) rm kat-builder
