FROM julia:1.4.1

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
    libxt6 libxrender1 libxext6 libgl1-mesa-glx libqt5widgets5 # GR && \
    apt-get clean && rm -rf /var/lib/apt/lists/* # clean up    

RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3 && \
    pip3 install \
    matplotlib \
    numpy \
    sympy==1.5.* \
    numba

RUN mkdir -p ${HOME}/.julia/config && \
    echo '\
# set environment variables\n\
ENV["PYTHON"]=Sys.which("python3")\n\
#using OhMyREPL \n\
#atreplinit() do repl\n\
#    try\n\
#        @eval using Revise\n\
#        @async Revise.wait_steal_repl_backend()\n\
#    catch e\n\
#        @warn(e.msg)\n\
#    end\n\
#end\n\
#\n\
' >> ${HOME}/.julia/config/startup.jl && cat ${HOME}/.julia/config/startup.jl

# set "/work" as default project directory 
WORKDIR /work
ENV JULIA_PROJECT=/work

# Install Julia Package
RUN julia -E 'using Pkg; \
Pkg.add([\
    PackageSpec(name="OhMyREPL", version="0.5.5"), \
    PackageSpec(name="Revise", version="2.7.0"), \
    PackageSpec(name="Plots", version="1.3.3"), \
    PackageSpec(name="GR", version="0.49"), \
    PackageSpec(name="SymPy",version="1.0.20"), \
]); \
Pkg.pin(["OhMyREPL","Revise","Plots","GR","SymPy"]); \
Pkg.add("PackageCompiler"); \
Pkg.add(["Documenter", "Literate", "Weave", "Franklin", "NodeJS", "Remark"]); \
Pkg.add(["Plotly", "PlotlyJS", "ORCA"]); \
'

RUN julia -e "using NodeJS; run(\`\$(npm_cmd()) install highlight.js\`); using Franklin"

#RUN julia -e '\
#using PackageCompiler; \
#PackageCompiler.create_sysimage(\
#    [\
#     :Revise, :OhMyREPL, \
#     :Plots, :GR, :SymPy, \
#    ], \
#    replace_default=true); \
#'

COPY Project.toml /work
# Initialize Julia package using /work/Project.toml
RUN rm /work/Manifest.toml && julia --project=/work -e 'using Pkg; \
Pkg.instantiate(); \
Pkg.precompile()' && \
# Check Julia version \
julia -e 'using InteractiveUtils; versioninfo()'

ENV GKSwstype=100
ENV JULIA_NUM_THREADS=4
# For Http Server
EXPOSE 8000

CMD ["julia"]

