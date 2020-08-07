# This file was generated, do not modify it. # hide
function plotcurve() # hide
θ = 0:0.01:2π
a = 2
r = @. a*(1+cos(θ))
x = @. r * cos(θ)
y = @. r * sin(θ)

eq = L"r=a(1+\cos(\theta))"

p = plot(
    title = eq,
    xlabel = L"x",
    ylabel = L"y",
    aspect_ratio = :equal,
)

plot!(p, x, y, label = :false)
Plots.savefig(joinpath(@OUTPUT, "cardioid.png")) #hide
end #hide
plotcurve() # hide