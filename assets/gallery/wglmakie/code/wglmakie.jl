# This file was generated, do not modify it. # hide
using JSServe, WGLMakie
using WGLMakie: to_colormap, meshscatter, vbox, wireframe
using WGLMakie: Point3f0, Sphere

"""
Write handler by yourself. 
The Syntax is as same as one uses for Makie.jl plot
"""
function handler(session, request)
    x = [2 .* (i/3) .* cos(i) for i in range(0, stop = 4π, length = 30)]
    y = [2 .* (i/3) .* sin(i) for i in range(0, stop = 4π, length = 30)]
    z = range(0, stop = 5, length = 30)
    p1 = meshscatter(x, y, z, markersize = 0.5, color = to_colormap(:blues, 30))
    p2 = wireframe(Sphere(Point3f0(0), 1f0))
    return vbox(p1, p2)
end

dir = joinpath(@__DIR__, "__site/gallery/wglmakie/wglmakie")
!isdir(dir) && mkpath(dir)
JSServe.export_standalone(handler, joinpath(@OUTPUT, dir))