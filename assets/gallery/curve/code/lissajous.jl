# This file was generated, do not modify it. # hide
function plotcurve() # hide
θ = 0:0.01:2π
x = @. sin(θ)
y = @. sin(2θ)

eq = latexstring("y^2=4x^2(1-x^2)")

p = plot(
    title = eq,
    xlabel = L"x",
    ylabel = L"y",
    xlim = [-1, 1],
    ylim = [-1, 1],
    aspect_ratio = :equal,
)

plot!(p, x, y, label=false)
Plots.savefig(joinpath(@OUTPUT, "lissajous.png")) #hide
end # hide
plotcurve() # hide