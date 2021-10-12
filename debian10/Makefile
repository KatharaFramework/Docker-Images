BUILDX=docker buildx build --platform linux/amd64,linux/arm64

.PHONY: base quagga frr sdn all pushall all-multi create-builder base-multi quagga-multi

all: base quagga frr sdn
all-multi: create-builder base-multi quagga-multi frr-multi sdn-multi p4-multi

pushall:
	docker push kathara/base:debian10
	docker push kathara/quagga:debian10
	docker push kathara/frr:debian10
	docker push kathara/sdn:debian10
	docker push kathara/p4:debian10

base:
	docker build -t kathara/base:debian10 base

quagga: base
	docker build -t kathara/quagga:debian10 quagga

frr: base
	docker build -t kathara/frr:debian10 frr

sdn: base
	docker build -t kathara/sdn:debian10 sdn

p4: base
	docker build -t kathara/p4:debian10 p4

base-multi: create-builder
	$(BUILDX) -t kathara/base:debian10 --push base

quagga-multi: create-builder base-multi
	$(BUILDX) -t kathara/quagga:debian10 --push quagga

frr-multi: create-builder base-multi
	$(BUILDX) -t kathara/frr:debian10 --push frr

sdn-multi: create-builder base-multi
	$(BUILDX) -t kathara/sdn:debian10 --push sdn

p4-multi: create-builder base-multi
	$(BUILDX) -t kathara/p4:debian10 --push p4

create-builder:
	docker buildx create --name kat-builder --use
	docker buildx inspect --bootstrap