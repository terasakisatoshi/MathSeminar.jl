# This file was generated, do not modify it. # hide
using Plots
gr()

xJ =  rand(4) 
@show xJ
@rput xJ
R"x <- 2*xJ"
xR =  convert(Array{Float64}, R"x")
@show xR
plot(xJ)
plot!(xR)
Plots.savefig(joinpath(@OUTPUT, "twice.png")) # hide