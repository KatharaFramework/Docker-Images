SHELL := /bin/bash

REGISTRY ?= docker.io
IMAGE_NAMESPACE ?= kathara
IMAGE_PREFIX=$(REGISTRY)/$(IMAGE_NAMESPACE)

PUSH ?= --push

DOCKER=docker
DOCKER_BUILD=$(DOCKER) build
BUILDX=$(DOCKER) buildx
BUILDX_BUILD=$(BUILDX) build --platform linux/amd64,linux/arm64

versions_frr=9 10
versions_bind=9.11.5
versions_scion=0.12.0

retags_openvswitch=sdn
retags_bmv2=p4

all: build_apache build_base build_bind build_bird build_bird2 build_bird3 build_bmv2 build_core build_dnsmasq build_frr build_krill build_openbgpd build_openvswitch build_pox build_quagga build_rift-python build_routinator build_rpki-client build_scion
all-multi: build_multi_apache build_multi_base build_multi_bind build_multi_bird build_multi_bird2 build_multi_bird3 build_multi_bmv2 build_multi_core build_multi_dnsmasq build_multi_frr build_multi_krill build_multi_openbgpd build_multi_openvswitch build_multi_pox build_multi_quagga build_multi_rift-python build_multi_routinator build_multi_rpki-client build_multi_scion

build_core:
	echo "Building '$(IMAGE_PREFIX)/core' with tag 'latest'..."
	$(DOCKER_BUILD) -t $(IMAGE_PREFIX)/core core; \

build_%: build_core
	latest_found=0
	if [ -f $*/Dockerfile ]; then \
		echo "Building '$(IMAGE_PREFIX)/$*' with tag 'latest'..."; \
		$(DOCKER_BUILD) -t $(IMAGE_PREFIX)/$* $*; \
		latest_found=1; \
	fi; \
	if [ -f $*/Dockerfile_version ]; then \
		for version in $(versions_$*); do \
			echo "Building '$(IMAGE_PREFIX)/$*' with version option '$$version'..."; \
			$(DOCKER_BUILD) -f $*/Dockerfile_version --build-arg VERSION=$$version -t $(IMAGE_PREFIX)/$*:$$version $*; \
		done; \
		if [[ $$latest_found != 1 ]]; then \
			echo "Tagging '$(IMAGE_PREFIX)/$*:$$version' as 'latest'..."; \
			$(DOCKER_BUILD) -f $*/Dockerfile_version --build-arg VERSION=$$version -t $(IMAGE_PREFIX)/$* $*; \
		fi; \
	fi; \
	for retag in $(retags_$*); do \
		echo "Retagging 'kathara/$*:latest' to '$(IMAGE_PREFIX)/$$retag'..."; \
		$(DOCKER) tag kathara/$*:latest $(IMAGE_PREFIX)/$$retag; \
	done; \
	for x in $$(find $* -name 'Dockerfile-*'); do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '-' -f2); \
		echo "Building '$(IMAGE_PREFIX)/$*' from version file '$$tag'..."; \
		$(DOCKER_BUILD) -f $$x -t $(IMAGE_PREFIX)/$*:$$tag $*; \
	done;

build_multi_core: create-builder
	echo "Building '$(IMAGE_PREFIX)/core' with tag 'latest'..."
	$(BUILDX_BUILD) -t $(IMAGE_PREFIX)/core $(PUSH) core

build_multi_%: build_multi_core
	latest_found=0
	if [ -f $*/Dockerfile ]; then \
		echo "Building '$(IMAGE_PREFIX)/$*' with tag 'latest'..."; \
		$(BUILDX_BUILD) -t $(IMAGE_PREFIX)/$* $(PUSH) $*; \
		latest_found=1; \
	fi; \
	if [ -f $*/Dockerfile_version ]; then \
		for option in $(versions_$*); do \
			echo "Building '$(IMAGE_PREFIX)/$*' with version option '$$version'..."; \
			$(BUILDX_BUILD) -f $*/Dockerfile_version --build-arg VERSION=$$option -t $(IMAGE_PREFIX)/$*:$$option $(PUSH) $*; \
		done; \
		if [[ $$latest_found != 1 ]]; then \
			echo "Tagging '$(IMAGE_PREFIX)/$*:$$version' as 'latest'..."; \
			$(BUILDX_BUILD) -f $*/Dockerfile_version --build-arg VERSION=$$option -t $(IMAGE_PREFIX)/$* $(PUSH) $*; \
		fi; \
	fi; \
	for retag in $(retags_$*); do \
		echo "Retagging '$(IMAGE_PREFIX)/$*:latest' to '$(IMAGE_PREFIX)/$$retag'..."; \
		$(BUILDX) imagetools create -t $(IMAGE_PREFIX)/$$retag $(IMAGE_PREFIX)/$*:latest; \
	done; \
	for x in $$(find $* -name 'Dockerfile-*'); do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '-' -f2); \
		echo "Building '$(IMAGE_PREFIX)/$*' from version file '$$tag'..."; \
		$(BUILDX_BUILD) -f $$x -t $(IMAGE_PREFIX)/$*:$$tag $(PUSH) $*; \
	done;

create-builder:
	echo "Creating buildx builder..."
	$(BUILDX) use kat-builder || $(BUILDX) create --name kat-builder --use
	$(BUILDX) inspect --bootstrap

delete-builder:
	$(BUILDX) rm kat-builder
