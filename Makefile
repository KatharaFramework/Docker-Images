.PHONY: base quagga frr sdn

base:
	cd base && docker build -t kathara/base .

quagga: base
	cd quagga && docker build -t kathara/quagga .

frr: base
	cd frr && docker build -t kathara/frr .

sdn: base
	cd sdn && docker build -t kathara/sdn .
