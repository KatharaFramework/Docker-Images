SHELL := /bin/bash

DOCKER=docker
DOCKER_BUILD=$(DOCKER) build
BUILDX=$(DOCKER) buildx
BUILDX_BUILD=$(BUILDX) build --platform linux/amd64,linux/arm64

versions_frr=9 10
versions_bind=9.11.37
versions_scion=0.12.0

retags_openvswitch=sdn
retags_bmv2=p4

all: build_apache build_base build_bind build_bird build_bird2 build_bird3 build_bmv2 build_common build_frr build_krill build_openbgpd build_openvswitch build_pox build_quagga build_rift-python build_routinator build_rpki-client build_scion
all-multi: build_multi_apache build_multi_base build_multi_bind build_multi_bird build_multi_bird2 build_multi_bird3 build_multi_bmv2 build_multi_common build_multi_frr build_multi_krill build_multi_openbgpd build_multi_openvswitch build_multi_pox build_multi_quagga build_multi_rift-python build_multi_routinator build_multi_rpki-client build_multi_scion

build_common:
	echo "Building 'kathara/common' with tag 'latest'..."
	$(DOCKER_BUILD) -t kathara/common common; \

build_%: build_common
	latest_found=0
	if [ -f $*/Dockerfile ]; then \
		echo "Building 'kathara/$*' with tag 'latest'..."; \
		$(DOCKER_BUILD) -t kathara/$* $*; \
		latest_found=1; \
	fi; \
	if [ -f $*/Dockerfile_version ]; then \
		for version in $(versions_$*); do \
			echo "Building 'kathara/$*' with version option '$$version'..."; \
			$(DOCKER_BUILD) -f $*/Dockerfile_version --build-arg VERSION=$$version -t kathara/$*:$$version $*; \
		done; \
		if [[ $$latest_found != 1 ]]; then \
			echo "Tagging 'kathara/$*:$$version' as 'latest'..."; \
			$(DOCKER_BUILD) -f $*/Dockerfile_version --build-arg VERSION=$$version -t kathara/$* $*; \
		fi; \
	fi; \
	for retag in $(retags_$*); do \
		echo "Retagging 'kathara/$*:latest' to 'kathara/$$retag'..."; \
		$(DOCKER) tag kathara/$*:latest kathara/$$retag; \
	done; \
	for x in $$(find $* -name 'Dockerfile-*'); do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '-' -f2); \
		echo "Building 'kathara/$*' from version file '$$tag'..."; \
		$(DOCKER_BUILD) -f $$x -t kathara/$*:$$tag $*; \
	done;

build_multi_common: create-builder
	echo "Building 'kathara/common' with tag 'latest'..."
	$(BUILDX_BUILD) -t kathara/common --push common

build_multi_%: build_multi_common
	latest_found=0
	if [ -f $*/Dockerfile ]; then \
		echo "Building 'kathara/$*' with tag 'latest'..."; \
		$(BUILDX_BUILD) -t kathara/$* --push $*; \
		latest_found=1; \
	fi; \
	if [ -f $*/Dockerfile_version ]; then \
		for option in $(versions_$*); do \
			echo "Building 'kathara/$*' with version option '$$version'..."; \
			$(BUILDX_BUILD) -f $*/Dockerfile_version --build-arg VERSION=$$option -t kathara/$*:$$option --push $*; \
		done; \
		if [[ $$latest_found != 1 ]]; then \
			echo "Tagging 'kathara/$*:$$version' as 'latest'..."; \
			$(BUILDX_BUILD) -f $*/Dockerfile_version --build-arg VERSION=$$option -t kathara/$* --push $*; \
		fi; \
	fi; \
	for retag in $(retags_$*); do \
		echo "Retagging 'kathara/$*:latest' to 'kathara/$$retag'..."; \
		$(BUILDX) imagetools create -t kathara/$$retag kathara/$*:latest; \
	done; \
	for x in $$(find $* -name 'Dockerfile-*'); do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '-' -f2); \
		echo "Building 'kathara/$*' from version file '$$tag'..."; \
		$(BUILDX_BUILD) -f $$x -t kathara/$*:$$tag --push $*; \
	done;

create-builder:
	echo "Creating buildx builder..."
	$(BUILDX) create --name kat-builder --use
	$(BUILDX) inspect --bootstrap

delete-builder:
	$(BUILDX) rm kat-builder
