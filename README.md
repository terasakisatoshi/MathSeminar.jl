[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/terasakisatoshi/MathSeminar.jl)

![Build and Deploy](https://github.com/terasakisatoshi/MathSeminar.jl/workflows/Build%20and%20Deploy/badge.svg)

# MathSeminar.jl

- My website https://terasakisatoshi.github.io/MathSeminar.jl/ that utilizes [Franklin.jl](https://franklinjl.org/) (>=v0.8)

# How to build my page

## Case1: using Julia

- Run the following command

```julia
$ julia --project=@.
julia> using Pkg; Pkg.instantiate()
julia> using Franklin; serve()
```

- You can see the result via your web browser via http://localhost:8000

## Case2: using Docker container

- If you hesitate to create environment related to Julia. we recommend using Docker containers technique to create Julia's environment. You do not have to install Julia locally and keep clean your development environment.

1. Install Docker and Docker Compose
2. Run the following command:

```console
$ make build
$ make web
```

which is almost same as

```console
$ docker-compose build
$ docker-compose run --rm julia julia -e 'using Pkg; Pkg.instantiate()'
$ docker-compose up web
```

- It builds docker image, creates docker container, also initialize HTTP server inside of the docker container. You can see the result via your web browser via http://localhost:8000

