BUILDX=docker buildx build --platform linux/amd64,linux/arm64

.PHONY: base quagga frr krill routinator bird rift-python sdn p4 all pushall all-multi create-builder base-multi quagga-multi frr-multi krill-multi routinator-multi bird-multi rift-python-multi sdn-multi p4-multi delete-builder

all: base quagga frr krill routinator bird rift-python sdn p4
all-multi: create-builder base-multi quagga-multi frr-multi krill-multi routinator-multi bird-multi rift-python-multi sdn-multi p4-multi delete-builder

pushall:
	docker push kathara/base
	docker push kathara/quagga
	docker push kathara/frr
	docker push kathara/krill
	docker push kathara/routinator
	docker push kathara/bird
	docker push kathara/rift-python
	docker push kathara/sdn
	docker push kathara/p4

base:
	docker build -t kathara/base base

quagga: base
	docker build -t kathara/quagga quagga

frr: base
	docker build -t kathara/frr frr

krill: base
	docker build -t kathara/krill krill

routinator: frr
	docker build -t kathara/routinator routinator

bird: base
	docker build -t kathara/bird bird

rift-python: base
	docker build -t kathara/rift-python rift-python

sdn: base
	docker build -t kathara/sdn sdn

p4: base
	docker build -t kathara/p4 p4

base-multi: create-builder
	$(BUILDX) -t kathara/base --push base

quagga-multi: create-builder base-multi
	$(BUILDX) -t kathara/quagga --push quagga

frr-multi: create-builder base-multi
	$(BUILDX) -t kathara/frr --push frr

krill-multi: create-builder base-multi
	$(BUILDX) -t kathara/krill --push krill

routinator-multi: create-builder frr-multi
	$(BUILDX) -t kathara/routinator --push routinator

bird-multi: create-builder base-multi
	$(BUILDX) -t kathara/bird --push bird

rift-python-multi: create-builder base-multi
	$(BUILDX) -t kathara/rift-python --push rift-python

sdn-multi: create-builder base-multi
	$(BUILDX) -t kathara/sdn --push sdn

p4-multi: create-builder base-multi
	$(BUILDX) -t kathara/p4 --push p4

create-builder:
	docker buildx create --name kat-builder --use
	docker buildx inspect --bootstrap

delete-builder:
	docker buildx rm kat-builder
