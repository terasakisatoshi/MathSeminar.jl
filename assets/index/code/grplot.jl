# This file was generated, do not modify it. # hide
using Plots
using LaTeXStrings
Plots.plot(rand(10), xlabel=L"x", ylabel=L"y")
Plots.savefig(joinpath(@OUTPUT, "grplot.svg")) # hide