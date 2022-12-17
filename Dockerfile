FROM julia:1.8.3

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
ENV R_HOME="*"
ENV PYTHON=""

RUN julia -e 'using Pkg; \
Pkg.add(["PyCall", "Conda"]); using PyCall, Conda;\
using Conda; Conda.add(["matplotlib", "sympy", "numpy", "numba" ]); \
Pkg.add(["Documenter", "Literate", "Weave", "Franklin", "NodeJS", "Remark"]); \
'

RUN julia -e "using NodeJS; run(\`\$(npm_cmd()) install highlight.js\`); using Franklin"

# Add conda's path
ENV PATH /root/.julia/conda/3/bin:$PATH

#RUN	conda install r-base && \
#    julia -e 'using Pkg; pkg"add RCall"; Pkg.build("RCall"); using RCall'

# set "/work" as default project directory 
WORKDIR /work
ENV JULIA_PROJECT=/work

# Install Julia Package
COPY Project.toml /work
COPY ./src/MyUtils.jl /work/src/MyUtils.jl

# Initialize Julia package using /work/Project.toml
RUN rm -f /work/Manifest.toml && julia --project=/work -e 'using Pkg; \
Pkg.instantiate(); \
Pkg.precompile()' && \
# Check Julia version \
julia -e 'using InteractiveUtils; versioninfo()'

# For Http Server
EXPOSE 8000

CMD ["julia"]
