# This file was generated, do not modify it. # hide
function plotcurve() # hide
θ = 0:0.01:2π
a = 2
n = 4
r = @. a*sin(n*θ)
x = @. r * cos(θ)
y = @. r * sin(θ)

eq = latexstring("r=a\\sin($n\\theta)")

p = plot(
    title = eq,
    xlabel = L"x",
    ylabel = L"y",
    aspect_ratio = :equal,
)

plot!(p, x, y, label = :false)
Plots.savefig(joinpath(@OUTPUT,"rose4.png")) #hide
end # hide
plotcurve() # hide