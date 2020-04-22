# This file was generated, do not modify it. # hide
using PyPlot
figure(figsize=(8, 6))
x = range(-2, 2, length=500)
for α in 1:4
    PyPlot.plot(x, @. sinc(α * x))
end
PyPlot.savefig(joinpath(@OUTPUT, "sinc.svg")) # hide