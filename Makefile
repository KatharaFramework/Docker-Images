.PHONY: base quagga frr sdn all pushall

all: base quagga frr sdn

pushall:
	docker push kathara/base
	docker push kathara/quagga
	docker push kathara/frr
	docker push kathara/sdn

base:
	cd base && docker build -t kathara/base .

quagga: base
	cd quagga && docker build -t kathara/quagga .

frr: base
	cd frr && docker build -t kathara/frr .

sdn: base
	cd sdn && docker build -t kathara/sdn .
