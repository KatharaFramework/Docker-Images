BUILDX=docker buildx build --platform linux/amd64,linux/arm64

.PHONY: base quagga frr sdn p4 all pushall all-multi create-builder base-multi quagga-multi frr-multi sdn-multi p4-multi delete-builder

all: base quagga frr sdn p4
all-multi: create-builder base-multi quagga-multi frr-multi sdn-multi p4-multi delete-builder

pushall:
	docker push kathara/base:debian9
	docker push kathara/quagga:debian9
	docker push kathara/frr:debian9
	docker push kathara/sdn:debian9
	docker push kathara/p4:debian9

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
	$(BUILDX) -t kathara/base:debian9 --push base

quagga-multi: create-builder base-multi
	$(BUILDX) -t kathara/quagga:debian9 --push quagga

frr-multi: create-builder base-multi
	$(BUILDX) -t kathara/frr:debian9 --push frr

sdn-multi: create-builder base-multi
	$(BUILDX) -t kathara/sdn:debian9 --push sdn

p4-multi: create-builder base-multi
	$(BUILDX) -t kathara/p4:debian9 --push p4

create-builder:
	docker buildx create --name kat-builder --use
	docker buildx inspect --bootstrap

delete-builder:
	docker buildx rm kat-builder
