# This file was generated, do not modify it. # hide
function plotcurve() #hide
θ = 0:0.01:2π
a = 2
x = @. a * cos(θ)^3
y = @. a * sin(θ)^3

eq = latexstring("x^{2/3}+y^{2/3} = $a^{2/3}")

p = plot(
    title = eq,
    xlabel = L"x",
    ylabel = L"y",
    xlim = [-2, 2],
    ylim = [-2, 2],
    aspect_ratio = :equal,
)

plot!(p, x, y, label = :false)
Plots.savefig(joinpath(@OUTPUT, "astroid.png")) #hide
end # hide
plotcurve() # hide