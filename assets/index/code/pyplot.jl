# This file was generated, do not modify it. # hide
using Plots
pyplot()
Plots.plot(sin, title=L"y=\sin x")
Plots.savefig(joinpath(@OUTPUT, "pyplotbkend.png")) # hide
gr()