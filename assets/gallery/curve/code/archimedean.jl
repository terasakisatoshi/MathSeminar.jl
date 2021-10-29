# This file was generated, do not modify it. # hide
function plotcurve() # hide
θ = 0:0.01:2π
a = 2
r = @. a*θ
x = @. r * cos(θ)
y = @. r * sin(θ)

eq = L"r=a\theta"

p = plot(
    title = eq,
    xlabel = L"x",
    ylabel = L"y",
    aspect_ratio = :equal,
)

plot!(p, x, y, label = :false)
Plots.savefig(joinpath(@OUTPUT, "archimedean.png")) #hide
end #hide
plotcurve() # hide