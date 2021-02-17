.PHONY: base quagga frr sdn all pushall

all: base quagga frr sdn

pushall:
	docker push kathara/base:debian10
	docker push kathara/quagga:debian10
	docker push kathara/frr:debian10
	docker push kathara/sdn:debian10

base:
	cd base && docker build -t kathara/base:debian10 .

quagga: base
	cd quagga && docker build -t kathara/quagga:debian10 .

frr: base
	cd frr && docker build -t kathara/frr:debian10 .

sdn: base
	cd sdn && docker build -t kathara/sdn:debian10 .
