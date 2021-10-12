BUILDX=docker buildx build --platform linux/amd64,linux/arm64

.PHONY: base quagga frr sdn all pushall all-multi create-builder base-multi quagga-multi

all: base quagga frr sdn
all-multi: create-builder base-multi quagga-multi frr-multi sdn-multi p4-multi

pushall:
	docker push kathara/base:debian9
	docker push kathara/quagga:debian9
	docker push kathara/frr:debian9
	docker push kathara/sdn:debian9
	docker push kathara/p4:debian9
	docker image tag kathara/base:debian9 kathara/base:latest
	docker push kathara/base:latest
	docker image tag kathara/quagga:debian9 kathara/quagga:latest
	docker push kathara/quagga:latest
	docker image tag kathara/frr:debian9 kathara/frr:latest
	docker push kathara/frr:latest
	docker image tag kathara/sdn:debian9 kathara/sdn:latest
	docker push kathara/sdn:latest
	docker image tag kathara/p4:debian9 kathara/p4:latest
	docker push kathara/p4:latest

base:
	docker build -t kathara/base:debian9 base

quagga: base
	docker build -t kathara/quagga:debian9 quagga

frr: base
	docker build -t kathara/frr:debian9 frr

sdn: base
	docker build -t kathara/sdn:debian9 sdn

p4: base
	docker build -t kathara/p4:debian9 p4

base-multi: create-builder
	$(BUILDX) -t kathara/base:debian9 -t kathara/base:latest --push base

quagga-multi: create-builder base-multi
	$(BUILDX) -t kathara/quagga:debian9 -t kathara/quagga:latest --push quagga

frr-multi: create-builder base-multi
	$(BUILDX) -t kathara/frr:debian9 -t kathara/frr:latest --push frr

sdn-multi: create-builder base-multi
	$(BUILDX) -t kathara/sdn:debian9 -t kathara/sdn:latest --push sdn

p4-multi: create-builder base-multi
	$(BUILDX) -t kathara/p4:debian9 -t kathara/p4:latest --push p4

create-builder:
	docker buildx create --name kat-builder --use
	docker buildx inspect --bootstrap