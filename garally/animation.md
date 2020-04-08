@def title = "Animation"
@def hasmath = true
@def hascode = true

\chapter{Animation}

- This example is taken from [Plots.jl Animations](https://docs.juliaplots.org/latest/animations/)

```julia:gifplot
using Plots

@userplot CirclePlot
@recipe function f(cp::CirclePlot)
    x, y, i = cp.args
    n = length(x)
    inds = circshift(1:n, 1 - i)
    linewidth --> range(0, 10, length = n)
    seriesalpha --> range(0, 1, length = n)
    aspect_ratio --> 1
    label --> false
    x[inds], y[inds]
end

n = 400
t = range(0, 2π, length = n)
x = 16sin.(t).^3
y = 13cos.(t) .- 5cos.(2t) .- 2cos.(3t) .- cos.(4t)
anim = @animate for i ∈ 1:n
    circleplot(x, y, i, line_z = 1:n, cbar = false, c = :reds, framestyle = :none)
end when i > 40 && mod1(i, 10) == 5

gif(anim, joinpath(@OUTPUT, "granim.gif")) #hide
```

\fig{granim}
