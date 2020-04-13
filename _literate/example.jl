# # Hello from example.jl
# <!-- This is a comment-->

using Plots
Plots.plot(sin)
x = -π:0.01:π
y = sin.(x)
plot(x, y)
Plots.savefig(joinpath(@OUTPUT, "plot.png")) # hide

# <!-- To show the result, we need state \fig command -->
# \fig{plot}
