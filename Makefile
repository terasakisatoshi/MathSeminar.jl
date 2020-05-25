.phony : all, pull build, slide, frankln, web, trace, clean

OS:=$(shell uname -s)

REMOTE_DOCKER_REPOSITORY=terasakisatoshi/mathseminarjl:latest

all: pull

pull:
	rm -f Manifest.toml
	docker pull ${REMOTE_DOCKER_REPOSITORY}
	docker tag ${REMOTE_DOCKER_REPOSITORY} mathseminarjl
	docker-compose run --rm julia julia -e 'using Pkg; Pkg.instantiate()'

build:
	rm -f Manifest.toml
	docker build -t mathseminarjl .
	docker-compose build
	docker-compose run --rm julia julia -e 'using Pkg; Pkg.instantiate()'

slide:
	docker-compose run --rm julia julia -e 'using Remark; Remark.slideshow("slideshow/tutorial/example.jl", "slideshow/tutorial")'
	docker-compose run --rm julia julia -e 'using Remark; Remark.slideshow("slideshow/juliatokai/document.jl", "slideshow/juliatokai")'

franklin:
	# serve web page without creating slide generated by Remark.jl
	docker-compose up franklin

web:
	# serve web page including creating slide generated by Remark.jl
	docker-compose run --rm web

trace:
	rm -f Manifest.toml
	docker build -t seminartrace -f _mytools/Dockerfile .
	docker run --rm -it -v ${PWD}:/work -w /work seminartrace julia -e 'using Pkg; Pkg.instantiate()'
	docker run --rm -it -v ${PWD}:/work -w /work seminartrace julia --trace-compile=./.statements/franklin.jl --project=@. -e 'using Franklin; serve()'

clean:
	docker-compose down
	rm -f  Manifest.toml # reset Manifest.toml
	rm -rf slideshow/src slideshow/build # assets generated by Remark.jl
	rm -rf __site # assets generated by Franklin.jl
