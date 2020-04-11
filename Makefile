.phony : all, build, clean, slide

OS:=$(shell uname -s)

all: build

build:
	rm -f Manifest.toml
	docker-compose build
	docker-compose run --rm julia julia -e 'using Pkg; Pkg.instantiate()'

slide:
	docker-compose run --rm julia julia -e 'using Remark; Remark.slideshow("remark/example.jl","remark")'

web:
	docker-compose up web

clean:
	docker-compose down
	rm -f  Manifest.toml
	rm -rf __site
