FROM julia:1.5.0

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    curl \
    ca-certificates \
    xvfb \
    dvipng \
    texlive-latex-recommended  \
    zip \
    libxt6 libxrender1 libxext6 libgl1-mesa-glx libqt5widgets5 # GR && \
    apt-get clean && rm -rf /var/lib/apt/lists/* # clean up    

# Setup Rust
# Reference: https://github.com/rust-lang/rustup/issues/297
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH

ENV GKSwstype=100
ENV JULIA_NUM_THREADS=8

RUN mkdir -p ${HOME}/.julia/config && \
    echo '\
# Install Python and R via Conda \n\
ENV["R_HOME"]="*" \n\
ENV["PYTHON"]="" \n\
' >> ${HOME}/.julia/config/startup.jl && cat ${HOME}/.julia/config/startup.jl

RUN julia -e 'using Pkg; \
Pkg.add(["PyCall", "Conda"]); using PyCall, Conda;\
using Conda; Conda.add(["matplotlib", "sympy", "numpy", "numba" ]); \
Pkg.add(["Documenter", "Literate", "Weave", "Franklin", "NodeJS", "Remark"]); \
'

RUN julia -e "using NodeJS; run(\`\$(npm_cmd()) install highlight.js\`); using Franklin"

# Add conda's path
ENV PATH /root/.julia/conda/3/bin:$PATH

RUN	conda install r-base=3.4 && \
    julia -e 'using Pkg; pkg"add RCall"; Pkg.build("RCall"); using RCall'

# set "/work" as default project directory 
WORKDIR /work
ENV JULIA_PROJECT=/work

# Install Julia Package
RUN julia -e 'using Pkg; \
Pkg.add([\
    PackageSpec(name="Franklin", version="0.9.1"), \
    PackageSpec(name="OhMyREPL", version="0.5.5"), \
    PackageSpec(name="Revise", version="2.7.3"), \
    PackageSpec(name="Plots", version="1.5.8"), \
    PackageSpec(name="GR", version="0.51.0"), \
    PackageSpec(name="SymPy", version="1.0.27"), \
    PackageSpec(name="PyPlot", version="2.9.0"), \
    PackageSpec(name="TestImages", version="1.2.1"), \
    PackageSpec(name="ImageMagick", version="1.1.5"), \
]); \
Pkg.pin(["Franklin", "OhMyREPL", "Revise", "Plots", "GR", "SymPy", "PyPlot", "TestImages"]); \
using PyPlot, SymPy, TestImages ; testimage("c"); testimage("m"); \
'

COPY Project.toml /work
# Initialize Julia package using /work/Project.toml
RUN rm -f /work/Manifest.toml && julia --project=/work -e 'using Pkg; \
Pkg.instantiate(); \
Pkg.precompile()' && \
# Check Julia version \
julia -e 'using InteractiveUtils; versioninfo()'

# For Http Server
EXPOSE 8000

CMD ["julia"]
