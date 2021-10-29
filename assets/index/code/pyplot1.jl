# This file was generated, do not modify it. # hide
import PyPlot
PyPlot.figure(figsize=(8, 6))
x = range(-2, 2, length=500)
for α in 1:5
    PyPlot.plot(x, sinc.(α .* x))
end
PyPlot.savefig(joinpath(@OUTPUT, "sinc.png")) # hide