# This file was generated, do not modify it. # hide
using Plots
gr()
using LaTeXStrings
Plots.plot(rand(10), title=L"\alpha", xlabel=L"x", ylabel=L"y")
Plots.savefig(joinpath(@OUTPUT, "grplot.png")) # hide