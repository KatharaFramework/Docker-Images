BUILDX=docker buildx build --platform linux/amd64,linux/arm64

.PHONY: build_common build_base build_quagga build_frr build_bird build_openbgpd build_krill build_routinator build_rpki-client build_rift-python build_openvswitch build_pox build_bmv2 build_multi_common build_multi_base build_multi_quagga build_multi_frr build_multi_bird build_multi_openbgpd build_multi_krill build_multi_routinator build_multi_rpki-client build_multi_rift-python build_multi_openvswitch build_multi_pox build_multi_bmv2 all all-multi create-builder delete-builder

all: build_common build_base build_quagga build_frr build_bird build_openbgpd build_krill build_rpki-client build_routinator build_rift-python build_openvswitch build_pox build_bmv2
all-multi: create-builder build_multi_common build_multi_base build_multi_quagga build_multi_frr build_multi_bird build_multi_openbgpd build_multi_krill build_multi_routinator build_multi_rpki-client build_multi_rift-python build_multi_openvswitch build_multi_pox build_multi_bmv2 delete-builder

build_common:
	for x in common/Dockerfile*; do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '_' -f2); \
		docker build -f $$x -t kathara/common:$$tag common; \
	done

build_%: build_common
	for x in $*/Dockerfile*; do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '_' -f2); \
		docker build -f $$x -t kathara/$*:$$tag $*; \
	done

build_multi_common: create-builder
	for x in common/Dockerfile*; do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '_' -f2); \
		$(BUILDX) -f $$x -t kathara/common:$$tag --push common; \
	done

build_multi_%: build_multi_common
	for x in $*/Dockerfile*; do \
  		dockerfile=$$(basename $$x); \
		tag=$$(echo $$dockerfile | cut -d '_' -f2); \
		$(BUILDX) -f $$x -t kathara/$*:$$tag --push $* \
	done

create-builder:
	docker buildx create --name kat-builder --use
	docker buildx inspect --bootstrap

delete-builder:
	docker buildx rm kat-builder
