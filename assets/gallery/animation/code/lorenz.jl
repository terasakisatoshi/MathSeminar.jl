# This file was generated, do not modify it. # hide
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

tspan = (0.0, 30.0)
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

anim = @animate for t ∈ range(0, 30, length = 2000)
    r = sol(t)
    push!(plt, r[1], r[2], r[3])
end every 10


gif(anim, joinpath(@OUTPUT, "lorenz.gif")) #hide