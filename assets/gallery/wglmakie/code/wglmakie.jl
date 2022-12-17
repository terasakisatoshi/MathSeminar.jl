# This file was generated, do not modify it. # hide
using JSServe, WGLMakie
using WGLMakie: meshscatter!, wireframe!

"""
Write handler by yourself.
The Syntax is as same as one uses for Makie.jl plot
"""
app = App() do session::Session
    x = [2 .* (i/3) .* cos(i) for i in range(0, stop = 4π, length = 30)]
    y = [2 .* (i/3) .* sin(i) for i in range(0, stop = 4π, length = 30)]
    z = range(0, stop = 5, length = 30)

    fig = Figure(resolution=(1800, 500))
    ax1 = Axis3(fig[1,1])
    ax2 = Axis3(fig[1,2])
    p1 = meshscatter!(ax1, x, y, z, markersize = 0.5)
    p2 = wireframe!(ax2, Sphere(Point3f(0), 1f0))
    return session
end

#dir = joinpath(@__DIR__, "__site/gallery/wglmakie/wglmakie")
#!isdir(dir) && mkpath(dir)
#JSServe.export_standalone(app, joinpath(@OUTPUT, dir))