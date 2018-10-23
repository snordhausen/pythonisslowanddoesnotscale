.PHONY: build bench

build:
	docker build --pull=true --tag pisadns .
bench:
	./benchmark.sh
