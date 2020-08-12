@def title = "RCall.jl"

- Let's test out RCall.jl

```julia:prepareRCall
using RCall
```

```julia
using Plots
pyplot()

xJ =  rand(3) 
@show xJ
@rput xJ
R"x <- 2*xJ"
xR =  convert(Array{Float64}, R"x")
@show xR
plot(xJ)
plot!(xR)
Plots.savefig(joinpath(@OUTPUT, "rcall.svg")) # hide
gr() # hide
```

