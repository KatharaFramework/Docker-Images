BUILDX=docker buildx build --platform linux/amd64,linux/arm64

.PHONY: base quagga frr bird openbgpd krill routinator rpki-client rift-python sdn p4 scion all pushall all-multi create-builder base-multi quagga-multi frr-multi bird-multi openbgpd-multi krill-multi routinator-multi rpki-client-multi rift-python-multi sdn-multi p4-multi scion-multi delete-builder

all: base quagga frr bird openbgpd krill rpki-client routinator rift-python sdn p4 scion
all-multi: create-builder base-multi quagga-multi frr-multi bird-multi openbgpd-multi krill-multi routinator-multi rpki-client-multi rift-python-multi sdn-multi p4-multi scion-multi delete-builder

pushall:
	docker push kathara/base
	docker push kathara/quagga
	docker push kathara/frr
	docker push kathara/bird
	docker push kathara/openbgpd
	docker push kathara/krill
	docker push kathara/routinator
	docker push kathara/rpki-client
	docker push kathara/rift-python
	docker push kathara/sdn
	docker push kathara/p4
	docker push kathara/scion

base:
	docker build -t kathara/base base

quagga: base
	docker build -t kathara/quagga quagga

frr: base
	docker build -t kathara/frr frr

bird: base
	docker build -t kathara/bird bird

openbgpd: base
	docker build -t kathara/openbgpd openbgpd

krill: base
	docker build -t kathara/krill krill

routinator: base
	docker build -t kathara/routinator routinator

rpki-client: base
	docker build -t kathara/rpki-client rpki-client

rift-python: base
	docker build -t kathara/rift-python rift-python

sdn: base
	docker build -t kathara/sdn sdn

pox: base
	docker build -t kathara/pox pox

p4: base
	docker build -t kathara/p4 p4

scion: base
	docker build -t kathara/scion scion

base-multi: create-builder
	$(BUILDX) -t kathara/base --push base

quagga-multi: create-builder base-multi
	$(BUILDX) -t kathara/quagga --push quagga

frr-multi: create-builder base-multi
	$(BUILDX) -t kathara/frr --push frr

bird-multi: create-builder base-multi
	$(BUILDX) -t kathara/bird --push bird

openbgpd-multi: create-builder base-multi
	$(BUILDX) -t kathara/openbgpd --push openbgpd

krill-multi: create-builder base-multi
	$(BUILDX) -t kathara/krill --push krill

routinator-multi: create-builder base-multi
	$(BUILDX) -t kathara/routinator --push routinator

rpki-client-multi: create-builder base-multi
	$(BUILDX) -t kathara/rpki-client --push rpki-client

rift-python-multi: create-builder base-multi
	$(BUILDX) -t kathara/rift-python --push rift-python

sdn-multi: create-builder base-multi
	$(BUILDX) -t kathara/sdn --push sdn

pox-multi: create-builder base-multi
	$(BUILDX) -t kathara/pox --push pox

p4-multi: create-builder base-multi
	$(BUILDX) -t kathara/p4 --push p4

scion-multi: create-builder base-multi
	$(BUILDX) -t kathara/scion --push scion

create-builder:
	docker buildx create --name kat-builder --use
	docker buildx inspect --bootstrap

delete-builder:
	docker buildx rm kat-builder
