# This file was generated, do not modify it. # hide
function plotcurve() # hide
θ = 0:0.01:2π
x = @. cos(θ)
y = @. sin(θ)

p = plot(
    xlabel = L"x",
    ylabel = L"y",
    xlim = [-1, 1],
    ylim = [-1, 2],
    aspect_ratio = :equal,
)

plot!(p, x, y, label = L"x^2+y^2 = 1")
Plots.savefig(joinpath(@OUTPUT, "circle.png")) #hide

end # hide
plotcurve() # hide