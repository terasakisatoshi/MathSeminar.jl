# This file was generated, do not modify it. # hide
function plotcurve() # hide
θ = 0:0.01:2π
a = 2
anim = @animate for n in 2:10
    r = @. a*sin(n*θ)
    x = @. r * cos(θ)
    y = @. r * sin(θ)

    eq = latexstring("r=a\\sin($n\\theta)")

    p = plot(
        title = eq,
        xlabel = L"x",
        ylabel = L"y",
        xlim=[-3,3],
        ylim=[-3,3],
        aspect_ratio = :equal,
    )

    plot!(p, x, y, label = :false)
end

gif(anim, joinpath(@OUTPUT,"roses.gif"), fps=2)
end # hide
plotcurve() # hide