# # Hello from example.jl
# <!-- This is a comment-->

using Plots
Plots.plot(sin)
Plots.savefig(joinpath(@OUTPUT, "plot.png")) # hide

# \fig{plot}
