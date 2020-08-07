@def title = "WGLMakie.jl"

# WGLMakie.jl

- it's now basically possible to export standalone javascript from a Makie plot.
  - See [Franklin.jl's Issue 471](https://github.com/tlienart/Franklin.jl/issues/471)

- Here is my example that export JS from Makie plot:

```julia:wglmakie
using JSServe, WGLMakie
using AbstractPlotting: meshscatter, vbox, wireframe

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
!isdir(dir) && mkdir(dir)
JSServe.export_standalone(handler, joinpath(@OUTPUT, dir))
```

\output{wglmakie}

You can see the reuslt at [here](/gallery/wglmakie/wglmakie/index.html).
