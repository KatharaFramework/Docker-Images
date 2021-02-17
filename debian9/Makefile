.PHONY: base quagga frr sdn all pushall

all: base quagga frr sdn

pushall:
	docker push kathara/base:debian9
	docker push kathara/quagga:debian9
	docker push kathara/frr:debian9
	docker push kathara/sdn:debian9
	docker tag kathara/base:debian9 kathara/base:latest
	docker push kathara/base:latest
	docker tag kathara/quagga:debian9 kathara/quagga:latest
	docker push kathara/quagga:latest
	docker tag kathara/frr:debian9 kathara/frr:latest
	docker push kathara/frr:latest
	docker tag kathara/sdn:debian9 kathara/sdn:latest
	docker push kathara/sdn:latest


base:
	cd base && docker build -t kathara/base:debian9 .

quagga: base
	cd quagga && docker build -t kathara/quagga:debian9 .

frr: base
	cd frr && docker build -t kathara/frr:debian9 .

sdn: base
	cd sdn && docker build -t kathara/sdn:debian9 .
