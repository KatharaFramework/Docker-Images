.PHONY: base quagga frr sdn linux-build

base:
	cd base && docker build -t kathara/base .

quagga: base
	cd quagga && docker build -t kathara/quagga .

frr: base
	cd frr && docker build -t kathara/frr .

sdn: base
	cd sdn && docker build -t kathara/sdn .

linux-build:
	cd Linux-Build && docker build -t kathara/linux-build .
