FROM julia:1.4.0

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-dev \
    python3-distutils \
    curl \
    ca-certificates \
    xvfb \
    dvipng \
    texlive-latex-recommended  \
    zip \
    libxt6 libxrender1 libxext6 libgl1-mesa-glx libqt5widgets5 # GR

RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3 && \
    pip3 install \
    matplotlib \
    numpy \
    numba

RUN mkdir -p ${HOME}/.julia/config && \
    echo '\
# set environment variables\n\
ENV["PYTHON"]=Sys.which("python3")\n\
\n\
import Pkg\n\
let\n\
    pkgs = ["Revise","OhMyREPL"]\n\
    for pkg in pkgs\n\
        if Base.find_package(pkg) === nothing\n\
            Pkg.add(pkg)\n\
        end\n\
    end\n\
end\n\
using OhMyREPL \n\
atreplinit() do repl\n\
    try\n\
        @eval using Revise\n\
        @async Revise.wait_steal_repl_backend()\n\
    catch e\n\
        @warn(e.msg)\n\
    end\n\
end\n\
\n\
' >> ${HOME}/.julia/config/startup.jl && cat ${HOME}/.julia/config/startup.jl

# Install Julia Package
RUN julia -e 'using Pkg; Pkg.add(["Franklin", "Literate", "Remark"]); Pkg.precompile()'
# set "/work" as default project directory 
WORKDIR /work
ENV JULIA_PROJECT=/work

COPY Project.toml /work
# Initialize Julia package using /work/Project.toml
RUN julia --project=/work -e 'using Pkg;\
Pkg.instantiate();\
Pkg.precompile()' && \
# Check Julia version \
julia -e 'using InteractiveUtils; versioninfo()'

ENV GKSwstype=100

# For Http Server
EXPOSE 8000

CMD ["julia"]

