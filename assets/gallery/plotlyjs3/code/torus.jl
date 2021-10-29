# This file was generated, do not modify it. # hide
using Plots
plotlyjs()

a=3.

p = plot3d()
N = 45
u = range(0,2π,length=N)
for t in range(0,2π,length=N)
    x = @. cos(t) * (a + cos(u))
    y = @. sin(t) * (a + cos(u))
    z = @. sin(u)
    plot3d!(p, x, y, z, color=:blue, legend=false)
end

t=range(0,2π,length=N)
for u in range(0,2π,length=N)
    x = @. cos(t) * (a + cos(u))
    y = @. sin(t) * (a + cos(u))
    z = sin(u) * ones(length(x))
    plot3d!(p, x, y, z, color=:blue, legend=false)
end

fdplotly(p)
gr() # hide