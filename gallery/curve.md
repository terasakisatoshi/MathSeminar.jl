@def title = "Curves"
@def hascode = true

```julia:prepare
using Plots
pyplot()
using LaTeXStrings
using LaTeXStrings: latexstring
```

# Circle


```julia:circle
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
Plots.savefig(joinpath(@OUTPUT, "circle.svg")) #hide

end # hide
plotcurve() # hide
```

\fig{circle.svg}

# Astroid


```julia:astroid
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
```

\fig{astroid.png}

# Lissajous

```julia:lissajous
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
```

\fig{lissajous}

# Archimedean Spiral


```julia:archimedean
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
```

\fig{archimedean}

# Cardioid


```julia:cardioid
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
```

\fig{cardioid}

# Rose Curve

## n = 2


```julia:rose2
function plotcurve() #hide
θ = 0:0.01:2π
a = 2
n = 2
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
Plots.savefig(joinpath(@OUTPUT, "rose2.png")) #hide
end # hide
plotcurve() # hide
```

\fig{rose2}


## n = 3


```julia:rose3
function plotcurve() # hide
θ = 0:0.01:2π
a = 2
n = 3
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

plot!(p, x, y, label=false)
Plots.savefig(joinpath(@OUTPUT,"rose3.png")) #hide
end # hide
plotcurve() # hide
```

\fig{rose3}

## n = 4


```julia:rose4
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
```

\fig{rose4.png}

## Rose (gif)


```julia:roses
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
```

\fig{roses.gif}
