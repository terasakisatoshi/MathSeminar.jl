.phony : all, build, web, clean

OS:=$(shell uname -s)

all: build

build:
	rm -f Manifest.toml
	docker-compose build
	docker-compose run --rm julia julia --project=/work -e 'using Pkg; Pkg.instantiate()'

clean:
	docker-compose down
	rm -f  Manifest.toml
	rm -rf __site
