@def title = "Animation"
@def hasmath = true
@def hascode = true

\csschapter{Animation}

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

gif(anim, joinpath(@OUTPUT, "heart.gif")) #hide
```

\fig{heart}


- This example is taken from [Solving System of Equations](https://docs.sciml.ai/latest/tutorials/ode_example/#Example-2:-Solving-Systems-of-Equations-1)

```julia:lorenz
using Plots
using DifferentialEquations

function lorenz!(du, u, p, t)
    du[1] = 10.0 * (u[2] - u[1])
    du[2] = u[1] * (28.0 - u[3]) - u[2]
    du[3] = u[1] * u[2] - (8 / 3) * u[3]
end

u0 = [
    1.0
    0.0
    0.0
]

tspan = (0.0, 100.0)
prob = ODEProblem(lorenz!, u0, tspan)
sol = solve(prob)

plot(sol, vars=(1,2,3))

plt = plot3d(
    1,
    xlim = (-20, 20),
    ylim = (-25, 25),
    zlim = (5, 45),
    legend = :false,
)

anim = @animate for t ∈ range(0, 50, length = 4000)
    r = sol(t)
    push!(plt, r[1], r[2], r[3])
end every 10

gif(anim, joinpath(@OUTPUT, "lorenz.gif")) #hide
```

\fig{lorenz}
