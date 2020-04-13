# This file was generated, do not modify it.

using Plots
Plots.plot(sin)
x = -π:0.01:π
y = sin.(x)
plot(x, y)
Plots.savefig(joinpath(@OUTPUT, "plot.png")) # hide

